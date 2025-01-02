package com.shinhan.daengdong.post.model.repository;

import com.shinhan.daengdong.post.vo.PostVO;

import java.util.List;

public interface PostRepositoryInterface {

    List<PostVO> getTopPosts();  // 상위 게시글 조회
}
