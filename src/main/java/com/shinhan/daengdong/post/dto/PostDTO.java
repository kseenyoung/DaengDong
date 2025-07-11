package com.shinhan.daengdong.post.dto;

import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class PostDTO {
    private long postId;
    private long planId;
    private String postTitle;
    private String postContent;
    private String category;
    private String memberEmail;
    private List<String> imageUrls;
    public PostDTO(long planId, String postTitle, String postContent, String category, String memberEmail) {
        this.planId = planId;
        this.postTitle = postTitle;
        this.postContent = postContent;
        this.category = category;
        this.memberEmail = memberEmail;
    }
}
