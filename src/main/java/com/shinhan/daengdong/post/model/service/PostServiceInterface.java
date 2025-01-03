
package com.shinhan.daengdong.post.model.service;

import com.shinhan.daengdong.post.vo.LikeVO;
import com.shinhan.daengdong.post.vo.PostVO;

import java.util.List;


public interface PostServiceInterface {
    List<PostVO> getTopPosts();  // 메인 페이지를 위한 상위 게시글 조회
    List<LikeVO> getMyLike();  // 메인 페이지를 위한 상위 게시글 조회
}