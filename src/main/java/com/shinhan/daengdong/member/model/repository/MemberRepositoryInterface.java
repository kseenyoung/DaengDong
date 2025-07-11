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

    void addFavoritePlace(FavoritePlaceDTO favoritePlaceDTO);
    
    void deleteFavoritePlace(int starId);

    void deleteReview(int reviewId);

    void modifyReview(ReviewDTO reviewDTO);

    void deleteLikePosts(int postId);

    List<RelationshipsDTO> getFollowingList(String memberEmail);

    List<RelationshipsDTO> getFollowerList(String memberEmail);

    void deleteFollowing(FollowDTO followDTO);

    void addFollowing(FollowDTO followDTO);

    List<PostDTO> getMyPosts(String memberEmail);

    void deletePlan(long planId);

    List<PetDTO> selectPet(String memberEmail);

    void modifyProfilePhoto(MemberDTO member);

    void modifyPetProfilePhoto(PetDTO petDTO);

    void modifyPetDetail(PetDTO petDTO);


    //알림 관련
    List<NotificationDTO> selectNotification(String receiver_email);

    NotificationDTO selectNotificationById(int notificationId);

    void insertNotification(NotificationDTO notificationDTO);

    void isChecked(int notificationId);

    void deleteNotification(int notificationId);
    int createPetProfile(PetDTO petDTO);

    PetDTO selectOnetMyPet(PetDTO petDTO);

    void deletePetByPetId(int petId);
}
