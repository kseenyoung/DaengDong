package com.shinhan.daengdong.chat.model;

import com.shinhan.daengdong.member.dto.MemberDTO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;

@NoArgsConstructor
@AllArgsConstructor
public class ChatParticipant {
    private MemberDTO member;
    private WebSocketSession session;

    public String getNickName() {
        return member.getMember_nickname();
    }

    public void sendMessage(String message) throws IOException {
        session.sendMessage(new TextMessage(message));
    }

    public String receiveMessage(int planId, String message) throws IOException {
        StringBuilder sb = new StringBuilder();
        String receiveMessage = sb.append("[com.shinhan.daengdong.chat.model.ChatRoom ").append(planId).append("] ")
                .append(member.getMember_nickname())
                .append(" received>> ")
                .append(message)
                .append("\n")
                .toString();
        return receiveMessage;
    }
}
