package com.shinhan.daengdong.place.model.service;

import com.shinhan.daengdong.place.dto.PlaceDTO;
import com.shinhan.daengdong.place.model.repository.PlaceRepositoryImpl;
import com.shinhan.daengdong.place.model.repository.PlaceRepositoryInterface;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;

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

    @Override
    public void savePlace(PlaceDTO placeDTO) {
        placeRepository.savePlace(placeDTO);
    }
}
