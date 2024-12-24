package com.shinhan.daengdong.member.controller;

import com.shinhan.daengdong.review.dto.ReviewDTO;
import com.shinhan.daengdong.member.model.service.MemberServiceInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
public class MemberRestController {

    @Autowired
    MemberServiceInterface memberService;

    @GetMapping("/review")
    public List<ReviewDTO> viewReviewList(@RequestParam("memberId") String memberId) {
        List<ReviewDTO> reviews = memberService.viewReviewList(memberId);
        System.out.println(reviews);
        return reviews;
    }
}
