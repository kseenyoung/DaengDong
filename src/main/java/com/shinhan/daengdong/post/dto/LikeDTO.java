package com.shinhan.daengdong.post.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
public class LikeDTO {
    private String memberEmail;
    private Long postId;
}