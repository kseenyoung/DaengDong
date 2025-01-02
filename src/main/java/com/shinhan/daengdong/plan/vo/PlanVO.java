package com.shinhan.daengdong.plan.vo;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;

@Builder
@Getter @Setter
@ToString
public class PlanVO {
    private Long planId;             // 플랜 ID
    private String memberEmail;      // 작성자 이메일
    private LocalDate startDate; // 시작 날짜
    private LocalDate endDate;   // 종료 날짜
    private int planState;           // 플랜 상태 (0: 비공개, 1: 공개)
}