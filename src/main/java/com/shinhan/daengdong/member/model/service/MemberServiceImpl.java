package com.shinhan.daengdong.member.model.service;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.member.model.repository.MemberRepositoryInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberServiceInterface{

    @Autowired
    MemberRepositoryInterface memberRepository;

    @Override
    public MemberDTO login(String email){
        return memberRepository.login(email);
    }

    @Override
    public MemberDTO signUp(MemberDTO kakaoMember) {
        return null;
    }

}
