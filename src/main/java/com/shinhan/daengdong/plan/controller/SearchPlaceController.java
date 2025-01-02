package com.shinhan.daengdong.plan.controller;

import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.model.service.PlanServiceInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/search")
public class SearchPlaceController {

    @Autowired
    private PlanServiceInterface planService;

    @GetMapping("/place")
    public String searchPlaceForm(Model model) {
        return "place/searchPlace"; // searchPlace.jsp
    }

}
