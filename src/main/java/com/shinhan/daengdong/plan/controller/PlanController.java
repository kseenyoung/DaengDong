package com.shinhan.daengdong.plan.controller;

import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.model.service.PlanServiceInterface;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/plan")
public class PlanController {

    private static final Logger logger = LoggerFactory.getLogger(PlanController.class);

    @Autowired
    private PlanServiceInterface planService;

    @GetMapping("/create")
    public String createPlanForm() {
        return "plan/createPlan"; // createPlan.jsp
    }

    @PostMapping ("/myPlace")
    public String postMyPlace(@RequestBody PlanDTO planDTO, Model model) {
        logger.info("POST 요청으로 'myPlace' 호출됨");
        logger.info("전송 받은 데이터: {}", planDTO);

        return "plan/myPlace";
    }

    @GetMapping("/myPlace")
    public String getMyPlace() {
        return "plan/myPlace"; // JSP 파일 반환
    }

    @PostMapping
    public String createPlan(@RequestBody PlanDTO planDTO, Model model) {
        // 전달받은 planDTO 데이터 로그
        logger.info("전달받은 planDTO 정보: {}", planDTO);
        logger.info("여행 이름: {}", planDTO.getPlanName());
        logger.info("기간: {}", planDTO.getStartDate() + " ~ " + planDTO.getEndDate());
        logger.info("공개여부: {}", planDTO.getPlanState());

        //planService.savePlan(planDTO); 바로 plan/create페이지에서 입력받은것을 저장
        planService.saveTempPlan(planDTO);  // 임시 저장
        model.addAttribute("message", "플랜이 임시로 저장되었습니다.");
        return "redirect:/plan/myPlace"; // 리다이렉트할 페이지 설정
    }

    @PostMapping("/commit")
    public String commitPlans(Model model) {
        // 최종적으로 commit
        planService.commitPlans();
        model.addAttribute("message", "플랜이 성공적으로 저장되었습니다.");
        return "redirect:/plan/list";
    }
}