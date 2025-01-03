package com.shinhan.daengdong.post.controller;

import com.shinhan.daengdong.post.vo.PostVO;
import com.shinhan.daengdong.post.model.service.PostServiceInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Slf4j
@Controller
@PropertySource("classpath:application.properties")
@RequestMapping("post/")
public class PostController {

    @Autowired
    private PostServiceInterface postService;

    // 게시글 메인 페이지 조회
    @GetMapping("/posts")
    public String viewMainPage(Model model) {
        // 게시글 목록 조회
        List<PostVO> postList = postService.getTopPosts();
        model.addAttribute("postList", postList);
        return "post/post"; // mainPage.jsp 또는 mainPage.html로 전달
    }
}