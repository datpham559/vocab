package com.vocab.websocket;

import com.vocab.room.ActiveRoom;
import com.vocab.room.RoomStore;
import com.vocab.security.UserPrincipal;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;

import java.security.Principal;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class RoomChatController {

    private final SimpMessagingTemplate messagingTemplate;
    private final RoomStore roomStore;

    @Getter @Setter
    static class ChatInput { private String text; }

    @Getter @Setter
    static class ReactInput { private String emoji; }

    @MessageMapping("/room/{code}/chat")
    public void handleChat(@DestinationVariable String code,
                           @Payload ChatInput payload,
                           Principal principal) {
        UserPrincipal user = extractUser(principal);
        if (user == null) return;
        String text = payload.getText();
        if (text == null || text.isBlank() || text.length() > 200) return;

        boolean isSpectator = isSpectator(code, user.getId());
        RoomEvent event = RoomEvent.builder()
                .type("CHAT")
                .userId(user.getId())
                .username(user.getUsername())
                .text(text.trim())
                .timestamp(System.currentTimeMillis())
                .spectator(isSpectator)
                .build();
        messagingTemplate.convertAndSend("/topic/room/" + code, event);
    }

    @MessageMapping("/room/{code}/react")
    public void handleReact(@DestinationVariable String code,
                            @Payload ReactInput payload,
                            Principal principal) {
        UserPrincipal user = extractUser(principal);
        if (user == null) return;
        String emoji = payload.getEmoji();
        if (emoji == null || emoji.isBlank()) return;

        boolean isSpectator = isSpectator(code, user.getId());
        RoomEvent event = RoomEvent.builder()
                .type("REACT")
                .userId(user.getId())
                .username(user.getUsername())
                .emoji(emoji)
                .timestamp(System.currentTimeMillis())
                .spectator(isSpectator)
                .build();
        messagingTemplate.convertAndSend("/topic/room/" + code, event);
    }

    private UserPrincipal extractUser(Principal principal) {
        if (principal instanceof UsernamePasswordAuthenticationToken auth) {
            return (UserPrincipal) auth.getPrincipal();
        }
        return null;
    }

    private boolean isSpectator(String code, Long userId) {
        Optional<ActiveRoom> room = roomStore.get(code);
        if (room.isEmpty()) return false;
        return room.get().getSpectators().containsKey(userId);
    }
}
