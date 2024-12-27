package com.shinhan.daengdong.plan.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter @Setter
@ToString
@Builder
public class PlanDTO {

    private String planName;            // 플랜 이름
    private String memberEmail;         // 유저 이메일
    private LocalDateTime startDate;    // 플랜 시작 기간
    private LocalDateTime endDate;      // 플랜 종료 기간
    private int planState;              // 플랜 공개 여부 : 0 비공개, 1 공개
    private LocalDateTime createAt;     // 생성 일자
    private LocalDateTime updateAt;     // 수정 일자

    // Default Constructor
    public PlanDTO() {}

    // Parameterized Constructor
    public PlanDTO(String planName, String memberEmail, LocalDateTime startDate, LocalDateTime endDate, int planState,
                     LocalDateTime createAt, LocalDateTime updateAt) {
        this.planName = planName;
        this.memberEmail = memberEmail;
        this.startDate = startDate;
        this.endDate = endDate;
        this.planState = planState;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }
}
