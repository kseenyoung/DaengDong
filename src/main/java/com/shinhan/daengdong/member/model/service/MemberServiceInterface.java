package com.shinhan.daengdong.member.model.service;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.review.dto.ReviewDTO;
import com.shinhan.daengdong.member.dto.SignUpDTO;

import java.util.List;

public interface MemberServiceInterface {

    MemberDTO login(String email);

    MemberDTO signUp(SignUpDTO signUpDTO);

    List<ReviewDTO> viewReviewList(String memberEmail);
}
