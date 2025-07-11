package com.shinhan.daengdong.place.model.service;

import com.shinhan.daengdong.place.dto.FavoriteDTO;
import com.shinhan.daengdong.place.dto.PlaceDTO;
import com.shinhan.daengdong.place.dto.PlanPlaceDTO;

import java.util.List;

public interface PlaceServiceInterface {
    String fetchPlaceImage(int kakaoPlaceUrl);
    void savePlace(PlaceDTO placeDTO);
    void savePlanPlace(PlanPlaceDTO planPlaceDTO);
    void addFavorite(FavoriteDTO favoriteDTO);
    boolean isFavoriteExist(FavoriteDTO favoriteDTO);
    void deleteFavoriteByMemberAndPlace(FavoriteDTO favoriteDTO);
    List<FavoriteDTO> findAllFavorites(String memberEmail);
}
