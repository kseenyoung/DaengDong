package com.shinhan.daengdong.member.controller;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.member.model.service.MemberServiceInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Slf4j
@Controller
public class MemberController {

    @Autowired
    MemberServiceInterface memberService;

    @GetMapping("login.do")
    public String login(){
        MemberDTO m = memberService.login(new MemberDTO().builder()
                .memberEmail("kseenyoung")
                .build());
        log.info("로그인 member : " + m);
        return "member/login";
    }
}
