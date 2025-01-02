package com.shinhan.daengdong.post.dto;

import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class PostDTO {
    private int post_id;
    private String member_email;
    private int plan_id;
    private String category_id;
    private String post_title;
    private String post_content;
    private int photo_id;
    private String image_url;
    private String member_nickname;
    private int total_likes;
}
