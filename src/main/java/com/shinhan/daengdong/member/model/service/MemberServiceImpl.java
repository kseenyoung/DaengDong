package com.shinhan.daengdong.member.model.service;

import com.shinhan.daengdong.member.dto.*;
import com.shinhan.daengdong.pet.dto.PetDTO;
import com.shinhan.daengdong.place.model.service.PlaceServiceInterface;
import com.shinhan.daengdong.post.dto.PostDTO;
import com.shinhan.daengdong.review.dto.ReviewDTO;
import com.shinhan.daengdong.member.model.repository.MemberRepositoryInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.Calendar;
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
                .member_email(signUpDTO.getMemberEmail())
                .member_profile_photo(signUpDTO.getMemberProfilePhoto())
                .member_nickname(signUpDTO.getMemberNickname())
                .member_name(signUpDTO.getMemberName())
                .build();

        memberRepository.insertMember(member);

        // pet 등록
        memberRepository.insertPet(signUpDTO.getPets(), signUpDTO.getMemberEmail());

        return member;
    }
    @Override
    public MemberDTO selectMember(String memberEmail) {
        return memberRepository.selectMember(memberEmail);
    }
    @Override
    public void modifyNickname(MemberDTO memberDTO) {memberRepository.modifyNickname(memberDTO);}

    public void updateprofilePhoto(MemberDTO memberDTO) {memberRepository.updateprofilePhoto(memberDTO);}

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

    @Override
    public List<RelationshipsDTO> getFollowingList(String memberEmail) {
        return memberRepository.getFollowingList(memberEmail);
    }

    @Override
    public List<RelationshipsDTO> getFollowerList(String memberEmail) {
        return memberRepository.getFollowerList(memberEmail);
    }

    @Override
    public void deleteFollowing(FollowDTO followDTO) {
        memberRepository.deleteFollowing(followDTO);
    }

    @Override
    public void addFollowing(FollowDTO followDTO) {
        memberRepository.addFollowing(followDTO);
    }

    @Override
    public List<PostDTO> getMyPosts(String memberEmail) {
        return memberRepository.getMyPosts(memberEmail);
    }

    @Override
    public void deletePlan(long planId) {
        memberRepository.deletePlan(planId);
    }

    @Override
    public List<PetDTO> selectPet(String memberEmail) {
        List<PetDTO> petList = memberRepository.selectPet(memberEmail);
        for (PetDTO pet : petList) {
            pet.setPet_age(calculatAge(pet.getPet_birthday()));
        }

        return petList;
    }

    private int calculatAge(Date birthDate) {
        if (birthDate == null) return 0; // 생년월일이 없을 경우 나이 0 반환

        Calendar birthCalendar = Calendar.getInstance();
        birthCalendar.setTime(birthDate);

        Calendar today = Calendar.getInstance();
        int age = today.get(Calendar.YEAR) - birthCalendar.get(Calendar.YEAR);

        if (today.get(Calendar.MONTH) < birthCalendar.get(Calendar.MONTH) ||
                (today.get(Calendar.MONTH) == birthCalendar.get(Calendar.MONTH) &&
                        today.get(Calendar.DAY_OF_MONTH) < birthCalendar.get(Calendar.DAY_OF_MONTH))) {
            age--;
        }
        return age;

    }
}
