package com.shinhan.daengdong.member.controller;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.member.model.service.GoogleOauthService;
import com.shinhan.daengdong.member.model.service.KakaoOauthService;
import com.shinhan.daengdong.member.model.service.MemberServiceInterface;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
@Controller
@RequestMapping("/oauth")
public class OauthController {

    @Autowired
    KakaoOauthService kakaoOauthService;

    @Autowired
    GoogleOauthService googleOauthService;

    @Autowired
    MemberServiceInterface memberService;

    @GetMapping("kakao/code")
    public String getKakaoCode(@RequestParam String code, HttpServletRequest request){
        HttpSession session;

        String access_Token = kakaoOauthService.getToken(code);
        MemberDTO kakaoMember = kakaoOauthService.getUser(access_Token);
        log.info("kakaoEmail : " + kakaoMember);

        MemberDTO member = memberService.login(kakaoMember.getMember_email());

        // session 등록
        session = request.getSession();
        log.info("kakaoMember: " + kakaoMember);
        session.setAttribute("member", kakaoMember);

        if (member == null) {
            // TODO : DB에 존재하지 않는 이메일
            return "redirect:/auth/signUp.do";
        }

        return "redirect:/home";
    }
}
