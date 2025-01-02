package com.shinhan.daengdong.plan.model.service;

import com.shinhan.daengdong.plan.dto.MemberPlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDTO;

import java.util.List;

public interface PlanServiceInterface {

    Long savePlan(PlanDTO planDTO);
    List<PlanDTO> getPlansByEmail(String email);
    void planName(PlanDTO planDTO);
    void planDate(PlanDTO planDTO);
    void planState(PlanDTO planDTO);
    void addCompanionToPlan(MemberPlanDTO memberPlanDTO);
}
