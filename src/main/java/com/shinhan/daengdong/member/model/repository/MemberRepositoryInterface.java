package com.shinhan.daengdong.member.model.repository;

import com.shinhan.daengdong.member.dto.FavoritePlaceDTO;
import com.shinhan.daengdong.member.dto.LikePostsDTO;
import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.review.dto.ReviewDTO;
import com.shinhan.daengdong.pet.dto.PetDTO;
import java.util.List;

public interface MemberRepositoryInterface {

    MemberDTO login(String email);

    MemberDTO insertMember(MemberDTO memberDTO);

    PetDTO insertPet(List<PetDTO> petDTO, String memberEmail);

    List<ReviewDTO> getReviewList(String memberEmail);

    List<FavoritePlaceDTO> getFavoritePlaceList(String memberEmail);

    List<LikePostsDTO> getLikePosts(String memberEmail);

    void deleteFavoritePlace(int starId);

    void deleteReview(int reviewId);

    void modifyReview(ReviewDTO reviewDTO);

    void deleteLikePosts(int postId);
}
