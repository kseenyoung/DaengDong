package com.shinhan.daengdong.chat.model.service;

import com.shinhan.daengdong.chat.model.ChatRoom;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class ChatService {
    private final Map<Integer, ChatRoom> roomMap = new HashMap<>();

    public ChatRoom getChatRoom(int planId) {
        if (!roomMap.containsKey(planId)) {
            ChatRoom chatRoom = new ChatRoom();
            roomMap.put(planId, chatRoom);
        }

        return roomMap.get(planId);
    }
}
