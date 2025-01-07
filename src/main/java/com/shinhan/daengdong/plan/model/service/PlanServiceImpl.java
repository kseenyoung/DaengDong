package com.shinhan.daengdong.plan.model.service;

import com.shinhan.daengdong.plan.dto.MemberPlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.model.repository.PlanRepositoryImpl;
import com.shinhan.daengdong.plan.model.repository.PlanRepositoryInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class PlanServiceImpl implements PlanServiceInterface {

    @Autowired
    private PlanRepositoryImpl planRepository;

    @Override
    public Long savePlan(PlanDTO planDTO) {
        planRepository.save(planDTO); // Repository 호출
        log.info("Generated Plan ID: {}", planDTO.getPlanId());
        return planDTO.getPlanId(); // 반환된 planId
    }

    @Override
    public List<PlanDTO> getPlansByEmail(String memberEmail) {
        return planRepository.getPlansByEmail(memberEmail);
    }

    @Override
    public void planName(PlanDTO planDTO) {
        planRepository.planName(planDTO);
    }

    @Override
    public void planDate(PlanDTO planDTO) {
        planRepository.planDate(planDTO);
    }

    @Override
    public void planState(PlanDTO planDTO) {
        planRepository.planState(planDTO);
    }

    @Override
    public void addCompanionToPlan(MemberPlanDTO memberPlanDTO) {
        planRepository.saveMemberPlan(memberPlanDTO);
    }

    @Override
    public List<MemberPlanDTO> getCompanionsByPlanId(Long planId) {
        return planRepository.getCompanionsByPlanId(planId);
    }

    @Override
    public boolean isCompanionExists(Long planId, String memberEmail) {
        return planRepository.isCompanionExists(planId, memberEmail);
    }

    @Override
    public void deleteCompanionFromPlan(MemberPlanDTO memberPlanDTO) {
        planRepository.deleteCompanion(memberPlanDTO);
    }
}
