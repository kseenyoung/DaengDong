package com.shinhan.daengdong.chat.model.service;

import com.shinhan.daengdong.chat.dto.ChatMessageDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class SupabaseChatService {

    private final WebClient webClient;
    private String supabaseUrl;
    private String supabaseApiKey;

    public SupabaseChatService(
            @Value("${supabase.url}") String supabaseUrl,
            @Value("${supabase.api.key}") String supabaseApiKey,
            WebClient.Builder webClientBuilder) {
        this.supabaseUrl = supabaseUrl;
        this.supabaseApiKey = supabaseApiKey;
        this.webClient = webClientBuilder
                .baseUrl(supabaseUrl + "/rest/v1")
                .defaultHeader("apikey", supabaseApiKey)
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .build();
    }

    public void saveMessage(ChatMessageDTO chatMessage, int planId, String senderEmail) {
        Map<String, Object> payload = Map.of(
                "plan_id", planId,
                "sender_email", chatMessage.getSender(),
                "sender_name", chatMessage.getSender(),
                "sender_nick", chatMessage.getSender(),
                "sender_photo", chatMessage.getProfilePhoto(),
                "content", chatMessage.getContent(),
                "type", chatMessage.getType()
        );

        webClient.post()
                .uri("/messages")
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + supabaseApiKey)
                .bodyValue(payload)
                .retrieve()
                .bodyToMono(Void.class)
                .doOnSuccess(res -> log.info("✅ Supabase 저장 성공"))
                .doOnError(e -> log.info("❌ Supabase 저장 실패: {}", e.getMessage()))
                .subscribe();
    }

    public List<ChatMessageDTO> getMessagesByPlanId(int planId) {
        return webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/messages")
                        .queryParam("plan_id", "eq." + planId)
                        .queryParam("order", "created_at.asc")
                        .build())
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + supabaseApiKey)
                .retrieve()
                .bodyToFlux(ChatMessageDTO.class)
                .collectList()
                .block();
    }
}
