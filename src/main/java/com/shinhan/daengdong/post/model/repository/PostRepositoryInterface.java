package com.shinhan.daengdong.post.model.repository;

import com.shinhan.daengdong.post.dto.PostDTO;
import com.shinhan.daengdong.post.vo.LikeVO;
import com.shinhan.daengdong.post.vo.PostVO;

import java.util.List;

public interface PostRepositoryInterface {

    List<PostVO> getTopPosts();  // 상위 게시글 조회

    List<LikeVO> getMyLike();

    void deletePost(int postId);

    void createPost(PostDTO postDTO, List<String> imageUrls);

}
