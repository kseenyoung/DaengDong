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

    private Integer pet_id;
    private String member_email;
    private String pet_name;
    private String pet_gender;
    private Date pet_birthday;
    private String pet_blood_type;
    private String pet_profile_photo;
    private String pet_species;
    private int pet_age;
}
