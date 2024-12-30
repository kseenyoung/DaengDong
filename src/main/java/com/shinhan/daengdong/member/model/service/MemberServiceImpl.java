package com.shinhan.daengdong.member.model.service;

import com.shinhan.daengdong.member.dto.FavoritePlaceDTO;
import com.shinhan.daengdong.member.dto.LikePostsDTO;
import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.place.model.service.PlaceServiceInterface;
import com.shinhan.daengdong.review.dto.ReviewDTO;
import com.shinhan.daengdong.member.dto.SignUpDTO;
import com.shinhan.daengdong.member.model.repository.MemberRepositoryInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
public class MemberServiceImpl implements MemberServiceInterface{

    @Autowired
    MemberRepositoryInterface memberRepository;

    @Autowired
    PlaceServiceInterface placeService;

    @Autowired
    private ConversionService conversionService;

    @Override
    public MemberDTO login(String email){
        return memberRepository.login(email);
    }

    @Override
    @Transactional
    public MemberDTO signUp(SignUpDTO signUpDTO) {
        // member 등록
        MemberDTO member = MemberDTO.builder()
                .memberEmail(signUpDTO.getMemberEmail())
                .memberProfilePhoto(signUpDTO.getMemberProfilePhoto())
                .memberNickname(signUpDTO.getMemberNickname())
                .memberName(signUpDTO.getMemberName())
                .build();

        memberRepository.insertMember(member);

        // pet 등록
        memberRepository.insertPet(signUpDTO.getPets(), signUpDTO.getMemberEmail());

        return member;
    }

    @Override
    public List<ReviewDTO> getReviewList(String memberEmail) {
        List<ReviewDTO> reviewList = memberRepository.getReviewList(memberEmail);
        for (ReviewDTO review : reviewList) {
            String imageUrl = placeService.fetchPlaceImage(review.getKakao_place_id());
            review.setImageUrl(imageUrl);
        }
        return reviewList;
    }

    @Override
    public List<FavoritePlaceDTO> getFavoritePlaceList(String memberEmail) {
        List<FavoritePlaceDTO> favoritePlaceList = memberRepository.getFavoritePlaceList(memberEmail);
        for (FavoritePlaceDTO place : favoritePlaceList) {
            String imageUrl = placeService.fetchPlaceImage(place.getKakao_place_id());
            place.setImageUrl(imageUrl);
        }
        log.info("favoritePlaceList: " + favoritePlaceList);
        return favoritePlaceList;
    }

    @Override
    public List<LikePostsDTO> getLikePosts(String memberEmail) {
        return memberRepository.getLikePosts(memberEmail);
    }

    @Override
    public void deleteFavoritePlace(int starId) {
        memberRepository.deleteFavoritePlace(starId);
    }

    @Override
    public void deleteReview(int reviewId) {
        memberRepository.deleteReview(reviewId);
    }

    @Override
    public void modifyReview(ReviewDTO reviewDTO) {
        memberRepository.modifyReview(reviewDTO);
    }

    @Override
    public void deleteLikePosts(int postId) {
        memberRepository.deleteLikePosts(postId);
    }
}
