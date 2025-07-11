package com.shinhan.daengdong.place.model.service;

import com.shinhan.daengdong.place.dto.FavoriteDTO;
import com.shinhan.daengdong.place.dto.PlaceDTO;
import com.shinhan.daengdong.place.dto.PlanPlaceDTO;
import com.shinhan.daengdong.place.model.repository.PlaceRepositoryImpl;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Slf4j
@Service
public class PlaceServiceImpl implements PlaceServiceInterface {

    @Autowired
    private PlaceRepositoryImpl placeRepository;

    @Override
    public String fetchPlaceImage(int placeId) {
        String url ="https://place.map.kakao.com/placePrint.daum?confirmid=" + placeId;
        try {
            Document doc = Jsoup.connect(url).get();
            String imagePath = doc.getElementsByClass("thumb_g").get(0).attr("src");
            return "https:" + imagePath;
        } catch (IOException e) {
            return "/img/defaultImage.jpg";
        }
    }

    // 장소 저장
    @Override
    public void savePlace(PlaceDTO placeDTO) {
        placeRepository.savePlace(placeDTO);
    }

    // 최종 장소 저장
    @Override
    public void savePlanPlace(PlanPlaceDTO planPlaceDTO) {
        placeRepository.savePlanPlace(planPlaceDTO);
    }

    @Override
    public void addFavorite(FavoriteDTO favoriteDTO) {
        placeRepository.addFavorite(favoriteDTO);
    }

    @Override
    public boolean isFavoriteExist(FavoriteDTO favoriteDTO) {
        return placeRepository.existsByMemberAndPlace(favoriteDTO.getMemberEmail(), favoriteDTO.getKakaoPlaceId());
    }

    @Override
    public void deleteFavoriteByMemberAndPlace(FavoriteDTO favoriteDTO) {
        placeRepository.deleteByMemberAndPlace(favoriteDTO.getMemberEmail(), favoriteDTO.getKakaoPlaceId());
    }

    @Override
    public List<FavoriteDTO> findAllFavorites(String memberEmail) {
        return placeRepository.findAllFavorites(memberEmail);
    }

}
