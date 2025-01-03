package com.shinhan.daengdong.post.dto;

import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class PostDTO {
//    private int post_id;
    private String member_email;
    private String category_id;
    private String post_title;
    private String post_content;
//    private int photo_id;
    private List<String> image_urls;
//    private int total_likes;


}
