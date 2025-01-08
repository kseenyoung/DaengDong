package com.shinhan.daengdong.chat.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class ChatMessageDTO {
    private String type;
    private String sender;
    private String content;
    private String profilePhoto;
}
