package com.shinhan.daengdong.chat.model;

import lombok.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
        String fullMsg = sender.getNickName() + ": " + message;

        messageHistory.add(fullMsg);

        for (ChatParticipant p : participants) {
            p.sendMessage(p.receiveMessage(plan_id, fullMsg));
        }
    }
}
