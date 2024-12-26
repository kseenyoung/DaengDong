package com.shinhan.daengdong.member.controller;

import com.shinhan.daengdong.member.dto.FavoritePlaceDTO;
import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.member.dto.SignUpDTO;
import com.shinhan.daengdong.member.model.service.MemberServiceInterface;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.shinhan.daengdong.review.dto.ReviewDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
        request.setAttribute("rest_api_key", rest_api_key);
        request.setAttribute("redirect_uri", redirect_uri);
        return "member/login";
    }

    // 회원가입 페이지
    @GetMapping("signUp.do")
    public String signUp(){
        return "member/signUp";
    }

    @PostMapping("signUp.do")
    @ResponseBody
    public SignUpDTO signUp(@RequestBody SignUpDTO signUpDTO, HttpServletRequest request){
        log.info("signUpDTO : " + signUpDTO);
        HttpSession session = request.getSession();
        if (session == null){
            // session 없음 = 로그인 시도한 적 없음
            log.info("session is null");
            return null;
        }

        // TODO oauth 로그인 할 때 session 안에 MemberDTO 타입의 'member' 등록 되어 있어야 함
        MemberDTO member = (MemberDTO) session.getAttribute("member");

        // signUpDTO에 session에 저장된 MemberDTO 정보 삽입
        signUpDTO.setMemberEmail(member.getMemberEmail());
        signUpDTO.setMemberProfilePhoto(member.getMemberProfilePhoto());
        if(signUpDTO.getMemberNickname()==null){
            signUpDTO.setMemberNickname(member.getMemberNickname());
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
    public String getProfileFragment() {
        return "member/profileFragment";
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
        MemberDTO memberDTO = MemberDTO.builder().memberEmail("user1@example.com").build();
        List<FavoritePlaceDTO> favoritePlaceList = memberService.getFavoritePlaceList(memberDTO.getMemberEmail());
        model.addAttribute("favoritePlaceList", favoritePlaceList);
        return "member/favoritePlace";
    }

    //'내 저장' > 세미 카테고리 > 내가 쓴 리뷰(장소) 컨텐츠
    @GetMapping("getReviewFragment.do")
    public String getReviewList(HttpSession session, Model model) {
//        MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberDTO");
        MemberDTO memberDTO = MemberDTO.builder().memberEmail("user1@example.com").build();
        List<ReviewDTO> reviewList = memberService.getReviewList(memberDTO.getMemberEmail());
        model.addAttribute("reviewList", reviewList);
        log.info("reviewList: " + reviewList);
        return "member/reviewFragment";
    }
}
