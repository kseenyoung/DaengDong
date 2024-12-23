package com.shinhan.daengdong.plan.model.service;

import com.shinhan.daengdong.plan.dto.PlanDTO;

import java.util.List;

public interface PlanServiceInterface {

    List<String> getAllRegions();
    PlanDTO savePlan(PlanDTO planDTO);
}
