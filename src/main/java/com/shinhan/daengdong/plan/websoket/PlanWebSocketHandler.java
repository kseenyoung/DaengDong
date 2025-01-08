package com.shinhan.daengdong.plan.websoket;

import com.fasterxml.jackson.databind.ObjectMapper;
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
        log.info("Plan {}에 세션 추가: {}", planId, session.getId());
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String planId = getPlanIdFromSession(session);
        Map<String, Object> messageMap = new ObjectMapper().readValue(message.getPayload(), Map.class);

        String type = (String) messageMap.get("type");

        if ("chat".equals(type)) {
            broadcast(planId, message);
        } else if ("shareMap".equals(type)) {
            // 화면 공유 데이터 처리
            //Map<String, Object> mapData = (Map<String, Object>) messageMap.get("data");

            for (WebSocketSession userSession : sessions.get(planId)) {
                if (userSession.isOpen() && !userSession.equals(session)) {
                    userSession.sendMessage(new TextMessage(message.getPayload()));
                }
            }
        } else {
            log.warn("알 수 없는 메시지 타입: {}", type);
        }
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
        log.info("Plan {} 화면 공유 / getUri: {}", planId, session.getUri());
        log.info("Plan {}에서 세션 제거: {}", planId, session.getId());
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

    // private String getPlanIdFromSession(WebSocketSession session) {
    //     String uri = session.getUri().toString();
    //     return uri.substring(uri.lastIndexOf("/") + 1);
    // }
    private String getPlanIdFromSession(WebSocketSession session) {
        String query = session.getUri().getQuery();  // planId=91
        if (query != null && query.startsWith("planId=")) {
            return query.substring("planId=".length());
        }
        return "defaultPlanId";  // 혹은 에러 처리
    }

}
