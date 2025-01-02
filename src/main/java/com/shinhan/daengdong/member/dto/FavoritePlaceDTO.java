package com.shinhan.daengdong.member.dto;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class FavoritePlaceDTO {
    private int star_id;
    private String member_email;
    private int kakao_place_id;
    private String kakao_place_name;
    private String kakao_road_address_name;
    private String kakao_phone;
    private String kakao_place_url;
    private String region_name;
    private String imageUrl;
    }