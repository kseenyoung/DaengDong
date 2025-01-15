package com.shinhan.daengdong.place.model.repository;

import com.shinhan.daengdong.place.dto.FavoriteDTO;
import com.shinhan.daengdong.place.dto.PlaceDTO;
import com.shinhan.daengdong.place.dto.PlanPlaceDTO;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

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

    @Override
    public void addFavorite(FavoriteDTO favoriteDTO) {
        sqlSessionTemplate.insert("com.shinhan.place.insertFavorite", favoriteDTO);
    }

    @Override
    public boolean existsByMemberAndPlace(String memberEmail, Long kakaoPlaceId) {
        Integer count = sqlSessionTemplate.selectOne("com.shinhan.place.findByMemberAndPlaceCount",
            Map.of("memberEmail", memberEmail, "kakaoPlaceId", kakaoPlaceId));
        return count != null && count > 0;
    }

    @Override
    public void deleteByMemberAndPlace(String memberEmail, Long kakaoPlaceId) {
        sqlSessionTemplate.delete("com.shinhan.place.deleteByMemberAndPlace",
            Map.of("memberEmail", memberEmail, "kakaoPlaceId", kakaoPlaceId));
    }

    @Override
    public List<FavoriteDTO> findAllFavorites(String memberEmail) {
        return sqlSessionTemplate.selectList("com.shinhan.place.findAllByMemberEmail", memberEmail);
    }

}
