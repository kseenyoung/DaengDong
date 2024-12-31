package com.shinhan.daengdong.plan.websoket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.socket.CloseStatus;

import java.util.concurrent.CopyOnWriteArrayList;

@Slf4j
public class PlanWebSocketHandler extends TextWebSocketHandler {

    private final CopyOnWriteArrayList<WebSocketSession> sessions = new CopyOnWriteArrayList<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        log.info("새 연결: {} | 총 세션 수: {}", session.getId(), sessions.size());
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        log.info("수신된 메시지: {}", message.getPayload());
        broadcast(message);  // 메시지 브로드캐스트
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        log.info("연결 종료: {} | 총 세션 수: {}", session.getId(), sessions.size());
    }

    private void broadcast(TextMessage message) {
        for (WebSocketSession wsSession : sessions) {
            if (wsSession.isOpen()) {
                try {
                    wsSession.sendMessage(message);
                } catch (Exception e) {
                    log.error("메시지 전송 실패", e);
                }
            }
        }
    }
}
