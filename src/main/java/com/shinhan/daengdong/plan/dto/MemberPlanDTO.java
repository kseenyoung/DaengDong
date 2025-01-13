package com.shinhan.daengdong.plan.dto;

import lombok.*;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class MemberPlanDTO {
    private Long memberPlanId; // AUTO_INCREMENT 필드
    private String memberEmail; // 동행자 이메일
    private Long planId; // 플랜 ID
}
