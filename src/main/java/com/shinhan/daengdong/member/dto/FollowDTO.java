package com.shinhan.daengdong.member.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class FollowDTO {
    private String from_email;
    private String to_email;
}
