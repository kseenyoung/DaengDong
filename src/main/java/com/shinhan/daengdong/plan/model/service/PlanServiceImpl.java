package com.shinhan.daengdong.plan.model.service;

import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.model.repository.PlanRepositoryInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class PlanServiceImpl implements PlanServiceInterface {

    @Autowired
    private PlanRepositoryInterface planRepository;

    @Override
    public List<String> getAllRegions() {
        return planRepository.findAllRegions();
    }

    @Override
    public PlanDTO savePlan(PlanDTO planDTO) {
        log.info("Saving new plan : " + planDTO);
        // 데이터 저장 후 저장된 객체 반환 (여기서는 예시로 입력 데이터를 반환)
        return planDTO;
    }
}
