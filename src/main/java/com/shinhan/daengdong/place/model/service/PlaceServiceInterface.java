package com.shinhan.daengdong.place.model.service;

import com.shinhan.daengdong.place.dto.PlaceDTO;
import com.shinhan.daengdong.place.dto.PlanPlaceDTO;

public interface PlaceServiceInterface {
    String fetchPlaceImage(int kakaoPlaceUrl);
    void savePlace(PlaceDTO placeDTO);
    void savePlanPlace(PlanPlaceDTO planPlaceDTO);

}
