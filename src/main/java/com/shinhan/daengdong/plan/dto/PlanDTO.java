package com.shinhan.daengdong.plan.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import java.sql.Timestamp;
import java.time.LocalDate;

@Getter @Setter
@ToString
@Builder
@NoArgsConstructor @AllArgsConstructor
public class PlanDTO {

    private Long planId;                // 플랜 ID
    private String memberEmail;         // 사용자 이메일
    private String planName;            // 플랜 이름
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;    // 플랜 시작 기간
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;      // 플랜 종료 기간
    private Integer planState;              // 플랜 공개 여부 : 0 비공개, 1 공개
}
