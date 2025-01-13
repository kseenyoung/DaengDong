package com.shinhan.daengdong.post.model.service;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.member.model.repository.MemberRepositoryInterface;
import com.shinhan.daengdong.post.dto.CommentDTO;
import com.shinhan.daengdong.post.dto.CommentVO;
import com.shinhan.daengdong.post.dto.PostDTO;
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

    @Autowired
    private MemberRepositoryInterface memberRepository;

    @Override
    public List<PostVO> getTopPosts() {
        return postRepository.getTopPosts();
    }

    public List<PostVO> getPostsByCategory(String category) {
        // 카테고리에 맞는 게시물 최신 순으로 조회
        return postRepository.findByCategoryOrderByDateDesc(category);
    }


    @Override
    public List<LikeVO> getMyLike(String memberEmail){
        return postRepository.getMyLike(memberEmail);
    }
    @Override
    public void createPost(PostDTO postDTO, List<String> imageUrls){
         postRepository.createPost(postDTO, imageUrls);
    }

    @Override
    public void deletePost(int postId) {
        postRepository.deletePost(postId);
    }



    public void addLike(Long postId, String memberEmail) {
        int likeCount = postRepository.checkLike(postId, memberEmail);
        System.out.println("likeCount : " + likeCount);
        if (likeCount > 0) {
            // 좋아요가 있으면 삭제
            postRepository.deleteLike(postId, memberEmail);
        } else {
            // 좋아요가 없으면 추가
            postRepository.addLike(postId, memberEmail);
        }
    }


    public PostVO getPostDetail(Long postId) {
        return postRepository.findPostById(postId);
    }

    // 댓글 추가
    public CommentDTO addComment(CommentDTO commentDTO) {
        postRepository.saveComment(commentDTO);


        return commentDTO; // 저장된 댓글 반환
    }

    public List<CommentVO> getCommentList(Long postId) {
        return postRepository.findCommentById(postId);
    }

    // 댓글 추가
}




