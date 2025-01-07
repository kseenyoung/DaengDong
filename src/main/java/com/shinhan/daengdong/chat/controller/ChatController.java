package com.shinhan.daengdong.chat.controller;

import com.shinhan.daengdong.member.dto.MemberDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {

    @GetMapping("/{member_email}")
    public String viewChat(@PathVariable("member_email") String member_email, HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        log.info("ChatController viewChat");
        log.info("member: " + member);
        return "chat/chatFragment";
    }
}
