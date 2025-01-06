package com.shinhan.daengdong.chat.websocket;

import com.shinhan.daengdong.chat.model.ChatParticipant;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class SessionInfo {
    private final int planId;
    private final ChatParticipant participant;
}
