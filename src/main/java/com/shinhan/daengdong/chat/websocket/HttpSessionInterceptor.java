package com.shinhan.daengdong.chat.websocket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Slf4j
public class HttpSessionInterceptor implements HandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler webSocketHandler,
                                   Map<String, Object> attributes) throws Exception {
        if (request instanceof org.springframework.http.server.ServletServerHttpRequest) {
            HttpSession httpSession = ((org.springframework.http.server.ServletServerHttpRequest) request).getServletRequest().getSession();
            if (httpSession != null) {
                // HttpSession에서 데이터를 WebSocketSession의 Attributes에 추가
                attributes.put("member", httpSession.getAttribute("member"));
                attributes.put("currentPlanId", httpSession.getAttribute("currentPlanId"));
                log.info("beforeHandshake put member: " + attributes.get("member"));
                log.info("WebSocket Attribute에 currentPlanId={} 추가", httpSession.getAttribute("currentPlanId"));
            }
        }
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Exception e) {

    }
}
