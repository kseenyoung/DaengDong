package com.shinhan.daengdong.member.model.service;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.review.dto.ReviewDTO;
import com.shinhan.daengdong.member.dto.SignUpDTO;
import com.shinhan.daengdong.member.model.repository.MemberRepositoryInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberServiceInterface{

    @Autowired
    MemberRepositoryInterface memberRepository;

    @Override
    public MemberDTO login(String email){
        return memberRepository.login(email);
    }

    @Override
    @Transactional
    public MemberDTO signUp(SignUpDTO signUpDTO) {
        // member 등록
        MemberDTO member = MemberDTO.builder()
                .memberEmail(signUpDTO.getMemberEmail())
                .memberProfilePhoto(signUpDTO.getMemberProfilePhoto())
                .memberNickname(signUpDTO.getMemberNickname())
                .memberName(signUpDTO.getMemberName())
                .build();

        memberRepository.insertMember(member);

        // pet 등록
        memberRepository.insertPet(signUpDTO.getPets(), signUpDTO.getMemberEmail());

        return member;
    }

    @Override
    public List<ReviewDTO> viewReviewList(String memberEmail) {
        return memberRepository.viewReviewList(memberEmail);
    }
}
