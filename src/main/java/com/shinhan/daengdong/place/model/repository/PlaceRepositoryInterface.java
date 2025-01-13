package com.shinhan.daengdong.place.model.repository;

import com.shinhan.daengdong.place.dto.PlaceDTO;
import com.shinhan.daengdong.place.dto.PlanPlaceDTO;

public interface PlaceRepositoryInterface {
    void savePlace(PlaceDTO placeDTO);
    void savePlanPlace(PlanPlaceDTO planPlaceDTO);
}
