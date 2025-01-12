package com.shinhan.daengdong.plan.dto;

import lombok.*;

@Getter @Setter
@ToString
@Builder
@NoArgsConstructor @AllArgsConstructor
public class PlanDetailsDTO {
    private Long planId;                   // 플랜 ID
    private String planName;               // 플랜 이름
    private java.sql.Date startDate;       // 시작 날짜
    private java.sql.Date endDate;         // 종료 날짜
    private Integer planState;             // 플랜 상태 (공개 여부)
    private Integer day;                   // 플랜 일차
    private Long kakaoPlaceId;             // 카카오 장소 ID
    private String kakaoPlaceName;         // 카카오 장소 이름
    private String kakaoRoadAddressName;   // 카카오 도로명 주소
}
