package com.shinhan.daengdong.post.controller;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.model.service.PlanServiceInterface;
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
import java.util.stream.Collectors;

@Slf4j
@Controller
@PropertySource("classpath:application.properties")
@RequestMapping("post/")
public class PostController {

    @Autowired
    private PostServiceInterface postService;
    @Autowired
    private PlanServiceInterface planService;

    @GetMapping("/{postId}")
    public String viewPostDetail(@PathVariable("postId") Long postId, Model model, HttpServletRequest request) {
        // 세션 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("member") == null) {
            log.info("세션이 존재하지 않음 또는 로그인이 필요합니다.");
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }

        // 게시글 상세 정보 조회
        PostVO post = postService.getPostDetail(postId);
        if (post == null) {
            return "error/404"; // 게시글이 없는 경우 에러 페이지
        }

        model.addAttribute("post", post);
        return "post/postDetail"; // postDetail.html 또는 postDetail.jsp
    }


    // 게시글 메인 페이지 조회
    @GetMapping("/posts")
    public String viewMainPage(@RequestParam(value="category", required = false) String category, Model model,HttpServletRequest request) {
        // 게시글 목록 조회
        HttpSession session = request.getSession(false);
        if (session == null){
            // session 없음 = 로그인 시도한 적 없음
            log.info("세션이 존재하지 않음");
            return null;
        }

        // TODO oauth 로그인 할 때 session 안에 MemberDTO 타입의 'member' 등록 되어 있어야 함
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        System.out.println("member.getMember_email() : " +  member.getMember_email());




        List<PostVO> postList;
        if (category != null && !category.isEmpty()) {
            postList = postService.getPostsByCategory(category); // 카테고리에 맞는 게시물 조회
        } else {
            postList = postService.getTopPosts(); // 카테고리가 없으면 최신 게시물 조회
        }

        List<LikeVO> myLike = postService.getMyLike(member.getMember_email());
        List<PlanDTO> userPlans = planService.getPlansByEmail(member.getMember_email());

        model.addAttribute("plans", userPlans);
        String likePostIdsString = myLike.stream()
                .map(like -> like.getPostId().toString())
                .collect(Collectors.joining(","));
        model.addAttribute("myLike", likePostIdsString);

        model.addAttribute("postList", postList);
        return "post/post"; // mainPage.jsp 또는 mainPage.html로 전달
    }

    @PostMapping("/po")
    public String createPost(
            @RequestParam(value="title", required=true) String title,
            @RequestParam(value="category", required=true) String category, // 'category' 필드 받기
            @RequestParam(value="planId", required=true) long planId, // 'category' 필드 받기
            @RequestParam("content") String content, // 'content' 필드 받기
            @RequestParam(value="files[]", required=true) List<MultipartFile> files,
            HttpServletRequest request) {


        HttpSession session = request.getSession(false);
        if (session == null){
            // session 없음 = 로그인 시도한 적 없음
            log.info("세션이 존재하지 않음");
            return null;
        }

        // TODO oauth 로그인 할 때 session 안에 MemberDTO 타입의 'member' 등록 되어 있어야 함
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        System.out.println("member.getMember_email() : " +  member.getMember_email());

        try {
            // 이미지 저장 및 URL 생성
            List<String> imageUrls = new ArrayList<>();
            for (MultipartFile file : files) {
                String imageUrl = saveImageFile(file); // 파일 저장 로직
                imageUrls.add(imageUrl);
            }

            // 게시글 및 이미지 생성
            PostDTO postDTO = new PostDTO(planId, title, content, category, member.getMember_email());
            postService.createPost(postDTO, imageUrls);

//            return ResponseEntity.ok("게시글 생성 성공");
            return "redirect:/post/posts";
        } catch (Exception e) {
             log.error("예외 발생: ", e);

             return "redirect:/post/posts";
        }


    }

    private String saveImageFile(MultipartFile file) throws IOException {
        String uploadDir = "C:\\Users\\User\\Desktop\\shinhan\\daeng\\DaengDong\\src\\main\\webapp\\upload\\";

        // 디렉토리 존재 여부 확인, 없다면 생성
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();  // 디렉토리가 없으면 생성
        }

        // 파일 정보 확인
        log.info("파일 이름: " + file.getOriginalFilename());
        log.info("파일 크기: " + file.getSize());
        log.info("파일 타입: " + file.getContentType());

        // 기존 파일 이름 추출
        String fileName = file.getOriginalFilename();

        // 확장자 추출
        String extension = fileName.substring(fileName.lastIndexOf("."));

        // 기존 파일 이름과 현재 시간 합쳐서 고유한 파일 이름 생성
        String uniqueFileName = fileName.substring(0, fileName.lastIndexOf("."))
                + "_" + System.currentTimeMillis()
                + extension;

        // 파일 경로 설정
        String filePath = uploadDir + uniqueFileName;

        // 파일 저장
        try {
            file.transferTo(new File(filePath));
            log.info("이미지 파일 저장 경로: " + filePath);  // 파일 경로 로그
        } catch (IOException e) {
            log.error("파일 저장 실패: " + e.getMessage());
            throw new IOException("파일 저장에 실패했습니다.");
        }
        return uniqueFileName; // DB에는 파일 이름만 저장
    }


    @PostMapping("/like")
    public ResponseEntity<?> addLike(@RequestParam Long postId, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 정보가 없습니다.");
        }

        String memberEmail = member.getMember_email();
        postService.addLike(postId, memberEmail);
        return ResponseEntity.ok().build();
    }

}