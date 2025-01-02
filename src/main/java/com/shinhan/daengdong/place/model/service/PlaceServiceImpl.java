package com.shinhan.daengdong.place.model.service;

import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Slf4j
@Service
public class PlaceServiceImpl implements PlaceServiceInterface {
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
}
