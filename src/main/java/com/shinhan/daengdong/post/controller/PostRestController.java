package com.shinhan.daengdong.post.controller;

import com.shinhan.daengdong.post.model.service.PostServiceInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Slf4j
@RestController
@RequestMapping("/myPost")
public class PostRestController {

    @Autowired
    PostServiceInterface postService;

    @DeleteMapping("/{post_id}")
    public ResponseEntity<Void> deleteMyPost(@PathVariable("post_id") int postId) {
        log.info("success delete: " + postId);
        postService.deletePost(postId);
        return ResponseEntity.ok().build();
    }
}
