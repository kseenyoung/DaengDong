package com.shinhan.daengdong.place.dto;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class FavoriteDTO {
    private Long starId;
    private String memberEmail;
    private Long kakaoPlaceId;
}
