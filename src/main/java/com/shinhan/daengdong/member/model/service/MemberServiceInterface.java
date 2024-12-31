package com.shinhan.daengdong.member.model.service;

import com.shinhan.daengdong.member.dto.*;
import com.shinhan.daengdong.review.dto.ReviewDTO;

import java.util.List;

public interface MemberServiceInterface {

    MemberDTO login(String email);

    MemberDTO signUp(SignUpDTO signUpDTO);

    List<FavoritePlaceDTO> getFavoritePlaceList(String memberEmail);

    List<ReviewDTO> getReviewList(String memberEmail);

    List<LikePostsDTO> getLikePosts(String memberEmail);

    void deleteFavoritePlace(int starId);

    void deleteReview(int reviewId);

    void modifyReview(ReviewDTO reviewDTO);

    void deleteLikePosts(int postId);

    List<RelationshipsDTO> getFollowingList(String memberEmail);

    List<RelationshipsDTO> getFollowerList(String memberEmail);

    void deleteFollowing(FollowDTO followDTO);
}
