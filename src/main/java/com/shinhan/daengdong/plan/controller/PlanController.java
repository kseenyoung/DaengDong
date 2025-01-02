package com.shinhan.daengdong.plan.controller;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.plan.dto.MemberPlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.model.service.PlanServiceInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/plan")
public class PlanController {

    @Autowired
    private PlanServiceInterface planService;

    // 플랜 생성 페이지
    @GetMapping("/create")
    public String createPlanForm(HttpServletRequest request, Model model) {
        try {
            HttpSession session = request.getSession(false);

            MemberDTO member = (MemberDTO) session.getAttribute("member");
            model.addAttribute("member", member);
            return "plan/createPlan";
        } catch (IllegalStateException e) {
            log.info(e.getMessage());
            return "redirect:/auth/login.do";
        }
    }

    @PostMapping("/create")
    public String createPlan(@RequestBody PlanDTO planDTO, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        MemberDTO member = (MemberDTO) session.getAttribute("member");
        planDTO.setMemberEmail(member.getMember_email()); // 세션 이메일 할당

        log.info("생성된 plan_id: {}", planDTO.getPlanId());

        // DB에 플랜 저장 및 생성된 planId 반환
        Long planId = planService.savePlan(planDTO); // DB INSERT
        log.info("PlanRepositoryImpl.save 실행됨: {}", planDTO);
        log.info("생성된 plan_id: {}", planId);

        // 반환된 planId를 세션에 저장
        session.setAttribute("currentPlanId", planId);
        session.setAttribute("currentMemberEmail", member.getMember_email());

        session.setAttribute("currentPlan", planDTO);
        return "redirect:/plan/place";
    }

    @GetMapping("/myPlace")
    public String getMyPlace(HttpServletRequest request, Model model) {
        try {
            HttpSession session = request.getSession(false);

            MemberDTO member = (MemberDTO) session.getAttribute("member");

            String memberEmail = member.getMember_email();
            List<PlanDTO> userPlans = planService.getPlansByEmail(memberEmail);

            model.addAttribute("plans", userPlans);

            return "plan/myPlace";
        } catch (Exception e) {
            log.info(e.getMessage());
            return "redirect:/auth/login.do";
        }
    }

    @PostMapping ("/myPlace")
    public String postMyPlace(@RequestBody PlanDTO planDTO, Model model) {

        return "plan/myPlace";
    }


    // @GetMapping("/myPlace")
    // public String getMyPlace(Model model) {
    //     List<PlanDTO> publicPlans = planService.getPublicPlan();
    //     for (PlanDTO plan : publicPlans) log.info("Plan ID: {}, Plan Name: {}", plan.getPlanId(), plan.getPlanName());
    //     model.addAttribute("plans", publicPlans);
    //
    //     return "plan/myPlace"; // myPlace.jsp 반환
    // }

    // newPlan.jsp / WBS - 새로운 프로젝트 생성 기능
    @GetMapping("/newPlan")
    public String newPlanForm() {
        return "plan/newPlan";
    }

    // 여행 프로젝트 제목 수정 기능
    @PostMapping("/planName")
    public String planName(@ModelAttribute PlanDTO planDTO) {
        log.info("여행 제목 수정 요청 데이터: {}", planDTO);
        planService.planName(planDTO);
        return "redirect:/plan/myPlace";
    }

    // 여행 날짜 변경 기능
    @PostMapping("/planDate")
    public String planDate(@ModelAttribute PlanDTO planDTO) {
        log.info("여행 기간 수정 요청 데이터: {}", planDTO);
        planService.planDate(planDTO);
        return "redirect:/plan/myPlace";
    }

    // 여행 공개 여부 상태 변경 기능
    @PostMapping("/planState")
    @ResponseBody
    public ResponseEntity<?> updatePlanState(@RequestBody PlanDTO planDTO) {
        try {
            planService.planState(planDTO);
            return ResponseEntity.ok("플랜 상태가 성공적으로 변경되었습니다.");
        } catch (Exception e) {
            log.error("플랜 상태 변경 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("플랜 상태 변경 실패");
        }
    }

    @GetMapping("/place")
    public String searchPlaceForm(HttpServletRequest request, Model model) {

        return "place/searchPlace"; // searchPlace.jsp
    }

    @PostMapping("addCompanion")
    public ResponseEntity<?> addCompanion(@RequestBody String companionEmail, HttpSession session) {

        // 세션에서 planId와 memberEmail 가져오기
        Long currentPlanId = (Long) session.getAttribute("currentPlanId");
        String currentMemberEmail = (String) session.getAttribute("currentMemberEmail");

        // 세션 값 로그로 출력
        log.info("currentPlanId: {}", currentPlanId);
        log.info("currentMemberEmail: {}", currentMemberEmail);

        // 첫 번째 저장: 현재 사용자의 이메일
        MemberPlanDTO currentUserPlan = new MemberPlanDTO();
        currentUserPlan.setPlanId(currentPlanId);
        currentUserPlan.setMemberEmail(currentMemberEmail);
        planService.addCompanionToPlan(currentUserPlan);

        // 두 번째 저장: 입력된 동행자의 이메일
        MemberPlanDTO companionPlan = new MemberPlanDTO();
        companionPlan.setPlanId(currentPlanId);
        companionPlan.setMemberEmail(companionEmail);
        planService.addCompanionToPlan(companionPlan);

        return ResponseEntity.ok("동행자가 성공적으로 추가되었습니다.");
    }

}