package com.shinhan.daengdong.post.dto;


import lombok.*;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class CommentVO {
    private long commentId;
    private String comment;
    private Date createAt;
    private String memberNickName;
    private String memberProfilePhoto;


}
