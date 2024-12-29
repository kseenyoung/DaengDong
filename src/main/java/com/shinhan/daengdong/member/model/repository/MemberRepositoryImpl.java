package com.shinhan.daengdong.member.model.repository;

import com.shinhan.daengdong.member.dto.FavoritePlaceDTO;
import com.shinhan.daengdong.member.dto.LikePostsDTO;
import com.shinhan.daengdong.member.dto.MemberDTO;
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
        log.info("login : " + result);
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
            pet.setMemberEmail(memberEmail);
            int result = sqlSession.insert(namespace+"insertPet", pet);
        }
        return null;
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
    public void modifyReview(ReviewDTO reviewDTO) {
        sqlSession.update(namespace + "modifyReview", reviewDTO);
    }

    @Override
    public void deleteLikePosts(int postId) {
        sqlSession.delete(namespace + "deleteLike", postId);
    }
}
