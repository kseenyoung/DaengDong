package com.shinhan.daengdong.member.model.repository;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.member.dto.SignUpDTO;
import com.shinhan.daengdong.pet.dto.PetDTO;
import java.util.List;

public interface MemberRepositoryInterface {

    MemberDTO login(String email);

    MemberDTO insertMember(MemberDTO memberDTO);

    PetDTO insertPet(List<PetDTO> petDTO, String memberEmail);
}
