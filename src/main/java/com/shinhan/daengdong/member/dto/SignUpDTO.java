package com.shinhan.daengdong.member.dto;

import com.shinhan.daengdong.pet.dto.PetDTO;
import java.time.LocalDateTime;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SignUpDTO {

    private String memberEmail;        // 유저 이메일
    private String memberName;         // 유저 이름
    private String memberNickname;     // 유저 닉네임
    private String memberProfilePhoto; // 유저 프로필 사진
    private List<PetDTO> pets;
    private LocalDateTime createAt;    // 생성 일자
    private LocalDateTime updateAt;    // 수정 일자

}