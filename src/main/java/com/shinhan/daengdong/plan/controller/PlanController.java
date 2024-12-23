package com.shinhan.daengdong.plan.controller;

import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.model.service.PlanServiceInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/plans")
public class PlanController {

    @Autowired
    private PlanServiceInterface planService;

    @GetMapping("/create")
    public String createPlanForm(Model model) {
        List<String> regions = planService.getAllRegions();
        model.addAttribute("regions", regions);
        return "createPlan"; // createPlan.jsp
    }

    @PostMapping
    public String createPlan(@ModelAttribute PlanDTO planDTO, Model model) {
        planService.savePlan(planDTO);
        model.addAttribute("message", "Plan created successfully!");
        return "redirect:/plans/list"; // 리다이렉트할 페이지 설정
    }
}
