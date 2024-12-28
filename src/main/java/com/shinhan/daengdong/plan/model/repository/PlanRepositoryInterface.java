package com.shinhan.daengdong.plan.model.repository;

import com.shinhan.daengdong.plan.dto.PlanDTO;

import java.util.List;

public interface PlanRepositoryInterface {
    void save(PlanDTO planDTO);
    List<PlanDTO> getPlansByState();
    void planName(PlanDTO planDTO);
}
