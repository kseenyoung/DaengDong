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

    private List<PlanDTO> tempPlans = new ArrayList<>();

    // @Override
    // public PlanDTO savePlan(PlanDTO planDTO) {
    //     log.info("Saving new plan : " + planDTO);
    //     // 데이터 저장 후 저장된 객체 반환 (여기서는 예시로 입력 데이터를 반환)
    //     return planDTO;
    // }

    @Override
    public void saveTempPlan(PlanDTO planDTO) {
        log.info("임시로 플랜 저장 : " + planDTO);
        // 임시로 데이터를 메모리에 저장
        tempPlans.add(planDTO);
    }

    @Override
    @Transactional
    public void commitPlans() {
        log.info(("모든 플랜을 DB에 저장/커밋 시작"));
        for (PlanDTO plan : tempPlans) {
            planRepository.save(plan);  // DB에 저장
        }
        tempPlans.clear(); // 임시 저장소 초기화
        log.info("모든 플랜 저장 성공 및 commit 완료");
    }

    @Override
    public List<PlanDTO> getTempPlans() {
        return new ArrayList<>(tempPlans); // 임시 데이터 반환
    }
}
