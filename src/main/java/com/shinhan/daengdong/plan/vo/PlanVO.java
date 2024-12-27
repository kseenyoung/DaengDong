package com.shinhan.daengdong.plan.vo;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Builder
@Getter @Setter
@ToString
public class PlanVO {
    private Long planId;             // 플랜 ID
    private String memberEmail;      // 작성자 이메일
    private LocalDateTime startDate; // 시작 날짜
    private LocalDateTime endDate;   // 종료 날짜
    private int planState;           // 플랜 상태 (0: 비공개, 1: 공개)
    private LocalDateTime createAt;  // 생성일
    private LocalDateTime updateAt;  // 수정일
}