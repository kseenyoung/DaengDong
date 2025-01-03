package com.shinhan.daengdong.pet.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import java.sql.Date;

@Getter @Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PetDTO {

    private static final String datePattern = "yy/mm/dd";

    private Integer petId;
    private String memberEmail;
    private String petName;
    private String petGender;
    @JsonFormat(pattern = datePattern)
    private Date petBirthday;
    private String petBloodType;
    private Integer petProfilePhoto;
    private String petSpecies;
}
