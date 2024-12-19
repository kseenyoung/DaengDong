package com.shinhan.daengdong.pet.dto;

import java.sql.Date;
import java.time.LocalDateTime;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@Builder
@ToString
public class PetDTO {

    private Integer petId;
    private String memberEmail;
    private String petName;
    private String petGender;
    private Date petBirthday;
    private String petBloodType;
    private Integer petProfilePhoto;
    private String petSpecies;
    private LocalDateTime createAt;
    private LocalDateTime updateAt;
}
