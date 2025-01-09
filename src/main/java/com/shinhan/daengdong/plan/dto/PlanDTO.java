package com.shinhan.daengdong.plan.dto;

import lombok.*;

import java.sql.Date;

@Getter @Setter
@ToString
@Builder
@NoArgsConstructor @AllArgsConstructor
public class PlanDTO {

    private Long planId;                // 플랜 ID
    private String memberEmail;         // 사용자 이메일
    private String planName;            // 플랜 이름
    private Date startDate;             // 플랜 시작 기간
    private Date endDate;               // 플랜 종료 기간
    private Integer planState;          // 플랜 공개 여부 : 0 비공개, 1 공개
}
