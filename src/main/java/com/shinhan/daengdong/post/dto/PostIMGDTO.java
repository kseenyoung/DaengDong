package com.shinhan.daengdong.post.dto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@Builder
@ToString
public class PostIMGDTO {
    private Long postId;
    private List<String> imageUrl;
}
