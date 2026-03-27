package com.vocab.service;

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

    public ActiveRoom createRoom(Long userId, String userName, int questionCount) {
        String code = generateCode();
        ActiveRoom room = new ActiveRoom(code, userId);
        room.getParticipants().put(userId, userName);
        room.getScores().put(userId, 0);
        room.setQuestionCount(Math.max(10, Math.min(30, questionCount)));
        roomStore.put(code, room);
        return room;
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
        List<QuizQuestionResponse> questions = loadQuestions(room.getQuestionCount());
        room.setQuestions(questions);
        startQuestion(room, 0);
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

        if (room.getStatus() == RoomStatus.ACTIVE || room.getStatus() == RoomStatus.SHOWING_RESULT) {
            if (!room.getQuestions().isEmpty() && room.getCurrentQuestionIndex() < room.getQuestions().size()) {
                currentQ = room.getQuestions().get(room.getCurrentQuestionIndex());
                if (room.getStatus() == RoomStatus.SHOWING_RESULT) {
                    correctIndex = currentQ.getCorrectIndex();
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
            .build();
    }

    private ActiveRoom getRoom(String code) {
        return roomStore.get(code)
            .orElseThrow(() -> new ResourceNotFoundException("Room not found: " + code));
    }

    private List<QuizQuestionResponse> loadQuestions(int count) {
        int bCount = (int) Math.round(count * 0.4);
        int aCount = (int) Math.round(count * 0.2);
        int iCount = count - bCount - aCount;

        List<Word> all = new ArrayList<>();
        all.addAll(wordRepository.findRandomByDifficulty("BEGINNER", bCount));
        all.addAll(wordRepository.findRandomByDifficulty("INTERMEDIATE", iCount));
        all.addAll(wordRepository.findRandomByDifficulty("ADVANCED", aCount));
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
