package com.shinhan.daengdong.post.controller;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.post.vo.LikeVO;
import com.shinhan.daengdong.post.dto.PostDTO;
import com.shinhan.daengdong.post.vo.PostVO;
import com.shinhan.daengdong.post.model.service.PostServiceInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
//        List<LikeVO> likeList = postService.getMyLike();
        model.addAttribute("postList", postList);
        return "post/post"; // mainPage.jsp 또는 mainPage.html로 전달
    }

    @PostMapping("/po")
    public String createPost(
            @RequestParam("files[]") List<MultipartFile> files,
            @RequestParam(value="title", required=true) String title,
            @RequestParam(value="category", required=true) String category, // 'category' 필드 받기
            @RequestParam("content") String content, // 'content' 필드 받기

            HttpServletRequest request) {
        log.info(title);
        log.info(category);
        log.info(content);
        log.info(files.toString());

        try {
            // 이미지 저장 및 URL 생성
            List<String> imageUrls = new ArrayList<>();
            for (MultipartFile file : files) {
                String imageUrl = saveImageFile(file); // 파일 저장 로직
                imageUrls.add(imageUrl);
            }

            // 게시글 및 이미지 생성
            PostDTO postDTO = new PostDTO(1, title, content, category, "user1@example.com");
            postService.createPost(postDTO, imageUrls);

//            return ResponseEntity.ok("게시글 생성 성공");
            return "redirect:/post/posts";
        } catch (Exception e) {
             log.error("예외 발생: ", e);

             return "redirect:/post/posts";
        }




//        HttpSession session = request.getSession();
//        if (session == null){
//            // session 없음 = 로그인 시도한 적 없음
//            log.info("세션이 존재하지 않음");
//            return null;
//        }
//
//        // TODO oauth 로그인 할 때 session 안에 MemberDTO 타입의 'member' 등록 되어 있어야 함
//        MemberDTO member = (MemberDTO) session.getAttribute("member");

//        try {
//            int result = postService.createPost(postDTO); // DTO를 직접 전달
//            if (result > 0) {
//                log.info("게시글 생성 성공: " + postDTO.toString());
//                return "redirect:/post/posts";
//            } else {
//                model.addAttribute("error", "게시글 생성 중 문제가 발생했습니다.");
//                return "redirect:/post/posts";
//            }
//        } catch (Exception e) {
//            log.error("예외 발생: ", e);
//            model.addAttribute("error", "서버 오류로 게시글을 생성할 수 없습니다.");
//            return "redirect:/post/posts";
//        }
    }

    private String saveImageFile(MultipartFile file) throws IOException {
        String uploadDir = "C:\\Users\\User\\Desktop\\shinhan\\daeng\\DaengDong\\upload\\";

        // 디렉토리 존재 여부 확인, 없다면 생성
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();  // 디렉토리가 없으면 생성
        }

        // 파일 정보 확인
        log.info("파일 이름: " + file.getOriginalFilename());
        log.info("파일 크기: " + file.getSize());
        log.info("파일 타입: " + file.getContentType());

        // 파일 이름 추출
        String fileName = file.getOriginalFilename();

        // 파일 경로 설정
        String filePath = uploadDir + fileName;

        // 파일 저장
        try {
            file.transferTo(new File(filePath));
            log.info("이미지 파일 저장 경로: " + filePath);  // 파일 경로 로그
        } catch (IOException e) {
            log.error("파일 저장 실패: " + e.getMessage());
            throw new IOException("파일 저장에 실패했습니다.");
        }

        return fileName; // DB에는 파일 이름만 저장
    }
}