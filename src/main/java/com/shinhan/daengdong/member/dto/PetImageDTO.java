package com.shinhan.daengdong.member.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class PetImageDTO {
    private String imageUrl;
    private int petId;
}
