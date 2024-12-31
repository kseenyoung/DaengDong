package com.shinhan.daengdong.plan.controller;

import com.shinhan.daengdong.member.dto.MemberDTO;
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

@Slf4j
@Controller
@RequestMapping("/plan")
public class PlanController {

    @Autowired
    private PlanServiceInterface planService;

    // @GetMapping("/create")
    // public String createPlanForm() {
    //     return "plan/createPlan"; // createPlan.jsp
    // }
    @GetMapping("/create")
    public String createPlanForm(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            log.warn("세션이 없어 로그인 페이지로 이동");
            return "redirect:/auth/login.do";
        }

        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            log.warn("세션에 member가 없어 로그인 페이지로 이동");
            return "redirect:/auth/login.do";
        }

        // 필요하면 member 정보 모델에 담아서 화면 표시
        model.addAttribute("member", member);
        return "plan/createPlan";
    }

    @PostMapping("/create")
    @ResponseBody
    public ResponseEntity<?> createPlan(@RequestBody PlanDTO planDTO, HttpServletRequest request) {
        log.info("플랜 등록 요청: {}", planDTO);

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("member") == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        MemberDTO member = (MemberDTO) session.getAttribute("member");
        planDTO.setMemberEmail(member.getMemberEmail()); // 세션 이메일 할당

        long generatedId = 20;
        planDTO.setPlanId(generatedId);
        log.info("생성된 plan_id: {}", planDTO.getPlanId());

        planService.savePlan(planDTO); // DB INSERT
        log.info("PlanRepositoryImpl.save 실행됨: {}", planDTO);


        log.info("플랜이 성공적으로 저장되었습니다.");
        return ResponseEntity.ok("플랜 등록 성공");
        // } else {
        //     log.error("플랜 저장 실패");
        //     return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("플랜 등록 실패");
        // }
    }


    @PostMapping ("/myPlace")
    public String postMyPlace(@RequestBody PlanDTO planDTO, Model model) {
        log.info("POST 요청으로 'myPlace' 호출됨");
        log.info("전송 받은 데이터: {}", planDTO);

        return "plan/myPlace";
    }

    @GetMapping("/myPlace")
    public String getMyPlace(HttpServletRequest request, Model model) {
        log.info("'/myPlace' 요청 처리 시작");

        // 1) 세션 가져오기
        HttpSession session = request.getSession(false);
        if (session == null) {
            log.warn("세션이 존재하지 않습니다. 로그인 후 접근해야 합니다.");
            return "redirect:/auth/login.do";
        }

        // 2) 세션에서 member 가져오기
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            log.warn("세션에 'member'가 존재하지 않습니다. 로그인 페이지로 이동.");
            return "redirect:/auth/login.do";
        }
        // 세션 확인용 로그
        log.info("세션 ID(plan): {}", session.getId());
        log.info("세션에 있는 멤버: {}", member);

        // 3) 공용(공개) 여행플랜 목록 조회
        List<PlanDTO> publicPlans = planService.getPublicPlan();
        for (PlanDTO plan : publicPlans) {
            log.info("Plan ID: {}, Plan Name: {}", plan.getPlanId(), plan.getPlanName());
        }
        model.addAttribute("plans", publicPlans);

        // 4) 원하는 로직(멤버 플랜 목록 등)을 처리한 뒤 myPlace.jsp로 이동
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

    // 여행 날짜 변경 기능의 날짜를 LocalDate형식으로 바꾸기 위해 필요
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(LocalDate.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                if (text != null && !text.isEmpty()) {
                    setValue(LocalDate.parse(text, DateTimeFormatter.ofPattern("yyyy-MM-dd")));
                } else {
                    setValue(null);
                }
            }
        });
    }

    // 여행 공개 여부 상태 변경 기능
    @PostMapping("/planState")
    public String planState(@ModelAttribute PlanDTO planDTO) {
        log.info("여행 공개 여부 수정 요청 데이터: {}", planDTO);
        planService.planState(planDTO);
        return "redirect:/plan/myPlace";
    }

}