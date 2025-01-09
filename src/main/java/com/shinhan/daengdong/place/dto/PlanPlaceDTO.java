package com.shinhan.daengdong.place.dto;

import lombok.*;

@Getter @Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PlanPlaceDTO {
    private Long planId;
    private Long kakaoPlaceId;
    private Integer day;
}
