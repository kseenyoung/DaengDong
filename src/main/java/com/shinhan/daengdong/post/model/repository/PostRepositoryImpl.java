package com.shinhan.daengdong.post.model.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PostRepositoryImpl implements PostRepositoryInterface {

    @Autowired
    SqlSession sqlSession;
    String namespace = "com.shinhan.post.";

    @Override
    public void deletePost(int postId) {
        sqlSession.delete(namespace + "deletePost", postId);
    }
}
