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

    @Autowired
    private PlanServiceInterface planService;

    @GetMapping("/create")
    public String createPlanForm() {
        return "plan/createPlan"; // createPlan.jsp
    }

    @PostMapping ("/myPlace")
    public String postMyPlace(@RequestBody PlanDTO planDTO, Model model) {
        log.info("POST 요청으로 'myPlace' 호출됨");
        log.info("전송 받은 데이터: {}", planDTO);

        return "plan/myPlace";
    }

    @GetMapping("/myPlace")
    public String getMyPlace() {
        return "plan/myPlace"; // JSP 파일 반환
    }

    // newPlan.jsp / WBS - 새로운 프로젝트 생성 기능
    @GetMapping("/newPlan")
    public String newPlanForm() {
        return "plan/newPlan";
    }

}