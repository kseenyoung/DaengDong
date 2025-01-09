package com.shinhan.daengdong.place.model.service;

import com.shinhan.daengdong.place.dto.PlaceDTO;

public interface PlaceServiceInterface {
    String fetchPlaceImage(int kakaoPlaceUrl);
    void savePlace(PlaceDTO placeDTO);
}
