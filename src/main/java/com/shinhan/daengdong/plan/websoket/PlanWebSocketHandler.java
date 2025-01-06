package com.shinhan.daengdong.plan.websoket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.socket.CloseStatus;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

@Slf4j
public class PlanWebSocketHandler extends TextWebSocketHandler {

    private static final Map<String, List<WebSocketSession>> sessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String planId = getPlanIdFromSession(session);
        sessions.computeIfAbsent(planId, k -> new CopyOnWriteArrayList<>()).add(session);
        //log.info("Plan {}에 세션 추가: {} | 총 세션 수: {}", planId, session.getId(), sessions.size());
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String planId = getPlanIdFromSession(session);
        broadcast(planId, message);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String planId = getPlanIdFromSession(session);
        List<WebSocketSession> sessionList = sessions.get(planId);
        if (sessionList != null) {
            sessionList.remove(session);
            if (sessionList.isEmpty()) {
                sessions.remove(planId);
            }
        }
        //log.info("Plan {}에서 세션 제거: {} | 총 세션 수: {}", planId, session.getId(), sessions.size());
    }

    public static void sendMessageToUsers(String planId, String message) {
        List<WebSocketSession> sessionList = sessions.get(planId);
        if (sessionList != null) {
            for (WebSocketSession session : sessionList) {
                try {
                    session.sendMessage(new TextMessage(message));
                } catch (IOException e) {
                    log.error("웹소켓 메시지 전송 오류", e);
                }
            }
        }
    }

    // 특정 planId에 메시지를 브로드캐스트하는 메서드 추가
    private void broadcast(String planId, TextMessage message) {
        List<WebSocketSession> sessionList = sessions.get(planId);
        if (sessionList != null) {
            for (WebSocketSession session : sessionList) {
                try {
                    if (session.isOpen()) {
                        session.sendMessage(message);
                    }
                } catch (IOException e) {
                    log.error("브로드캐스트 중 오류 발생", e);
                }
            }
        }
    }

    private String getPlanIdFromSession(WebSocketSession session) {
        String uri = session.getUri().toString();
        return uri.substring(uri.lastIndexOf("/") + 1);
    }
}
