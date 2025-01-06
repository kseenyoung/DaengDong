package com.shinhan.daengdong.post.model.service;

import com.shinhan.daengdong.post.vo.LikeVO;
import com.shinhan.daengdong.post.vo.PostVO;
import com.shinhan.daengdong.post.model.repository.PostRepositoryInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostServiceImpl implements PostServiceInterface {

    @Autowired
    private PostRepositoryInterface postRepository;

    @Override
    public List<PostVO> getTopPosts() {
        return postRepository.getTopPosts();
    }
    @Override
    public List<LikeVO> getMyLike(){
        return postRepository.getMyLike();
    }

    @Override
    public void deletePost(int postId) {
        postRepository.deletePost(postId);
    }
}




