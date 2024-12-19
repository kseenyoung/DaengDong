package com.shinhan.daengdong.pet.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.sql.Date;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

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
    private LocalDateTime createAt;
    private LocalDateTime updateAt;
}
