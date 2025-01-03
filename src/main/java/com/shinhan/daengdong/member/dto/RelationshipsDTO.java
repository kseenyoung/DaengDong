package com.shinhan.daengdong.member.dto;

import lombok.*;

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
}
