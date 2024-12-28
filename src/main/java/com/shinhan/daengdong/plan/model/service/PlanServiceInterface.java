package com.shinhan.daengdong.plan.model.service;

import com.shinhan.daengdong.plan.dto.PlanDTO;

import java.util.List;

public interface PlanServiceInterface {

    PlanDTO savePlan(PlanDTO planDTO);
    List<PlanDTO> getPublicPlan();
    void planName(PlanDTO planDTO);
    void planDate(PlanDTO planDTO);
    void planState(PlanDTO planDTO);
}
