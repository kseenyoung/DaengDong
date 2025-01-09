package com.shinhan.daengdong.util;

import com.shinhan.daengdong.chat.websocket.ChatWebSocketHandler;
import com.shinhan.daengdong.chat.websocket.HttpSessionInterceptor;
import com.shinhan.daengdong.plan.websoket.PlanWebSocketHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    private final ChatWebSocketHandler chatWebSocketHandler;
    private final PlanWebSocketHandler planWebSocketHandler;

    @Autowired
    public WebSocketConfig(ChatWebSocketHandler chatWebSocketHandler, PlanWebSocketHandler planWebSocketHandler) {
        this.chatWebSocketHandler = chatWebSocketHandler;
        this.planWebSocketHandler = planWebSocketHandler;
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        //for Chatting
        registry.addHandler(chatWebSocketHandler, "/chat-ws")
                .addInterceptors(new HttpSessionInterceptor())
                .setAllowedOrigins("*");

        //for Plan
        registry.addHandler(planWebSocketHandler, "/shareMap-ws")
            .setAllowedOrigins("*");
    }

}
