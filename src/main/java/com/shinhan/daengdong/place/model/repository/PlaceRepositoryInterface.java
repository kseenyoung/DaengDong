package com.shinhan.daengdong.place.model.repository;

import com.shinhan.daengdong.place.dto.FavoriteDTO;
import com.shinhan.daengdong.place.dto.PlaceDTO;
import com.shinhan.daengdong.place.dto.PlanPlaceDTO;

import java.util.List;
import java.util.Map;

public interface PlaceRepositoryInterface {
    void savePlace(PlaceDTO placeDTO);
    void savePlanPlace(PlanPlaceDTO planPlaceDTO);
    void addFavorite(FavoriteDTO favoriteDTO);
    boolean existsByMemberAndPlace(String memberEmail, Long kakaoPlaceId);
    void deleteByMemberAndPlace(String memberEmail, Long kakaoPlaceId);
    List<FavoriteDTO> findAllFavorites(String memberEmail);
}
