package com.shinhan.daengdong.post.vo;

import lombok.*;

import java.util.ArrayList;
import java.util.List;

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
    private String memberEmail;
    private String memberProfilePhoto;
    private Long likeCount;  // 게시글에 대한 좋아요 수
    private String imageUrl;
    private List<String> imageUrls;

    public PostVO(Long postId, String postTitle, String category, String postContent, String memberNickName,  String memberEmail, String memberProfilePhoto, Long likeCount, String imageUrl) {
        this.postId = postId;
        this.postTitle = postTitle;
        this.category = category;
        this.postContent = postContent;
        this.memberNickName = memberNickName;
        this.memberEmail = memberEmail;
        this.memberProfilePhoto = memberProfilePhoto;
        this.likeCount = likeCount;
        this.imageUrl = imageUrl;
    }

    public PostVO(Long postId, String postTitle, String category, String postContent, String memberNickName,  String memberEmail,  String memberProfilePhoto, Long likeCount, List<String> imageUrls) {
        this.postId = postId;
        this.postTitle = postTitle;
        this.category = category;
        this.postContent = postContent;
        this.memberNickName = memberNickName;
        this.memberEmail = memberEmail;
        this.memberProfilePhoto = memberProfilePhoto;
        this.likeCount = likeCount;
        this.imageUrls = imageUrls;
    }
}