package com.shinhan.daengdong.member.model.repository;

import com.shinhan.daengdong.member.dto.*;
import com.shinhan.daengdong.post.dto.PostDTO;
import com.shinhan.daengdong.review.dto.ReviewDTO;
import com.shinhan.daengdong.pet.dto.PetDTO;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Slf4j
@Repository
public class MemberRepositoryImpl implements MemberRepositoryInterface{

    @Autowired
    SqlSession sqlSession;
    String namespace = "com.shinhan.member.";

    @Override
    public MemberDTO login(String email){
        MemberDTO result = sqlSession.selectOne(namespace+"login", email);
        return result;
    }

    @Override
    public MemberDTO insertMember(MemberDTO memberDTO) {
        int signUpMember = sqlSession.insert(namespace+"signUp", memberDTO);
        return signUpMember == 1 ? memberDTO : null;
    }

    @Override
    public PetDTO insertPet(List<PetDTO> pets, String memberEmail) {
        for(PetDTO pet: pets){
            pet.setMember_email(memberEmail);
            int result = sqlSession.insert(namespace+"insertPet", pet);
        }
        return null;
    }

    @Override
    public MemberDTO selectMember(String memberEmail){
        MemberDTO selectMember = sqlSession.selectOne(namespace+ "selectMember", memberEmail);
        return selectMember;
    }

    @Override
    public void modifyNickname(MemberDTO memberDTO) {
        //log.info("modifyNickname!!!!!!!!!!!!!!!!! : " + memberDTO);
        sqlSession.update(namespace + "modifyNickname", memberDTO);
    }

    public void updateprofilePhoto(MemberDTO memberDTO) {
        sqlSession.update(namespace + "updateprofilePhoto", memberDTO);
    }

    @Override
    public List<ReviewDTO> getReviewList(String memberEmail) {
        List<ReviewDTO> reviewList = sqlSession.selectList(namespace + "viewReviewList", memberEmail);
        return reviewList;
    }

    @Override
    public List<FavoritePlaceDTO> getFavoritePlaceList(String memberEmail) {
        List<FavoritePlaceDTO> favoritePlaceList = sqlSession.selectList(namespace + "favoritePlaceList", memberEmail);
        return favoritePlaceList;
    }

    @Override
    public List<LikePostsDTO> getLikePosts(String memberEmail) {
        List<LikePostsDTO> likePostsList = sqlSession.selectList(namespace + "getLikePostList", memberEmail);
        return likePostsList;
    }

    @Override
    public void deleteFavoritePlace(int starId) {
        sqlSession.delete(namespace + "deleteFavoritePlace", starId);
    }

    @Override
    public void deleteReview(int reviewId) {
        sqlSession.delete(namespace + "deleteReview", reviewId);
    }

    @Override
    public void modifyReview(ReviewDTO reviewDTO) {sqlSession.update(namespace + "modifyReview", reviewDTO);}

    @Override
    public void deleteLikePosts(int postId) {
        sqlSession.delete(namespace + "deleteLike", postId);
    }

    @Override
    public List<RelationshipsDTO> getFollowingList(String memberEmail) {
        List<RelationshipsDTO> followingList = sqlSession.selectList(namespace + "selectFollowing", memberEmail);
        return followingList;
    }

    @Override
    public List<RelationshipsDTO> getFollowerList(String memberEmail) {
        List<RelationshipsDTO> followerList = sqlSession.selectList(namespace + "selectFollower", memberEmail);
        return followerList;
    }

    @Override
    public void deleteFollowing(FollowDTO followDTO) {
        sqlSession.delete(namespace + "deleteRelationships", followDTO);
    }

    @Override
    public void addFollowing(FollowDTO followDTO) {
        sqlSession.insert(namespace + "addRelationships", followDTO);
    }

    @Override
    public List<PostDTO> getMyPosts(String memberEmail) {
        List<PostDTO> myPostList = sqlSession.selectList(namespace + "selectMyPosts", memberEmail);
        return myPostList;
    }

    @Override
    public void deletePlan(long planId) {
        sqlSession.delete(namespace + "deletePlan", planId);
    }

    @Override
    public List<PetDTO> selectPet(String memberEmail) {
        List<PetDTO> petList = sqlSession.selectList(namespace + "selectMyPet", memberEmail);
        log.info("memberEmail: " + memberEmail);
        log.info("petList123: " + petList);
        return petList;
    }
}
