package com.shinhan.daengdong.chat.model;

import com.shinhan.daengdong.chat.websocket.WebSocketSessionManager;
import lombok.*;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class ChatRoom {
    private int plan_id;
    private List<ChatParticipant> participants = new ArrayList<>();
    private List<String> messageHistory = new ArrayList<>();
    private WebSocketSessionManager sessionManager;

    public void createChatRoomByPlanId(int plan_id) {
        this.plan_id = plan_id;
    }

    public void join(ChatParticipant member) {
        participants.add(member);
    }

    public void leave(ChatParticipant member) {
        participants.remove(member);
    }

    public int countParticipants() {
        return participants.size();
    }

    public void sendMessage(ChatParticipant sender, String message) throws IOException {

        messageHistory.add(message);

        for (ChatParticipant p : participants) {
            p.sendMessage(p.receiveMessage(plan_id, message));
        }
    }

    public void broadcastMessage(String message) {
        for (ChatParticipant participant : participants) {
            try {
                participant.sendMessage(message); // sendMessage 내부에서 session.sendMessage(new TextMessage(...))
            } catch (IOException e) {
                log.warn("Failed to send message to participant: {}, removing from room", participant);
                // 세션이 닫힌 경우이므로 participants 목록에서 제거
                participants.remove(participant);
            }
        }
    }
}
