package com.shinhan.daengdong.member.controller;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.member.model.service.MemberServiceInterface;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
    public MemberDTO signUp(@RequestBody MemberDTO memberDTO, HttpServletRequest request){
        HttpSession session = request.getSession();
        if (session == null){
            return null;
        }
        MemberDTO member = (MemberDTO) session.getAttribute("member");

        MemberDTO signUpMember = memberService.signUp(memberDTO);
        return signUpMember;
    }

}
