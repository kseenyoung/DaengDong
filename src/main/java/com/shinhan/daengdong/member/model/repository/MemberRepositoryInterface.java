package com.shinhan.daengdong.member.model.repository;

import com.shinhan.daengdong.member.dto.MemberDTO;

public interface MemberRepositoryInterface {
    MemberDTO login(MemberDTO memberDTO);
}
