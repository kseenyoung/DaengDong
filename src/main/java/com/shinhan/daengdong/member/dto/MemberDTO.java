package com.shinhan.daengdong.member.dto;

import java.time.LocalDateTime;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
@Builder
public class MemberDTO {

    private String memberEmail;        // 유저 이메일
    private String memberName;         // 유저 이름
    private String memberNickname;     // 유저 닉네임
    private String memberProfilePhoto; // 유저 프로필 사진
    private LocalDateTime createAt;    // 생성 일자
    private LocalDateTime updateAt;    // 수정 일자

    // Default Constructor
    public MemberDTO() {}

    // Parameterized Constructor
    public MemberDTO(String memberEmail, String memberName, String memberNickname,
                     String memberProfilePhoto, LocalDateTime createAt, LocalDateTime updateAt) {
        this.memberEmail = memberEmail;
        this.memberName = memberName;
        this.memberNickname = memberNickname;
        this.memberProfilePhoto = memberProfilePhoto;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }
}