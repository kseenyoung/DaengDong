package com.shinhan.daengdong.member.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class LikePostsDTO {
    int post_id;
    String post_title;
    String image_url;
    String member_nickname;
}
