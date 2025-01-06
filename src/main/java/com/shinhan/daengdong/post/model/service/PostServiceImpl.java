package com.shinhan.daengdong.post.model.service;

import com.shinhan.daengdong.post.model.repository.PostRepositoryInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PostServiceImpl implements PostServiceInterface {

    @Autowired
    PostRepositoryInterface postRepository;

    @Override
    public void deletePost(int postId) {
        postRepository.deletePost(postId);
    }
}
