package com.shinhan.daengdong.place.dto;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class PlaceDTO {
    private Long kakaoPlaceId;             // kakao_place_id (PK)
    private Integer regionId;             // region_id
    private String kakaoPlaceName;        // kakao_place_name
    private String kakaoRoadAddressName;  // kakao_road_address_name
    private String kakaoPhone;            // kakao_phone
    private Double kakaoX;               // kakao_x (경도)
    private Double kakaoY;               // kakao_y (위도)
    private String kakaoPlaceUrl;         // kakao_place_url
}
