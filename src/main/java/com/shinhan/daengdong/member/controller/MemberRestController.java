package com.shinhan.daengdong.member.controller;

import com.shinhan.daengdong.member.dto.FollowDTO;
import com.shinhan.daengdong.member.model.service.MemberServiceInterface;
import com.shinhan.daengdong.review.dto.ReviewDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Slf4j
@RestController
@MultipartConfig
public class MemberRestController {

    @Autowired
    MemberServiceInterface memberService;



    //todo: 업로드 시 null값이 들어오는 문제 해결할 것.
    @PostMapping("/myProfile")
    public void updateProfile(@RequestParam(value = "newPhoto", required = false) MultipartFile newPhoto) {
        log.info("newPhoto: " + newPhoto);
//        log.info("new nickname: " + newNickname);
        try {
            if (!newPhoto.isEmpty()) {
                String originalFileName = newPhoto.getOriginalFilename();
                long fileSize = newPhoto.getSize();
                log.info("fileName: " + originalFileName + " // fileSize: " + fileSize);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @GetMapping("/favoritePlace/{star_id}")
    public void deleteFavoritePlace(@PathVariable("star_id") int starId) {
        memberService.deleteFavoritePlace(starId);
    }

    @GetMapping("/reviews/{review_id}")
    public void deleteReview(@PathVariable("review_id") int reviewId) {
        memberService.deleteReview(reviewId);
    }

    @PostMapping("/reviews")
    public void modifyReview(@RequestBody ReviewDTO reviewDTO) {
        memberService.modifyReview(reviewDTO);
    }

    @GetMapping("/likePosts/{post_id}")
    public void deleteLikePost(@PathVariable("post_id") int postId) {
        memberService.deleteLikePosts(postId);
    }

    @GetMapping("/following/{to_email}")
    public void deleteFollowing(@PathVariable("to_email") String toEmail, HttpSession session) {
//        MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
//        String fromEmail = memberDTO.getMemberEmail();
        String fromEmail = "user1@example.com";
        FollowDTO followDTO = FollowDTO.builder()
                .from_email(fromEmail)
                .to_email(toEmail)
                .build();
        memberService.deleteFollowing(followDTO);
    }

    @PostMapping("/following/{to_email}")
    public void addFollowing(@PathVariable("to_email") String toEmail, HttpSession session) {
//        MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
//        String fromEmail = memberDTO.getMemberEmail();
        String fromEmail = "user1@example.com";
        FollowDTO followDTO = FollowDTO.builder()
                .from_email(fromEmail)
                .to_email(toEmail)
                .build();
        memberService.addFollowing(followDTO);
    }

    @GetMapping("/MyPlan/{plan_id}")
    public void deletePlan(@PathVariable("plan_id") long planId) {
        memberService.deletePlan(planId);
    }


}
