package com.shinhan.daengdong.member.controller;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.member.model.service.GoogleOauthService;
import com.shinhan.daengdong.member.model.service.KakaoOauthService;
import com.shinhan.daengdong.member.model.service.MemberServiceInterface;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        System.out.println("kakaoEmail : " + kakaoMember);

        MemberDTO kakaoUser = memberService.isMember(kakaoMember);

        if (kakaoUser == null) {
            // TODO : DB에 존재하지 않는 이메일(회원가입)

        }

        // 로그인 처리
        session = request.getSession();
        session.setAttribute("member", kakaoUser);
        // TODO : Debug용 지우기
        request.setAttribute("member", kakaoUser);
        //
        return "home";
    }
}
