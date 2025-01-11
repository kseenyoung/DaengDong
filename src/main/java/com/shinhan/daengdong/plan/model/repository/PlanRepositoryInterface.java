package com.shinhan.daengdong.plan.model.repository;

import com.shinhan.daengdong.plan.dto.MemberPlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDetailsDTO;
import com.shinhan.daengdong.plan.dto.PlanRelationshipsDTO;

import java.util.List;

public interface PlanRepositoryInterface {
    void save(PlanDTO planDTO);
    List<PlanDTO> getPlansByEmail(String memberEmail);
    void planName(PlanDTO planDTO);
    void planDate(PlanDTO planDTO);
    void planState(PlanDTO planDTO);
    void saveMemberPlan(MemberPlanDTO memberPlanDTO);
    List<MemberPlanDTO> getCompanionsByPlanId(Long PlanId);
    boolean isCompanionExists(Long planId, String memberEmail);
    public boolean isMemberExists(String email);
    void deleteCompanion(MemberPlanDTO memberPlanDTO);
    List<PlanDetailsDTO> getPlanDetails(String memberEmail);
    List<PlanRelationshipsDTO> getFollowingList(String memberEmail);
    List<PlanRelationshipsDTO> getFollowerList(String memberEmail);
}
