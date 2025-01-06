package com.shinhan.daengdong.chat.model;

import com.shinhan.daengdong.member.dto.MemberDTO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;

@Slf4j
@NoArgsConstructor
@AllArgsConstructor
public class ChatParticipant {
    private MemberDTO member;
    private WebSocketSession session;

    public String getNickName() {
        return member.getMember_nickname();
    }

    public void sendMessage(String message) throws IOException {
        if (session.isOpen()) {
            session.sendMessage(new TextMessage(message));
        } else {
            log.info("세션이 닫혀 있어 메세지를 보낼 수 없습니다. : " + session.getId());
        }

    }

    public String receiveMessage(int planId, String message) throws IOException {
        StringBuilder sb = new StringBuilder();
        log.info("[com.shinhan.daengdong.chat.model.ChatRoom " + planId + "] "
                + member.getMember_nickname() + " received>> " + message);
        String receiveMessage = sb.append(message).toString();
        return receiveMessage;
    }
}
