package com.shinhan.daengdong.plan.model.service;

import com.shinhan.daengdong.plan.dto.PlanDTO;
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
    private PlanRepositoryInterface planRepository;

    @Override
    public PlanDTO savePlan(PlanDTO planDTO) {
        log.info("새 플랜 저장 : " + planDTO);
        // 데이터 저장 후 저장된 객체 반환 (여기서는 예시로 입력 데이터를 반환)
        return planDTO;
    }

    @Override
    public List<PlanDTO> getPublicPlan() {
        return planRepository.getPlansByState();
    }

    @Override
    public void planName(PlanDTO planDTO) {
        planRepository.planName(planDTO);
    }

}
