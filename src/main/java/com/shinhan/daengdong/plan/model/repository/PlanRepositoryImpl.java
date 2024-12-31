package com.shinhan.daengdong.plan.model.repository;

import com.shinhan.daengdong.plan.dto.PlanDTO;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Slf4j
@Repository
public class PlanRepositoryImpl implements PlanRepositoryInterface {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;  // MyBatis 세션 사용

    @Override
    public void save(PlanDTO planDTO) {
        log.info("result 값:!!!!!!!!!!!!!!!! ");
        int result = sqlSessionTemplate.insert("com.shinhan.plan.save", planDTO); // XML 매핑된 쿼리 호출
        log.info("result 값: {}", result);
    }

    @Override
    public List<PlanDTO> getPlansByState() {
        return sqlSessionTemplate.selectList("com.shinhan.plan.planList");
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
}
