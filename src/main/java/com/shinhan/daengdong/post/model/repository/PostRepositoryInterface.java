package com.shinhan.daengdong.post.model.repository;

import com.shinhan.daengdong.post.dto.PostDTO;
import com.shinhan.daengdong.post.vo.LikeVO;
import com.shinhan.daengdong.post.vo.PostVO;

import java.util.List;

public interface PostRepositoryInterface {

    List<PostVO> getTopPosts();  // 상위 게시글 조회

    List<LikeVO> getMyLike(String memberEmail);
    List<PostVO> findByCategoryOrderByDateDesc(String category);
    void deletePost(int postId);

    void createPost(PostDTO postDTO, List<String> imageUrls);
    void addLike(Long postId, String memberEmail);
    void deleteLike(Long postId, String memberEmail);
    int checkLike(Long postId, String memberEmail);
}
