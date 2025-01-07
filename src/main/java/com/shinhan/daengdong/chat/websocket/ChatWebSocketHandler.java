package com.shinhan.daengdong.chat.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shinhan.daengdong.chat.dto.ChatMessageDTO;
import com.shinhan.daengdong.chat.model.ChatParticipant;
import com.shinhan.daengdong.chat.model.ChatRoom;
import com.shinhan.daengdong.chat.model.service.ChatService;
import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.member.model.repository.MemberRepositoryImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.Map;

@Slf4j
@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {

    private final ChatService chatService;
    private final WebSocketSessionManager sessionManager;
    private final MemberRepositoryImpl memberRepositoryImpl;

    @Autowired
    public ChatWebSocketHandler(ChatService chatService, WebSocketSessionManager sessionManager, MemberRepositoryImpl memberRepositoryImpl) {
        this.chatService = chatService;
        this.sessionManager = sessionManager;
        this.memberRepositoryImpl = memberRepositoryImpl;
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        log.info("Connect handleTextMessage");
        SessionInfo info = sessionManager.getSessionInfo(session.getId());
        if (info == null) {
            log.info("Session info not fount for session ID: " + session.getId());
            return;
        }

        ChatParticipant sender = info.getParticipant();
        int planId = info.getPlanId();
        String senderName = (sender.getNickName() != null ? sender.getNickName() : sender.getName());

        //JSON message parsing
        ObjectMapper mapper = new ObjectMapper();
        ChatMessageDTO chatMessage = mapper.readValue(message.getPayload(), ChatMessageDTO.class);
        chatMessage.setSender(senderName);

        ChatRoom chatRoom = chatService.getChatRoom(planId);
        chatRoom.broadcastMessage(mapper.writeValueAsString(chatMessage));
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("afterConnectionEstablished connected.");
        int planId = 1;
        MemberDTO member = (MemberDTO) session.getAttributes().get("member");

        log.info("member: " + member);
        ChatParticipant participant = new ChatParticipant(member, session);

        ChatRoom chatRoom = chatService.getChatRoom(planId);
        chatRoom.join(participant);

        sessionManager.addSession(session.getId(), planId, participant);

        log.info("WebSocket connected. Session ID: " + session.getId());
    }


}
