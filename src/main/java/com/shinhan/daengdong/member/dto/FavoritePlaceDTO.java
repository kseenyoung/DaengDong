package com.shinhan.daengdong.member.dto;

import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;

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
    private LocalDateTime create_at;    // 생성 일자
    private LocalDateTime update_at;    // 수정 일자
    }