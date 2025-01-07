package com.shinhan.daengdong.post.model.repository;

import com.shinhan.daengdong.post.dto.PostDTO;
import com.shinhan.daengdong.post.dto.PostIMGDTO;
import com.shinhan.daengdong.post.vo.LikeVO;
import com.shinhan.daengdong.post.vo.PostVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public List<LikeVO> getMyLike(String memberEmail) {
        List<LikeVO> result = sqlSession.selectList(namespace + "getMyLikes", memberEmail);
        log.info(result.toString());
        return result;
    }

    public List<PostVO> findByCategoryOrderByDateDesc(String category){
        List<PostVO> result = sqlSession.selectList(namespace + "getPostsByCategory", category);
        log.info(result.toString());
        return result;
    }    @Override
    public void deletePost(int postId) {
        sqlSession.delete(namespace + "deletePost", postId);
    }

    @Override
    public void createPost(PostDTO postDTO, List<String> imageUrls) {
        sqlSession.insert(namespace + "createPost", postDTO);

        if (imageUrls != null && !imageUrls.isEmpty()) {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("postId", postDTO.getPostId());
            paramMap.put("imageUrls", imageUrls); // imageUrls를 리스트로 전달

            sqlSession.insert(namespace + "createPostImages", paramMap); // 한 번에 삽입
        }

    }

    @Override
    public void addLike(Long postId, String memberEmail) {
        Map<String, Object> params = new HashMap<>();
        params.put("postId", postId);
        params.put("memberEmail", memberEmail);
        sqlSession.insert("com.shinhan.post.addLike", params);
    }

    @Override
    public void deleteLike(Long postId, String memberEmail) {
        Map<String, Object> params = new HashMap<>();
        params.put("postId", postId);
        params.put("memberEmail", memberEmail);
        sqlSession.delete(namespace + "deleteLike", params);
    }

    @Override
    public int checkLike(Long postId, String memberEmail) {
        Map<String, Object> params = new HashMap<>();
        params.put("postId", postId);
        params.put("memberEmail", memberEmail);
        return sqlSession.selectOne(namespace + "checkLike", params);
    }
}
