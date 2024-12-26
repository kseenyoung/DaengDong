package com.shinhan.daengdong.plan.model.repository;

import com.shinhan.daengdong.plan.dto.PlanDTO;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Slf4j
@Repository
public class PlanRepositoryImpl implements PlanRepositoryInterface {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;  // MyBatis 세션 사용

    @Override
    public void save(PlanDTO planDTO) {
        sqlSessionTemplate.insert("com.shinhan.plan.save", planDTO); // XML 매핑된 쿼리 호출
    }
}
