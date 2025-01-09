
package com.shinhan.daengdong.post.model.service;

import com.shinhan.daengdong.post.dto.CommentDTO;
import com.shinhan.daengdong.post.dto.CommentVO;
import com.shinhan.daengdong.post.dto.PostDTO;
import com.shinhan.daengdong.post.vo.LikeVO;
import com.shinhan.daengdong.post.vo.PostVO;

import java.util.List;


public interface PostServiceInterface {
    List<PostVO> getTopPosts();  // 메인 페이지를 위한 상위 게시글 조회
    List<PostVO> getPostsByCategory(String category);
    PostVO getPostDetail(Long postId);
    List<LikeVO> getMyLike(String memberEmail);  // 메인 페이지를 위한 상위 게시글 조회
    void deletePost(int postId);
    void createPost(PostDTO postDTO, List<String> imageUrls);
    void addLike(Long postId, String memberEmail);
    CommentDTO addComment(CommentDTO commentDTO);
    List<CommentVO> getCommentList(Long postId);
}