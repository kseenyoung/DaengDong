package com.shinhan.daengdong.chat.websocket;

import com.shinhan.daengdong.chat.model.ChatParticipant;
import com.shinhan.daengdong.chat.model.ChatRoom;
import com.shinhan.daengdong.chat.model.service.ChatService;
import com.shinhan.daengdong.member.dto.MemberDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Slf4j
@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {

    private final ChatService chatService;
    private final WebSocketSessionManager sessionManager;

    @Autowired
    public ChatWebSocketHandler(ChatService chatService, WebSocketSessionManager sessionManager) {
        this.chatService = chatService;
        this.sessionManager = sessionManager;
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        SessionInfo info = sessionManager.getSessionInfo(session.getId());
        if (info == null) {
            log.info("Session info not fount for session ID: " + session.getId());
            return;
        }

        ChatParticipant sender = info.getParticipant();
        int planId = info.getPlanId();

        ChatRoom chatRoom = chatService.getChatRoom(planId);

        chatRoom.sendMessage(sender, message.getPayload());
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        int planId = 1;

        MemberDTO memberDTO = new MemberDTO();
        ChatParticipant participant = new ChatParticipant(memberDTO, session);

        ChatRoom chatRoom = chatService.getChatRoom(planId);
        chatRoom.join(participant);

        sessionManager.addSession(session.getId(), planId, participant);

        log.info("WebSocket connected. Session ID: " + session.getId());
    }


}
