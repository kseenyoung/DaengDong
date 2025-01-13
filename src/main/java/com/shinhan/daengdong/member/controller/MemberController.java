package com.shinhan.daengdong.member.controller;

import com.shinhan.daengdong.member.dto.*;
import com.shinhan.daengdong.member.model.service.MemberServiceInterface;
import com.shinhan.daengdong.pet.dto.PetDTO;
import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.model.service.PlanServiceInterface;
import com.shinhan.daengdong.post.dto.PostDTO;
import com.shinhan.daengdong.review.dto.ReviewDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Controller
@PropertySource("classpath:application.properties")
@RequestMapping("auth/")
public class MemberController {

    @Autowired
    private MemberServiceInterface memberService;

    @Autowired
    private PlanServiceInterface planService;

    @Value("${kakao.login.rest_api_key}")
    String rest_api_key;

    @Value("${kakao.login.redirect_uri}")
    String redirect_uri;

    @GetMapping("login.do")
    public String login(HttpServletRequest request) {
        log.info("로그인 페이지 요청");
        request.setAttribute("rest_api_key", rest_api_key);
        request.setAttribute("redirect_uri", redirect_uri);
        return "member/login";
    }

    // 회원가입 보기
    @GetMapping("signUp.do")
    public String signUp() {
        log.info("회원가입 페이지 요청");
        return "member/signUp";
    }

    // 회원가입 실행
    @PostMapping("signUp.do")
    @ResponseBody
    public SignUpDTO signUp(@RequestBody SignUpDTO signUpDTO, HttpServletRequest request) {
        log.info("회원가입 요청 데이터: {}", signUpDTO);
        HttpSession session = request.getSession();
        if (session == null) {
            // session 없음 = 로그인 시도한 적 없음
            log.info("세션이 존재하지 않음");
            return null;
        }

        // TODO oauth 로그인 할 때 session 안에 MemberDTO 타입의 'member' 등록 되어 있어야 함
        MemberDTO member = (MemberDTO) session.getAttribute("member");

        // signUpDTO에 session에 저장된 MemberDTO 정보 삽입
        signUpDTO.setMemberEmail(member.getMember_email());
        signUpDTO.setMemberProfilePhoto(member.getMember_profile_photo());
        if (signUpDTO.getMemberNickname() == null) {
            if (member.getMember_nickname() != null) {
                signUpDTO.setMemberNickname(member.getMember_nickname());
            } else {
                log.error("닉네임이 null입니다.");
                // 적절한 기본값을 설정하거나 에러 처리
            }
        }
        log.info("member in session !! : " + member);

        MemberDTO signUpMember = memberService.signUp(signUpDTO);
        session.setAttribute("member", signUpMember);
        return signUpDTO;
    }

    //회원가입 > 펫 추가
    @PostMapping("createPetProfile.do")
    @ResponseBody
    public int createPetProfile(@RequestBody PetDTO petDTO, HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        petDTO.setMember_email(member.getMember_email());
        log.info("petDTO: " + petDTO);
        memberService.createPetProfile(petDTO);
        PetDTO petVO = selectOnetMyPet(petDTO);
        session.setAttribute("pet_id", petVO.getPet_id());
        log.info("pet_id: " + petVO.getPet_id());
        return petVO.getPet_id();
    }

    //회원가입 > 펫 찾기
    public PetDTO selectOnetMyPet(PetDTO petDTO) {
        return memberService.selectOnetMyPet(petDTO);
    }

    //회원가입 > 펫 삭제
    @DeleteMapping("petProfile/{petId}")
    @ResponseBody
    public ResponseEntity<Void> deleteOneMyPet(@PathVariable int petId) {
        log.info("Deleting pet with ID: {}", petId);
        memberService.deletePetByPetId(petId);
        return ResponseEntity.ok().build();
    }


