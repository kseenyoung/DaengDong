package com.shinhan.daengdong.place.controller;

import com.shinhan.daengdong.place.dto.FavoriteDTO;
import com.shinhan.daengdong.place.dto.PlaceDTO;
import com.shinhan.daengdong.place.dto.PlanPlaceDTO;
import com.shinhan.daengdong.place.model.service.PlaceServiceInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/place")
@CrossOrigin(origins = "*")
public class PlaceController {

    @Autowired
    private PlaceServiceInterface placeService;

    @PostMapping("/savePlace")
    @ResponseBody
    public ResponseEntity<String> savePlace(@RequestBody PlaceDTO placeDTO, HttpSession session) {
        // 1) 먼저 DB에 placeDTO.getKakaoPlaceId() 가 존재하는지 조회
        // boolean exists = placeRepository.existsByKakaoPlaceId(placeDTO.getKakaoPlaceId());
        // if(exists) {
        //     // 이미 존재하면 업데이트 or 그냥 무시
        //     // placeRepository.updatePlace(...) or do nothing
        //     return;
        // }
            Long planId = (Long) session.getAttribute("currentPlanId");
            log.info("savePlace에서 planId={}", planId);
        try {

            // 장소 저장
            log.info("받은 place JSON 데이터: {}", placeDTO);
            placeService.savePlace(placeDTO);
            return ResponseEntity.ok("Place saved successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Failed to save place: " + e.getMessage());
        }
    }

    @PostMapping("/finalPlanPlaces")
    @ResponseBody
    public ResponseEntity<String> submitPlanPlaces(@RequestBody List<PlanPlaceDTO> planPlaceDTO, HttpSession session) {
        Long planId = (Long) session.getAttribute("currentPlanId");
        log.info("PlanPlaces에서 planId={}", planId);
        try {
            log.info("받은 PlanPlace 데이터: {}", planPlaceDTO);

            for (PlanPlaceDTO dto : planPlaceDTO) {
                placeService.savePlanPlace(dto);
            }

            return ResponseEntity.ok("Plan places saved successfully");
        } catch (Exception e) {
            log.error("Failed to save plan places", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Failed to save plan places: " + e.getMessage());
        }
    }

    @PostMapping("/addFavorite")
    public ResponseEntity<String> addFavorite(@RequestBody FavoriteDTO favoriteDTO, HttpSession session) {
        String memberEmail = (String) session.getAttribute("currentMemberEmail");
        if (memberEmail == null) {
            log.error("세션에 memberEmail이 없습니다!");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        favoriteDTO.setMemberEmail(memberEmail);

        try {
            // 중복 여부 확인
            boolean isFavoriteExist = placeService.isFavoriteExist(favoriteDTO);
            if (isFavoriteExist) {
                // 중복 존재 -> 삭제
                placeService.deleteFavoriteByMemberAndPlace(favoriteDTO);
                return ResponseEntity.ok("즐겨찾기에서 제거되었습니다.");
            } else {
                // 중복 없음 -> 추가
                placeService.addFavorite(favoriteDTO);
                log.info("생성된 starId: {}", favoriteDTO.getStarId());
                return ResponseEntity.ok("즐겨찾기에 추가되었습니다.");
            }
        } catch (Exception e) {
            log.error("즐겨찾기 처리 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("즐겨찾기 처리 실패");
        }
    }

    @GetMapping("/favorites")
    public ResponseEntity<List<FavoriteDTO>> getFavorites(HttpSession session) {
        String memberEmail = (String) session.getAttribute("memberEmail");
        List<FavoriteDTO> favorites = placeService.findAllFavorites(memberEmail);
        return ResponseEntity.ok(favorites);
    }
}
