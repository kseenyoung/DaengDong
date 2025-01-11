package com.shinhan.daengdong.plan.dto;

import lombok.*;

@Getter @Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PlanRelationshipsDTO {
    private String memberEmail;      // 이메일
    private String memberNickname;
}
