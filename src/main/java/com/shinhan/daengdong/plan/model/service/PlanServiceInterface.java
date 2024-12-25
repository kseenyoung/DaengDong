package com.shinhan.daengdong.plan.model.service;

import com.shinhan.daengdong.plan.dto.PlanDTO;

import java.util.List;

public interface PlanServiceInterface {

    //PlanDTO savePlan(PlanDTO planDTO);
    void saveTempPlan(PlanDTO planDTO);
    void commitPlans();
    List<PlanDTO> getTempPlans();
}
