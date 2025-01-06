package com.shinhan.daengdong.chat.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {

    @GetMapping("chatRoom.do")
    public String viewChat(HttpSession session) {
        return "chat/chatFragment";
    }
}
