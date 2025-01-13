package com.shinhan.daengdong.plan.model.service;

import com.shinhan.daengdong.plan.dto.MemberPlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDetailsDTO;
import com.shinhan.daengdong.plan.dto.PlanRelationshipsDTO;
import com.shinhan.daengdong.plan.model.repository.PlanRepositoryImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    // 동행자가 중복으로 저장되는지 확인
    @Override
    public boolean isCompanionExists(Long planId, String memberEmail) {
        return planRepository.isCompanionExists(planId, memberEmail);
    }


    // 우리 회원인지 확인
    @Override
    public boolean isMemberExists(String email) {
        log.info("!!!!!!!!이메일 존재 여부 확인: {}", email);
        boolean exists = planRepository.isMemberExists(email);
        log.info("!!!!!!!!존재 여부 결과: {}", exists);
        return exists;
    }

    // 동행자 삭제
    @Override
    public void deleteCompanionFromPlan(MemberPlanDTO memberPlanDTO) {
        planRepository.deleteCompanion(memberPlanDTO);
    }

    @Override
    public List<PlanDetailsDTO> getPlanDetailsByEmail(String memberEmail) {
        return planRepository.getPlanDetails(memberEmail);
    }

    @Override
    public List<PlanRelationshipsDTO> getFollowingList(String memberEmail) {
        return planRepository.getFollowingList(memberEmail);
    }

    @Override
    public List<PlanRelationshipsDTO> getFollowerList(String memberEmail) {
        return planRepository.getFollowerList(memberEmail);
    }

    @Override
    public PlanDTO findPlanById(Long planId) {
        return planRepository.findPlanById(planId);
    }

    @Override
    public List<PlanDetailsDTO> findPlanPlacesByPlanId(Long planId) {
        return planRepository.findPlanPlacesByPlanId(planId);
    }

}
