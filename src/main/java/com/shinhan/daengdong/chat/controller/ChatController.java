package com.shinhan.daengdong.chat.controller;

import com.shinhan.daengdong.chat.dto.ChatMessageDTO;
import com.shinhan.daengdong.chat.model.service.SupabaseChatService;
import com.shinhan.daengdong.member.dto.MemberDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private SupabaseChatService supabaseChatService;

    @GetMapping("/{planId}/messages")
    @ResponseBody
    public List<ChatMessageDTO> getMessages(@PathVariable int planId) {
        return supabaseChatService.getMessagesByPlanId(planId);
    }

    @GetMapping("room/{planId}")
    public String viewChat(@PathVariable("planId") int planId, HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");

        //testCode
        if (member == null) {
            member = MemberDTO.builder()
                    .member_email("guest@naver.com")
                    .member_name("셜록")
                    .member_nickname("셜로쿠")
                    .member_profile_photo(null)
                    .build();
            session.setAttribute("member", member);
        }

        session.setAttribute("planId", planId);
        log.info("User '{}' joined chat room {}", member.getMember_email(), planId);

        return "chat/chatFragment";
    }

    // 카카오 로그인 없이 직접 세션 설정
    @GetMapping("/direct/{member_email}")
    public String directLogin(@PathVariable("member_email") String member_email, HttpSession session) {
        // 임의의 MemberDTO 생성 및 세션에 저장
        MemberDTO member = MemberDTO.builder()
                .member_email(member_email)
                .member_name("Guest " + member_email)
                .member_nickname("Guest")
                .member_profile_photo(null) // 테스트를 위해 null로 설정 가능
                .build();

        session.setAttribute("member", member);
        log.info("Direct login for member: " + member);
        return "redirect:/chat/" + member_email; // 채팅방으로 리다이렉트
    }
}
