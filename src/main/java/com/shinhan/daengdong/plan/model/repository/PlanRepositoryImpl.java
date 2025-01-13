package com.shinhan.daengdong.plan.model.repository;

import com.shinhan.daengdong.plan.dto.MemberPlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDetailsDTO;
import com.shinhan.daengdong.plan.dto.PlanRelationshipsDTO;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Repository
public class PlanRepositoryImpl implements PlanRepositoryInterface {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;  // MyBatis 세션 사용

    @Override
    public void save(PlanDTO planDTO) {
        log.info("Before save, PlanDTO: {}", planDTO);
        int result = sqlSessionTemplate.insert("com.shinhan.plan.save", planDTO); // XML 매핑된 쿼리 호출
        log.info("Before save, PlanDTO: {}", planDTO);
        log.info("Insert result: {}", result);
    }

    @Override
    public List<PlanDTO> getPlansByEmail(String memberEmail) {
        return sqlSessionTemplate.selectList("com.shinhan.plan.planList", memberEmail);
    }

    @Override
    public void planName(PlanDTO planDTO) {
        sqlSessionTemplate.update("com.shinhan.plan.planName", planDTO);
    }

    @Override
    public void planDate(PlanDTO planDTO) {
        sqlSessionTemplate.update("com.shinhan.plan.planDate", planDTO);
    }

    @Override
    public void planState(PlanDTO planDTO) {
        sqlSessionTemplate.update("com.shinhan.plan.planState", planDTO);
    }

    @Override
    public void saveMemberPlan(MemberPlanDTO memberPlanDTO) {
        sqlSessionTemplate.insert("saveMemberPlan", memberPlanDTO);
    }

    @Override
    public List<MemberPlanDTO> getCompanionsByPlanId(Long planId) {
        return sqlSessionTemplate.selectList("com.shinhan.plan.getCompanionsByPlanId", planId);
    }


    @Override
    public boolean isCompanionExists(Long planId, String memberEmail) {
        Map<String, Object> params = new HashMap<>();
        params.put("planId", planId);
        params.put("memberEmail", memberEmail);
        Integer count = sqlSessionTemplate.selectOne("com.shinhan.plan.countCompanion", params);
        return count != null && count > 0;
    }

    @Override
    public boolean isMemberExists(String email) {
        Integer count = sqlSessionTemplate.selectOne("com.shinhan.plan.checkMemberExists", email);
        return count != null && count > 0;
    }

    @Override
    public void deleteCompanion(MemberPlanDTO memberPlanDTO) {
        sqlSessionTemplate.delete("com.shinhan.plan.deleteCompanion", memberPlanDTO);
    }

    @Override
    public List<PlanDetailsDTO> getPlanDetails(String memberEmail) {
        log.info("플랜 상세 정보 조회 시작 - 이메일: {}", memberEmail);
        List<PlanDetailsDTO> planDetails = sqlSessionTemplate.selectList("com.shinhan.plan.getPlanDetails", memberEmail);

        if (planDetails == null || planDetails.isEmpty()) {
            log.info("조회된 플랜 상세 정보가 없습니다.");
        } else {
            log.info("조회된 플랜 상세 정보 개수: {}", planDetails.size());
        }

        return planDetails;
    }

    @Override
    public List<PlanRelationshipsDTO> getFollowingList(String memberEmail) {
        return sqlSessionTemplate.selectList("com.shinhan.plan.getFollowingList", memberEmail);
    }

    @Override
    public List<PlanRelationshipsDTO> getFollowerList(String memberEmail) {
        return sqlSessionTemplate.selectList("com.shinhan.plan.getFollowerList", memberEmail);
    }

    @Override
    public PlanDTO findPlanById(Long planId) {
        return sqlSessionTemplate.selectOne("com.shinhan.plan.findPlanById", planId);
    }

    @Override
    public List<PlanDetailsDTO> findPlanPlacesByPlanId(Long planId) {
        return sqlSessionTemplate.selectList("com.shinhan.plan.findPlanPlacesByPlanId", planId);
    }
}
