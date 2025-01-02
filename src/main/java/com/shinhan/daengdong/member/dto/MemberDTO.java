package com.shinhan.daengdong.member.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class MemberDTO {

    private String member_email;        // 유저 이메일
    private String member_name;         // 유저 이름
    private String member_nickname;     // 유저 닉네임
    private String member_profile_photo; // 유저 프로필 사진
}