package com.shinhan.daengdong.chat;

import com.shinhan.daengdong.member.dto.MemberDTO;
import lombok.*;

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
    private List<MemberDTO> participants = new ArrayList<>();
    private List<String> messageHistory = new ArrayList<>();

    public void createChatRoomByPlanId(int plan_id) {
        this.plan_id = plan_id;
    }

    public void join(MemberDTO member) {
        participants.add(member);
    }

    public void leave(MemberDTO member) {
        participants.remove(member);
    }

    public int getParticipantCount() {
        return participants.size();
    }

    public void sendMessage(MemberDTO sender, String message) {
        StringBuilder sb = new StringBuilder();
        messageHistory.add(sb.append(sender.getMember_nickname()).append(": ").append(message).toString());
    }
}
