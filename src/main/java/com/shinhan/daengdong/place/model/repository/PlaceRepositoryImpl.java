package com.shinhan.daengdong.place.model.repository;

import com.shinhan.daengdong.place.dto.PlaceDTO;
import com.shinhan.daengdong.place.dto.PlanPlaceDTO;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Slf4j
@Repository
public class PlaceRepositoryImpl implements PlaceRepositoryInterface {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public void savePlace(PlaceDTO placeDTO) {
        sqlSessionTemplate.insert("com.shinhan.place.savePlace", placeDTO);
    }

    @Override
    public void savePlanPlace(PlanPlaceDTO planPlaceDTO) {
        sqlSessionTemplate.insert("com.shinhan.place.savePlanPlace", planPlaceDTO);
    }

}
