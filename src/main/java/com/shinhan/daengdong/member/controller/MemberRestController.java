package com.shinhan.daengdong.member.controller;

import com.shinhan.daengdong.member.model.service.MemberServiceInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
public class MemberRestController {

    @Autowired
    MemberServiceInterface memberService;

    @GetMapping("/favoritePlace/{star_id}")
    public void deleteFavoritePlace(@PathVariable("star_id") int starId) {
        memberService.deleteFavoritePlace(starId);
    }

    @GetMapping("/reviews/{review_id}")
    public void deleteReview(@PathVariable("review_id") int reviewId) {
        memberService.deleteReview(reviewId);
    }

    @PostMapping("/reviews/{review_id}")
    public void modifyReview(@PathVariable("review_id") int reviewId) {
        memberService.modifyReview(reviewId);
    }
}
