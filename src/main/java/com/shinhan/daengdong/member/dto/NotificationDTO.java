package com.shinhan.daengdong.member.dto;

import lombok.*;

@Getter@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NotificationDTO {
    private int notification_id; // 알림 id
    private String sender_email; // 알림 보낸사람
    private String receiver_email; // 알림 받는 사람
    private int notification_type; // 알림 타입 1 팔로우 2 좋아요 3 댓글 4 동행요청 5 여행초대
    private int is_checked; // 알림읽음 체크 0번 안읽음 1번 읽음표시
    private Long plan_id;  // 여행동행 , 여행초대에 대한 여행 id
    private Integer post_id; // 하트 게시글 좋아요
}

