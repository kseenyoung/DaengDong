package com.shinhan.daengdong.place.dto;

import lombok.*;

import java.sql.Date;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class PlanPlaceDetailDTO {
    private Long plannerPlaceId;  // planner_place_id
    private Long planId;          // plan_id
    private Long kakaoPlaceId;    // kakao_place_id
    private Integer day;
}