    //마이페이지 보기
    @GetMapping("viewMypage.do")
    public String viewMypage(HttpSession session) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        if (memberDTO == null) {
            return "redirect:/auth/login.do";
        }
        return "member/mypage";
    }

    //마이페이지 > 유저 정보
    @GetMapping("getProfileFragment.do")
    public String getProfileFragment(HttpSession session, Model model) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");

        MemberDTO selectMember = memberService.selectMember(memberDTO.getMember_email());
        List<PetDTO> petList = memberService.selectPet(memberDTO.getMember_email());
        int countFollowing = memberService.getFollowingList(memberDTO.getMember_email()).size();
        int countFollower = memberService.getFollowerList(memberDTO.getMember_email()).size();

        model.addAttribute("selectMember", selectMember);
        model.addAttribute("petList", petList);
        model.addAttribute("countFollowing", countFollowing);
        model.addAttribute("countFollower", countFollower);
        return "member/profileFragment";
    }

    //마이페이지 > 유저 사진 변경
    @PostMapping("modifyProfile.do")
    public void modifyProfile(@RequestBody ImageDTO image, HttpSession session) {
        log.info("imageUrl: " + image);
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        member.setMember_profile_photo(image.getImageUrl());
        log.info("member: " + member);
        memberService.modifyProfilePhoto(member);
    }

    //마이페이지 > 펫 사진 변경
    @PostMapping("modifyPetProfile.do")
    public void modifyPetProfile(@RequestBody PetImageDTO image) {
        log.info("imageUrl: " + image);
        PetDTO petDTO = new PetDTO();
        petDTO.setPet_profile_photo(image.getImageUrl());
        petDTO.setPet_id(image.getPetId());
        log.info("petDTO: " + petDTO);
        memberService.modifyPetProfilePhoto(petDTO);
    }

    //마이페이지 > 유저 닉네임 변경 페이지 보기
    @GetMapping("viewNickNameEdit.do")
    public String viewNickNameEdit() {
        return "member/editNickName";
    }

    //'내 여행' > 세미 카테고리
    @GetMapping("getSemiTripCategory.do")
    public String getSemiTripCategory() {

        return "member/semiCategory/trip";
    }

    //'내 포토카드' > 세미 카테고리
    @GetMapping("getSemiPhotoCardCategory.do")
    public String getSemiPhotoCardCategory() {
        return "member/semiCategory/photoCard";
    }

    //'내 저장' > 세미 카테고리
    @GetMapping("getSemiSaveCategory.do")
    public String getSemiSaveCategory() {
        return "member/semiCategory/save";
    }

    //'내 여행' > 여행계획중
    @GetMapping("getMyPlanning.do")
    public String getMyPlanningList(HttpSession session, Model model) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        List<PlanDTO> myPlans = planService.getPlansByEmail(memberDTO.getMember_email());
        List<PlanDTO> planningPlan = new ArrayList<>();

        Date currentDate = new Date();

        for (PlanDTO eachPlan : myPlans) {
            if (eachPlan.getStartDate() != null && eachPlan.getStartDate().after(currentDate)) {
                planningPlan.add(eachPlan);
            }
        }

        model.addAttribute("planningPlan", planningPlan);
        log.info("member: " + memberDTO);
        log.info("planningPlan: " + planningPlan);
        return "member/semiCategory/trip/planningFragment";
    }

    //'내 여행' > 여행중
    @GetMapping("getMyTraveling.do")
    public String getMyTravelingList(HttpSession session, Model model) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        List<PlanDTO> myPlans = planService.getPlansByEmail(memberDTO.getMember_email());
        List<PlanDTO> travelingPlan = new ArrayList<>();

        Date currentDate = new Date();

        for (PlanDTO eachPlan : myPlans) {
            if (nowTraveling(eachPlan.getStartDate(), eachPlan.getEndDate(), currentDate)) {
                travelingPlan.add(eachPlan);
            }
        }

        model.addAttribute("travelingPlan", travelingPlan);
        return "member/semiCategory/trip/travelingFragment";
    }

    //현재 여행 중인지 판별 (서버날짜와 여행시작,종료 날짜 비교)
    private static boolean nowTraveling(Date startDate, Date endDate, Date currentDate) {
        if (startDate == null || endDate == null) {
            return false;
        }

        // 날짜 부분만 비교
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String current = sdf.format(currentDate);
        String start = sdf.format(startDate);
        String end = sdf.format(endDate);

        return current.equals(start) || current.equals(end) ||
                (current.compareTo(start) > 0 && current.compareTo(end) < 0);
    }

    //'내 여행' > 여행완료
    @GetMapping("getMyTravelComplete.do")
    public String getMyTravelComplete(HttpSession session, Model model) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        List<PlanDTO> myPlans = planService.getPlansByEmail(memberDTO.getMember_email());
        List<PlanDTO> completePlan = new ArrayList<>();

        Date currentDate = new Date();

        for (PlanDTO eachPlan : myPlans) {
            if (eachPlan.getEndDate() != null && currentDate.after(eachPlan.getEndDate())) {
                completePlan.add(eachPlan);
            }
        }

        model.addAttribute("completePlan", completePlan);
        return "member/semiCategory/trip/completeTravelFragment";
    }

    //'내 저장' > 즐겨찾기(장소) 컨텐츠
    @GetMapping("getFavoritePlace.do")
    public String getFavoritePlaceList(HttpSession session, Model model) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        List<FavoritePlaceDTO> favoritePlaceList = memberService.getFavoritePlaceList(memberDTO.getMember_email());
        model.addAttribute("favoritePlaceList", favoritePlaceList);
        return "member/semiCategory/save/favoritePlaceFragment";
    }

    //'내 저장' > 내가 쓴 리뷰(장소) 컨텐츠
    @GetMapping("getReviewFragment.do")
    public String getReviewList(HttpSession session, Model model) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        List<ReviewDTO> reviewList = memberService.getReviewList(memberDTO.getMember_email());
        model.addAttribute("reviewList", reviewList);
        return "member/semiCategory/save/reviewFragment";
    }

    //'내 저장' > 내가 쓴 리뷰(장소) 모달
    @GetMapping("getReviewModal.do")
    public String getReviewModal(@RequestParam int reviewId,
                                 @RequestParam String reviewContent,
                                 @RequestParam int reviewRating,
                                 @RequestParam String kakaoPlaceName,
                                 @RequestParam String imageUrl,
                                 Model model) {
        model.addAttribute("reviewId", reviewId);
        model.addAttribute("reviewContent", reviewContent);
        model.addAttribute("reviewRating", reviewRating);
        model.addAttribute("kakaoPlaceName", kakaoPlaceName);
        model.addAttribute("imageUrl", imageUrl);
        return "member/semiCategory/save/reviewUpdateModal";
    }

    //'내 저장' > 내가 좋아요 한(게시글) 컨텐츠
    @GetMapping("getLikePostsFragment.do")
    public String getLikePosts(HttpSession session, Model model) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        List<LikePostsDTO> likePostsList = memberService.getLikePosts(memberDTO.getMember_email());
        model.addAttribute("likePostsList", likePostsList);
        return "member/semiCategory/save/likePostsFragment";
    }

    //'내 저장' > 내 게시글 컨텐츠
    @GetMapping("getMyPosts.do")
    public String getMyPosts(HttpSession session, Model model) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        List<PostDTO> postsList = memberService.getMyPosts(memberDTO.getMember_email());
        log.info("postsList: " + postsList);
        model.addAttribute("postsList", postsList);
        return "member/semiCategory/save/myPostsFragment";
    }

    //팔로잉 보기
    @GetMapping("viewFollowingModal.do")
    public String viewFollowingModal(HttpSession session, Model model) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        List<RelationshipsDTO> followingList = memberService.getFollowingList(memberDTO.getMember_email());
        model.addAttribute("followingList", followingList);
        return "member/followingModal";
    }

    //팔로워 보기
    @GetMapping("viewFollowerModal.do")
    public String viewFollowerModal(HttpSession session, Model model) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        List<RelationshipsDTO> followerList = memberService.getFollowerList(memberDTO.getMember_email());
        model.addAttribute("followerList", followerList);
        return "member/followerModal";
    }

    @GetMapping("viewPhotoCard")
    public String viewPhotoCard() {
        return "photocard/seoul";
    }
}
