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
    private String memberProfilePhoto;
    private Long likeCount;  // 게시글에 대한 좋아요 수
    private String imageUrl;



//    public PostVO(Long postId, String postTitle, String postContent, String category, String memberNickName, Long likeCount, List<String> imageUrl) {
//        this.postId = postId;
//        this.postTitle = postTitle;
//        this.postContent = postContent;
//        this.category = category;
//        this.memberNickName = memberNickName;
//        this.likeCount = likeCount;
//        // 이미지 URL을 단일 값으로 할당하거나, 목록으로 다룰 수 있도록 로직을 추가
//        this.imageUrls = imageUrls;
////        this.imageUrls = new ArrayList<>();
////        if (imageUrl != null) {
////            this.imageUrls.addAll(imageUrl);  // imageUrl에 있는 모든 값을 imageUrls에 추가
////        }
//
//    }
}