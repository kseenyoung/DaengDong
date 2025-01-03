package com.shinhan.daengdong.member.model.repository;

import com.shinhan.daengdong.member.dto.*;
import com.shinhan.daengdong.post.dto.PostDTO;
import com.shinhan.daengdong.review.dto.ReviewDTO;
import com.shinhan.daengdong.pet.dto.PetDTO;
import java.util.List;

public interface MemberRepositoryInterface {

    MemberDTO login(String email);

    MemberDTO insertMember(MemberDTO memberDTO);

    PetDTO insertPet(List<PetDTO> petDTO, String memberEmail);

    MemberDTO selectMember(String memberEmail);

    void modifyNickname(MemberDTO memberDTO);

    void updateprofilePhoto(MemberDTO memberDTO);

    List<ReviewDTO> getReviewList(String memberEmail);

    List<FavoritePlaceDTO> getFavoritePlaceList(String memberEmail);

    List<LikePostsDTO> getLikePosts(String memberEmail);

    void deleteFavoritePlace(int starId);

    void deleteReview(int reviewId);

    void modifyReview(ReviewDTO reviewDTO);

    void deleteLikePosts(int postId);

    List<RelationshipsDTO> getFollowingList(String memberEmail);

    List<RelationshipsDTO> getFollowerList(String memberEmail);

    void deleteFollowing(FollowDTO followDTO);

    void addFollowing(FollowDTO followDTO);

    List<PostDTO> getMyPosts(String memberEmail);
}
