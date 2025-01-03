package com.shinhan.daengdong.member.controller;

import com.shinhan.daengdong.member.dto.*;
import com.shinhan.daengdong.member.model.service.MemberServiceInterface;
import com.shinhan.daengdong.post.dto.PostDTO;
import com.shinhan.daengdong.review.dto.ReviewDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@Controller
@PropertySource("classpath:application.properties")
@RequestMapping("auth/")
public class MemberController {

    @Autowired
    MemberServiceInterface memberService;

    @Value("${kakao.login.rest_api_key}")
    String rest_api_key;

    @Value("${kakao.login.redirect_uri}")
    String redirect_uri;

    @GetMapping("login.do")
    public String login(HttpServletRequest request){
        log.info("로그인 페이지 요청");
        request.setAttribute("rest_api_key", rest_api_key);
        request.setAttribute("redirect_uri", redirect_uri);
        return "member/login";
    }

    // 회원가입 페이지
    @GetMapping("signUp.do")
    public String signUp(){
        log.info("회원가입 페이지 요청");
        return "member/signUp";
    }

    @PostMapping("signUp.do")
    @ResponseBody
    public SignUpDTO signUp(@RequestBody SignUpDTO signUpDTO, HttpServletRequest request){
        log.info("회원가입 요청 데이터: {}", signUpDTO);
        HttpSession session = request.getSession();
        if (session == null){
            // session 없음 = 로그인 시도한 적 없음
            log.info("세션이 존재하지 않음");
            return null;
        }

        // TODO oauth 로그인 할 때 session 안에 MemberDTO 타입의 'member' 등록 되어 있어야 함
        MemberDTO member = (MemberDTO) session.getAttribute("member");

        // signUpDTO에 session에 저장된 MemberDTO 정보 삽입
        signUpDTO.setMemberEmail(member.getMember_email());
        signUpDTO.setMemberProfilePhoto(member.getMember_profile_photo());
        if (signUpDTO.getMemberNickname() == null) {
            if (member.getMember_nickname() != null) {
                signUpDTO.setMemberNickname(member.getMember_nickname());
            } else {
                log.error("닉네임이 null입니다.");
                // 적절한 기본값을 설정하거나 에러 처리
            }
        }
        log.info("member in session !! : " + member);

        MemberDTO signUpMember = memberService.signUp(signUpDTO);
        session.setAttribute("member", signUpMember);
        return signUpDTO;
    }

    @GetMapping("reviews.do")
    public String viewReview () {
        return "member/reviews";
    }

    //마이페이지 전환
    @GetMapping("viewMypage.do")
    public String viewMypage() {
        return "member/mypage";
    }

    //마이페이지 > 유저 정보
    @GetMapping("getProfileFragment.do")
    public String getProfileFragment(HttpSession session, Model model) {
        //MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
        MemberDTO memberDTO = MemberDTO.builder().member_email("user2@example.com").build();
        MemberDTO selectMember = memberService.selectMember(memberDTO.getMember_email());
        model.addAttribute("selectMember", selectMember);
        //log.info("selectMember : " + selectMember);
        return "member/profileFragment";
    }
    @PostMapping("modifyNickname.do")
    @ResponseBody
    public void modifyNickname(@RequestBody MemberDTO memberDTO) {
        //log.info("modifyNickname: {}  " + memberDTO);
        memberService.modifyNickname(memberDTO);
        //log.info("modifyNickname: {}  " + memberDTO);
    }

    //'내 저장' > 세미 카테고리
    @GetMapping("getSemiSaveCategory.do")
    public String getSemiSaveCategory() {
        return "member/semiSaveCategory";
    }

    //'내 저장' > 세미 카테고리 > 즐겨찾기(장소) 컨텐츠
    @GetMapping("getFavoritePlace.do")
    public String getFavoritePlaceList(HttpSession session, Model model) {
//        MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
        MemberDTO memberDTO = MemberDTO.builder().member_email("user1@example.com").build();
        List<FavoritePlaceDTO> favoritePlaceList = memberService.getFavoritePlaceList(memberDTO.getMember_email());
        model.addAttribute("favoritePlaceList", favoritePlaceList);
        return "member/favoritePlaceFragment";
    }

    //'내 저장' > 세미 카테고리 > 내가 쓴 리뷰(장소) 컨텐츠
    @GetMapping("getReviewFragment.do")
    public String getReviewList(HttpSession session, Model model) {
//        MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
        MemberDTO memberDTO = MemberDTO.builder().member_email("user1@example.com").build();
        List<ReviewDTO> reviewList = memberService.getReviewList(memberDTO.getMember_email());
        model.addAttribute("reviewList", reviewList);
        return "member/reviewFragment";
    }

    @GetMapping("getReviewModal.do")
    public String getReviewModal(@RequestParam int reviewId,
                                 @RequestParam String reviewContent,
                                 @RequestParam int reviewRating,
                                 @RequestParam String kakaoPlaceName,
                                 @RequestParam String imageUrl,
                                 Model model) {
        model.addAttribute("reviewId", reviewId);
        model.addAttribute("reviewContent", reviewContent);
        model.addAttribute("reviewRating", reviewRating);
        model.addAttribute("kakaoPlaceName", kakaoPlaceName);
        model.addAttribute("imageUrl", imageUrl);
        return "member/reviewUpdateModal";
    }

    //'내 저장' > 세미 카테고리 > 내가 좋아요 한(게시글) 컨텐츠
    @GetMapping("getLikePostsFragment.do")
    public String getLikePosts(HttpSession session, Model model) {
//        MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
        MemberDTO memberDTO = MemberDTO.builder().member_email("user1@example.com").build();
        List<LikePostsDTO> likePostsList = memberService.getLikePosts(memberDTO.getMember_email());
        model.addAttribute("likePostsList", likePostsList);
        return "member/likePostsFragment";
    }

    //'내 저장' > 세미 카테고리 > 내 게시글 컨텐츠
    @GetMapping("getMyPosts.do")
    public String getMyPosts(HttpSession session, Model model) {
//        MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
        MemberDTO memberDTO = MemberDTO.builder().member_email("user1@example.com").build();
        List<PostDTO> postsList = memberService.getMyPosts(memberDTO.getMember_email());
        log.info("postsList: " + postsList);
        model.addAttribute("postsList", postsList);
        return "member/myPostsFragment";
    }

    //팔로잉 보기
    @GetMapping("viewFollowingModal.do")
    public String viewFollowingModal(HttpSession session, Model model) {
//        MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
        MemberDTO memberDTO = MemberDTO.builder().member_email("user1@example.com").build();
        List<RelationshipsDTO> followingList = memberService.getFollowingList(memberDTO.getMember_email());
        model.addAttribute("followingList", followingList);
        return "member/followingModal";
    }

    //팔로워 보기
    @GetMapping("viewFollowerModal.do")
    public String viewFollowerModal(HttpSession session, Model model) {
//        MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
        MemberDTO memberDTO = MemberDTO.builder().member_email("user1@example.com").build();
        List<RelationshipsDTO> followerList = memberService.getFollowerList(memberDTO.getMember_email());
        model.addAttribute("followerList", followerList);
        return "member/followerModal";
    }
}
