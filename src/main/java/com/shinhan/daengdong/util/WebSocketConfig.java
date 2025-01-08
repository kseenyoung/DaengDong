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

    @Autowired
    public WebSocketConfig(ChatWebSocketHandler chatWebSocketHandler) {
        this.chatWebSocketHandler = chatWebSocketHandler;
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        //for Chatting
        registry.addHandler(chatWebSocketHandler, "/chat-ws")
                .addInterceptors(new HttpSessionInterceptor())
                .setAllowedOrigins("*");

        //for Plan
        registry.addHandler(new PlanWebSocketHandler(), "/shareMap-ws")
            .setAllowedOrigins("*");
    }

}
