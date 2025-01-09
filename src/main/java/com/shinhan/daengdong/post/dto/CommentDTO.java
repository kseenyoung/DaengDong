package com.shinhan.daengdong.post.dto;


import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class CommentDTO {
    private long postId;
    private String memberEmail;
    private String comment;

    public CommentDTO(long postId, String comment) {
        this.postId = postId;
        this.comment = comment;
    }
}
