package com.shinhan.daengdong.review.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class ReviewDTO {
    private int review_id;
    private String kakao_place_name;
    private int kakao_place_id;
    private int review_rating;
    private String review_content;
    private String region_name;
    private String imageUrl;
}
