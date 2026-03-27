package com.vocab.controller;

import com.vocab.dto.request.AnswerRequest;
import com.vocab.dto.request.CreateRoomRequest;
import com.vocab.dto.response.RoomStateResponse;
import com.vocab.room.ActiveRoom;
import com.vocab.security.UserPrincipal;
import com.vocab.service.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/room")
@RequiredArgsConstructor
public class RoomController {

    private final RoomService roomService;

    @PostMapping
    public ResponseEntity<Map<String, String>> createRoom(
            @RequestBody CreateRoomRequest req,
            @AuthenticationPrincipal UserPrincipal principal) {
        ActiveRoom room = roomService.createRoom(
            principal.getId(), principal.getUsername(), req.getQuestionCount()
        );
        return ResponseEntity.ok(Map.of("code", room.getCode()));
    }

    @PostMapping("/{code}/join")
    public ResponseEntity<Void> joinRoom(
            @PathVariable String code,
            @AuthenticationPrincipal UserPrincipal principal) {
        roomService.joinRoom(code, principal.getId(), principal.getUsername());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/{code}/start")
    public ResponseEntity<Void> startGame(
            @PathVariable String code,
            @AuthenticationPrincipal UserPrincipal principal) {
        roomService.startGame(code, principal.getId());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/{code}/answer")
    public ResponseEntity<Void> submitAnswer(
            @PathVariable String code,
            @RequestBody AnswerRequest req,
            @AuthenticationPrincipal UserPrincipal principal) {
        roomService.submitAnswer(code, principal.getId(), req.getSelectedIndex());
        return ResponseEntity.ok().build();
    }

    @GetMapping("/{code}/state")
    public ResponseEntity<RoomStateResponse> getState(
            @PathVariable String code,
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(roomService.getState(code, principal.getId()));
    }
}
