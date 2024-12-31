package com.shinhan.daengdong.member.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class RelationshipsDTO {
    private String member_email;
    private String member_name;
    private String member_nickname;
    private String member_profile_photo;
    private int is_following_back;
    private LocalDateTime create_at;
    private LocalDateTime update_at;
}
