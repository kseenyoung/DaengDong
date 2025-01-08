package com.shinhan.daengdong.chat.websocket;

import com.shinhan.daengdong.chat.model.ChatParticipant;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@Component
public class WebSocketSessionManager {
    private final Map<String, SessionInfo> sessionMap = new ConcurrentHashMap<>();

    public void addSession(String sessionId, int planId, ChatParticipant participant) {
        log.info("addSession>> " + "sessionId: " + sessionId
                + "// planId: " + planId + "// participant: " + participant);
        sessionMap.put(sessionId, new SessionInfo(planId, participant));
    }

    public SessionInfo getSessionInfo(String sessionId) {
        log.info("getSessionInfo>> sessionId" + sessionId);
        return sessionMap.get(sessionId);
    }

    public void removeSession(String sessionId) {
        sessionMap.remove(sessionId);
    }
}