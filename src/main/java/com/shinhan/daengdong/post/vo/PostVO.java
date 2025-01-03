package com.shinhan.daengdong.post.vo;

import lombok.*;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
public class PostVO {
    private Long postId;
    private String postTitle;
    private String category;
    private String postContent;
    private String memberNickName;
    private Long likeCount;  // 게시글에 대한 좋아요 수
    private String imageUrl;

    public PostVO(Long postId, String postTitle, String category, Long likeCount, String memberNickName, String postContent, String imageUrl) {
        this.postId = postId;
        this.postTitle = postTitle;
        this.postContent = postContent;
        this.memberNickName = memberNickName;
        this.category = category;
        this.likeCount = likeCount;
        this.imageUrl = imageUrl;
    }
}