package com.shinhan.daengdong.post.model.repository;

import com.shinhan.daengdong.post.vo.PostVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Slf4j
@Repository
public class PostRepositoryImpl implements PostRepositoryInterface {

    @Autowired
    private SqlSession sqlSession;

    private final String namespace = "com.shinhan.post.";

    @Override
    public List<PostVO> getTopPosts() {
        List<PostVO> result = sqlSession.selectList(namespace + "viewPost");
        log.info(result.toString());
        return result;
    }
}
