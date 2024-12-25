package com.shinhan.daengdong.plan.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;

@Getter @Setter
@ToString
@Builder
public class PlanDTO {

    private String planName;            // 플랜 이름
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;    // 플랜 시작 기간
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;      // 플랜 종료 기간
    private int planState;              // 플랜 공개 여부 : 0 비공개, 1 공개

    // Default Constructor
    public PlanDTO() {}

    // Parameterized Constructor
    public PlanDTO(String planName, LocalDate startDate, LocalDate endDate, int planState) {
        this.planName = planName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.planState = planState;
    }
}
