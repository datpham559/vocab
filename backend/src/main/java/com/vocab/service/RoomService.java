package com.vocab.service;

import com.vocab.dto.request.CreateRoomRequest;
import com.vocab.dto.response.QuizQuestionResponse;
import com.vocab.dto.response.RoomStateResponse;
import com.vocab.entity.Word;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.WordRepository;
import com.vocab.room.ActiveRoom;
import com.vocab.room.RoomStatus;
import com.vocab.room.RoomStore;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RoomService {

    private final RoomStore roomStore;
    private final WordRepository wordRepository;
    private final QuizService quizService;

    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(5);

    public ActiveRoom createRoom(Long userId, String userName, CreateRoomRequest req) {
        String code = generateCode();
        ActiveRoom room = new ActiveRoom(code, userId);
        room.getParticipants().put(userId, userName);
        room.getScores().put(userId, 0);
        String mode = (req.getQuizMode() != null && List.of("CHOICE","TYPE","MIXED").contains(req.getQuizMode()))
            ? req.getQuizMode() : "CHOICE";
        room.setQuizMode(mode);
        if (req.getBeginnerCount() != null || req.getIntermediateCount() != null || req.getAdvancedCount() != null) {
            int b = clamp(req.getBeginnerCount(), 0, 20);
            int i = clamp(req.getIntermediateCount(), 0, 20);
            int a = clamp(req.getAdvancedCount(), 0, 20);
            int total = Math.min(b + i + a, 50);
            room.setQuestionCount(Math.max(1, total));
            room.setBeginnerCount(b);
            room.setIntermediateCount(i);
            room.setAdvancedCount(a);
            // Per-difficulty question modes (only meaningful when quizMode=MIXED)
            room.setBeginnerMode(resolveMode(req.getBeginnerMode()));
            room.setIntermediateMode(resolveMode(req.getIntermediateMode()));
            room.setAdvancedMode(resolveMode(req.getAdvancedMode()));
        } else {
            room.setQuestionCount(Math.max(10, Math.min(30, req.getQuestionCount())));
        }
        roomStore.put(code, room);
        return room;
    }

    private int clamp(Integer val, int min, int max) {
        if (val == null) return 0;
        return Math.max(min, Math.min(max, val));
    }

    private String resolveMode(String mode) {
        return (mode != null && List.of("CHOICE", "TYPE", "MIXED").contains(mode)) ? mode : "MIXED";
    }

    /** Determines the final question mode (CHOICE or TYPE) for a single question. */
    private String resolveQuestionMode(ActiveRoom room, String difficulty, Random rng) {
        if (!"MIXED".equals(room.getQuizMode())) {
            return room.getQuizMode(); // CHOICE or TYPE — uniform for all questions
        }
        // Global mode is MIXED — check per-difficulty override
        String diffMode;
        if ("BEGINNER".equalsIgnoreCase(difficulty)) diffMode = room.getBeginnerMode();
        else if ("ADVANCED".equalsIgnoreCase(difficulty)) diffMode = room.getAdvancedMode();
        else diffMode = room.getIntermediateMode();

        if ("CHOICE".equals(diffMode)) return "CHOICE";
        if ("TYPE".equals(diffMode)) return "TYPE";
        return rng.nextBoolean() ? "CHOICE" : "TYPE"; // MIXED = random
    }

    public void joinRoom(String code, Long userId, String userName) {
        ActiveRoom room = getRoom(code);
        if (room.getStatus() == RoomStatus.DONE) {
            throw new IllegalStateException("Game already ended");
        }
        room.getParticipants().putIfAbsent(userId, userName);
        room.getScores().putIfAbsent(userId, 0);
    }

    public void startGame(String code, Long userId) {
        ActiveRoom room = getRoom(code);
        if (!room.getHostId().equals(userId)) {
            throw new IllegalStateException("Only host can start");
        }
        if (room.getStatus() != RoomStatus.WAITING) {
            throw new IllegalStateException("Game already started");
        }
        List<QuizQuestionResponse> questions = loadQuestions(room);
        room.setQuestions(questions);
        // Assign per-question modes
        Random rng = new Random();
        List<String> modes = new ArrayList<>();
        for (QuizQuestionResponse q : questions) {
            String effectiveMode = resolveQuestionMode(room, q.getDifficulty(), rng);
            modes.add(effectiveMode);
        }
        room.setQuestionModes(modes);
        // Start 3-second countdown before first question
        room.setStatus(RoomStatus.COUNTDOWN);
        room.setCountdownLeft(3);
        scheduleCountdown(room);
    }

    private void scheduleCountdown(ActiveRoom room) {
        scheduler.schedule(() -> {
            int remaining = room.getCountdownLeft() - 1;
            room.setCountdownLeft(remaining);
            if (remaining <= 0) {
                startQuestion(room, 0);
            } else {
                scheduleCountdown(room);
            }
        }, 1, TimeUnit.SECONDS);
    }

    private void startQuestion(ActiveRoom room, int index) {
        room.setCurrentQuestionIndex(index);
        room.setQuestionStartTime(System.currentTimeMillis());
        room.setStatus(RoomStatus.ACTIVE);
        room.getCurrentAnswers().clear();
        room.getAnswerTimestamps().clear();
        room.getLastEarned().clear();
        room.getQuestionEnded().set(false);

        ScheduledFuture<?> timer = scheduler.schedule(
            () -> onQuestionEnd(room),
            room.getTimePerQuestion(),
            TimeUnit.SECONDS
        );
        room.setTimer(timer);
    }

    public void submitAnswer(String code, Long userId, int selectedIndex) {
        ActiveRoom room = getRoom(code);
        if (room.getStatus() != RoomStatus.ACTIVE) return;
        if (!room.getParticipants().containsKey(userId)) return;

        if (room.getCurrentAnswers().putIfAbsent(userId, selectedIndex) == null) {
            room.getAnswerTimestamps().put(userId, System.currentTimeMillis());
        }

        if (room.getCurrentAnswers().size() >= room.getParticipants().size()) {
            ScheduledFuture<?> t = room.getTimer();
            if (t != null) t.cancel(false);
            onQuestionEnd(room);
        }
    }

    /** Typing-mode answer submission. Returns true if correct (so frontend can show feedback). */
    public boolean submitTypedAnswer(String code, Long userId, String typedWord) {
        ActiveRoom room = getRoom(code);
        if (room.getStatus() != RoomStatus.ACTIVE) return false;
        if (!room.getParticipants().containsKey(userId)) return false;
        if (room.getCurrentAnswers().containsKey(userId)) return false; // already answered correctly

        QuizQuestionResponse q = room.getQuestions().get(room.getCurrentQuestionIndex());
        boolean correct = typedWord != null && typedWord.trim().equalsIgnoreCase(q.getWord());

        int answerToRecord = correct ? q.getCorrectIndex() : -1;
        if (room.getCurrentAnswers().putIfAbsent(userId, answerToRecord) == null) {
            room.getAnswerTimestamps().put(userId, System.currentTimeMillis());
        }
        if (room.getCurrentAnswers().size() >= room.getParticipants().size()) {
            ScheduledFuture<?> t = room.getTimer();
            if (t != null) t.cancel(false);
            onQuestionEnd(room);
        }
        return correct;
    }

    private void onQuestionEnd(ActiveRoom room) {
        if (!room.getQuestionEnded().compareAndSet(false, true)) return;

        QuizQuestionResponse q = room.getQuestions().get(room.getCurrentQuestionIndex());
        long questionStart = room.getQuestionStartTime();
        long timeLimitMs = room.getTimePerQuestion() * 1000L;
        room.getLastEarned().clear();
        room.getCurrentAnswers().forEach((userId, answer) -> {
            if (answer == q.getCorrectIndex()) {
                long elapsed = room.getAnswerTimestamps().getOrDefault(userId, questionStart + timeLimitMs) - questionStart;
                elapsed = Math.max(0, Math.min(elapsed, timeLimitMs));
                int earned = (int) Math.max(500, Math.round(1000 - (elapsed * 500.0 / timeLimitMs)));
                room.getScores().merge(userId, earned, Integer::sum);
                room.getLastEarned().put(userId, earned);
            } else {
                room.getLastEarned().put(userId, 0);
            }
        });

        room.setStatus(RoomStatus.SHOWING_RESULT);

        scheduler.schedule(() -> {
            int next = room.getCurrentQuestionIndex() + 1;
            if (next >= room.getQuestions().size()) {
                room.setStatus(RoomStatus.DONE);
            } else {
                startQuestion(room, next);
            }
        }, 3, TimeUnit.SECONDS);
    }

    public RoomStateResponse getState(String code, Long userId) {
        ActiveRoom room = getRoom(code);

        List<RoomStateResponse.ParticipantScore> participants = room.getParticipants().entrySet().stream()
            .map(e -> new RoomStateResponse.ParticipantScore(
                e.getKey(),
                e.getValue(),
                room.getScores().getOrDefault(e.getKey(), 0),
                e.getKey().equals(room.getHostId())
            ))
            .sorted(Comparator.comparingInt(RoomStateResponse.ParticipantScore::getScore).reversed())
            .collect(Collectors.toList());

        QuizQuestionResponse currentQ = null;
        Integer correctIndex = null;
        Integer myAnswer = room.getCurrentAnswers().get(userId);
        Integer myLastEarned = room.getLastEarned().get(userId);
        String currentQuestionMode = "CHOICE";
        String correctMeaning = null;

        if (room.getStatus() == RoomStatus.ACTIVE || room.getStatus() == RoomStatus.SHOWING_RESULT) {
            if (!room.getQuestions().isEmpty() && room.getCurrentQuestionIndex() < room.getQuestions().size()) {
                QuizQuestionResponse raw = room.getQuestions().get(room.getCurrentQuestionIndex());
                if (!room.getQuestionModes().isEmpty() && room.getCurrentQuestionIndex() < room.getQuestionModes().size()) {
                    currentQuestionMode = room.getQuestionModes().get(room.getCurrentQuestionIndex());
                }
                if ("TYPE".equals(currentQuestionMode)) {
                    correctMeaning = raw.getOptions().get(raw.getCorrectIndex());
                }
                if (room.getStatus() == RoomStatus.SHOWING_RESULT) {
                    correctIndex = raw.getCorrectIndex();
                    currentQ = raw; // reveal full question on result
                } else {
                    // ACTIVE: sanitize — never expose correctIndex or the answer word
                    boolean isType = "TYPE".equals(currentQuestionMode);
                    currentQ = QuizQuestionResponse.builder()
                        .wordId(raw.getWordId())
                        .word(isType ? maskWord(raw.getWord()) : raw.getWord())
                        .pronunciation(isType ? null : raw.getPronunciation())
                        .options(isType ? null : raw.getOptions())
                        .correctIndex(-1)
                        .partOfSpeech(raw.getPartOfSpeech())
                        .difficulty(raw.getDifficulty())
                        .build();
                }
            }
        }

        return RoomStateResponse.builder()
            .code(code)
            .status(room.getStatus().name())
            .hostId(room.getHostId())
            .participants(participants)
            .currentQuestion(currentQ)
            .questionIndex(room.getCurrentQuestionIndex())
            .totalQuestions(room.getQuestions().size())
            .timeLeft(room.getTimeLeft())
            .correctIndex(correctIndex)
            .myAnswer(myAnswer)
            .myLastEarned(myLastEarned)
            .answeredCount(room.getCurrentAnswers().size())
            .questionCount(room.getQuestionCount())
            .countdownLeft(room.getCountdownLeft())
            .quizMode(room.getQuizMode())
            .currentQuestionMode(currentQuestionMode)
            .correctMeaning(correctMeaning)
            .beginnerCount(room.getBeginnerCount())
            .intermediateCount(room.getIntermediateCount())
            .advancedCount(room.getAdvancedCount())
            .beginnerMode(room.getBeginnerMode())
            .intermediateMode(room.getIntermediateMode())
            .advancedMode(room.getAdvancedMode())
            .build();
    }

    /** Masks a word for TYPE mode during ACTIVE: keeps first letter, spaces, hyphens; replaces rest with '_'. */
    private String maskWord(String word) {
        if (word == null || word.isEmpty()) return word;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            sb.append((i == 0 || c == ' ' || c == '-') ? c : '_');
        }
        return sb.toString();
    }

    private ActiveRoom getRoom(String code) {
        return roomStore.get(code)
            .orElseThrow(() -> new ResourceNotFoundException("Room not found: " + code));
    }

    private List<QuizQuestionResponse> loadQuestions(ActiveRoom room) {
        int bCount, iCount, aCount;
        if (room.getBeginnerCount() + room.getIntermediateCount() + room.getAdvancedCount() > 0) {
            bCount = room.getBeginnerCount();
            iCount = room.getIntermediateCount();
            aCount = room.getAdvancedCount();
        } else {
            int count = room.getQuestionCount();
            bCount = (int) Math.round(count * 0.4);
            aCount = (int) Math.round(count * 0.2);
            iCount = count - bCount - aCount;
        }
        List<Word> all = new ArrayList<>();
        if (bCount > 0) all.addAll(wordRepository.findRandomByDifficulty("BEGINNER", bCount));
        if (iCount > 0) all.addAll(wordRepository.findRandomByDifficulty("INTERMEDIATE", iCount));
        if (aCount > 0) all.addAll(wordRepository.findRandomByDifficulty("ADVANCED", aCount));
        Collections.shuffle(all);
        return quizService.generateQuizForWords(all);
    }

    private String generateCode() {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        Random random = new Random();
        String code;
        do {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < 6; i++) sb.append(chars.charAt(random.nextInt(chars.length())));
            code = sb.toString();
        } while (roomStore.get(code).isPresent());
        return code;
    }
}
