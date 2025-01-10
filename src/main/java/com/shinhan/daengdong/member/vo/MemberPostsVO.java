package com.shinhan.daengdong.member.vo;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class MemberPostsVO {
    private long post_id;
    private String member_email;
    private long plan_id;
    private String  category_id;
    private String post_title;
    private String post_content;
    private String member_nickname;
    private int photo_id;
    private String image_url;
    private int total_likes;
}
