package com.vocab.controller;

import com.vocab.dto.request.AnswerRequest;
import com.vocab.dto.request.CreateRoomRequest;
import com.vocab.dto.response.RoomStateResponse;
import com.vocab.room.ActiveRoom;
import com.vocab.security.UserPrincipal;
import com.vocab.service.ActivityLogService;
import com.vocab.service.RoomService;
import com.vocab.util.IpUtils;
import jakarta.servlet.http.HttpServletRequest;
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
    private final ActivityLogService activityLogService;

    @PostMapping
    public ResponseEntity<Map<String, String>> createRoom(
            @RequestBody CreateRoomRequest req,
            @AuthenticationPrincipal UserPrincipal principal,
            HttpServletRequest request) {
        ActiveRoom room = roomService.createRoom(principal.getId(), principal.getUsername(), req);
        activityLogService.log(principal.getId(), principal.getUsername(), "ROOM_CREATED",
            "Tạo phòng quiz #" + room.getCode() + " (" + req.getQuestionCount() + " câu)",
            IpUtils.getIp(request));
        return ResponseEntity.ok(Map.of("code", room.getCode()));
    }

    @PostMapping("/{code}/join")
    public ResponseEntity<Void> joinRoom(
            @PathVariable String code,
            @AuthenticationPrincipal UserPrincipal principal,
            HttpServletRequest request) {
        roomService.joinRoom(code, principal.getId(), principal.getUsername());
        activityLogService.log(principal.getId(), principal.getUsername(), "ROOM_JOINED",
            "Vào phòng quiz #" + code, IpUtils.getIp(request));
        return ResponseEntity.ok().build();
    }

    @PostMapping("/{code}/spectate")
    public ResponseEntity<Void> spectateRoom(
            @PathVariable String code,
            @AuthenticationPrincipal UserPrincipal principal,
            HttpServletRequest request) {
        roomService.spectateRoom(code, principal.getId(), principal.getUsername());
        activityLogService.log(principal.getId(), principal.getUsername(), "ROOM_SPECTATE",
            "Xem phòng quiz #" + code, IpUtils.getIp(request));
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

    @PostMapping("/{code}/answer/typed")
    public ResponseEntity<Map<String, Boolean>> submitTypedAnswer(
            @PathVariable String code,
            @RequestBody Map<String, String> body,
            @AuthenticationPrincipal UserPrincipal principal) {
        boolean correct = roomService.submitTypedAnswer(code, principal.getId(), body.get("typedWord"));
        return ResponseEntity.ok(Map.of("correct", correct));
    }

    @GetMapping("/{code}/state")
    public ResponseEntity<RoomStateResponse> getState(
            @PathVariable String code,
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(roomService.getState(code, principal.getId()));
    }
}
