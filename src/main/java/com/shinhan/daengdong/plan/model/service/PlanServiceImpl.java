package com.shinhan.daengdong.plan.model.service;

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
    public void savePlan(PlanDTO planDTO) {
        log.info("플랜 저장 요청!!!!!!!!!!!!!: {}", planDTO);
        planRepository.save(planDTO); // DB에 저장
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
}
