package com.shinhan.daengdong.plan.model.repository;

import com.shinhan.daengdong.plan.dto.PlanDTO;

import java.util.List;

public interface PlanRepositoryInterface {
    void save(PlanDTO planDTO);
    List<PlanDTO> getPlansByEmail(String memberEmail);
    void planName(PlanDTO planDTO);
    void planDate(PlanDTO planDTO);
    void planState(PlanDTO planDTO);
}
