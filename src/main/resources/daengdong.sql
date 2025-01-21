use daengdong;

CREATE TABLE `posts` (
   `post_id` bigint NOT NULL AUTO_INCREMENT,
   `member_email` varchar(255) NOT NULL,
   `plan_id` bigint NOT NULL,
   `category_id` enum('여행중','여행완료','사진자랑','꿀팁') NOT NULL,
   `post_title` varchar(255) NOT NULL,
   `post_content` text NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`post_id`)
 ) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `comments` (
   `comment_id` int NOT NULL AUTO_INCREMENT,
   `post_id` bigint DEFAULT NULL,
   `member_email` varchar(255) NOT NULL,
   `comment` text NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`comment_id`),
   KEY `fk_comments_post_id` (`post_id`),
   CONSTRAINT `fk_comments_post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `members` (
   `member_email` varchar(255) NOT NULL,
   `member_name` varchar(255) NOT NULL,
   `member_nickname` varchar(255) NOT NULL,
   `member_profile_photo` varchar(255) NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`member_email`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `favorites` (
   `star_id` bigint NOT NULL AUTO_INCREMENT,
   `member_email` varchar(255) NOT NULL,
   `kakao_place_id` bigint NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`star_id`)
 ) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `keywords` (
   `keyword_id` bigint NOT NULL,
   `plan_id` bigint NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`keyword_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `likes` (
   `member_email` varchar(255) NOT NULL,
   `post_id` bigint NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`member_email`,`post_id`),
   KEY `fk_likes_post_id` (`post_id`),
   CONSTRAINT `fk_likes_post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
   CONSTRAINT `FK_members_TO_likes_1` FOREIGN KEY (`member_email`) REFERENCES `members` (`member_email`) ON DELETE CASCADE
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `member_plans` (
   `member_plan_id` bigint NOT NULL AUTO_INCREMENT,
   `member_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
   `plan_id` bigint NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`member_plan_id`)
 ) ENGINE=InnoDB AUTO_INCREMENT=780 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `notifications` (
   `notification_id` bigint NOT NULL AUTO_INCREMENT,
   `plan_id` bigint DEFAULT NULL,
   `post_id` bigint DEFAULT NULL,
   `sender_email` varchar(255) NOT NULL COMMENT 'user_email',
   `receiver_email` varchar(255) NOT NULL COMMENT 'user_email',
   `notification_type` tinyint NOT NULL COMMENT '1: 팔로우, 2: 좋아요, 3: 댓글, 4: 동행요청, 5: 여행초대',
   `is_checked` tinyint NOT NULL COMMENT '0: 미확인, 1: 확인',
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`notification_id`),
   KEY `fk_notifications_plan_id` (`plan_id`),
   KEY `fk_notifications_post_id` (`post_id`),
   CONSTRAINT `fk_notifications_post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pets` (
   `pet_id` int NOT NULL AUTO_INCREMENT,
   `member_email` varchar(255) NOT NULL,
   `pet_name` varchar(255) NOT NULL,
   `pet_gender` enum('Male','Female') DEFAULT NULL,
   `pet_birthday` date DEFAULT NULL,
   `pet_blood_type` varchar(255) DEFAULT NULL,
   `pet_profile_photo` varchar(255) DEFAULT NULL,
   `pet_species` varchar(255) DEFAULT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`pet_id`),
   KEY `fk_member_email` (`member_email`)
 ) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `photocards` (
   `photo_card_id` bigint NOT NULL,
   `member_email` varchar(255) NOT NULL,
   `kakao_place_id` bigint NOT NULL,
   `photo_card_image_url` varchar(255) NOT NULL,
   `photo_card_period` date NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   `amount` int NOT NULL,
   PRIMARY KEY (`photo_card_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `places` (
   `kakao_place_id` bigint NOT NULL,
   `region_id` varchar(255) DEFAULT NULL,
   `kakao_place_name` varchar(255) NOT NULL,
   `kakao_road_address_name` varchar(255) NOT NULL,
   `kakao_phone` varchar(255) DEFAULT NULL,
   `kakao_x` double NOT NULL,
   `kakao_y` double NOT NULL,
   `kakao_place_url` varchar(255) NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`kakao_place_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `plan_places` (
   `planner_place_id` int NOT NULL AUTO_INCREMENT,
   `plan_id` bigint NOT NULL,
   `kakao_place_id` bigint NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   `day` int DEFAULT NULL,
   PRIMARY KEY (`planner_place_id`)
 ) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `plans` (
   `plan_id` bigint NOT NULL AUTO_INCREMENT,
   `member_email` varchar(255) NOT NULL,
   `plan_name` varchar(255) NOT NULL,
   `start_date` date DEFAULT NULL,
   `end_date` date DEFAULT NULL,
   `plan_state` tinyint NOT NULL DEFAULT '0' COMMENT '0: 비공개, 1: 공개',
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`plan_id`)
 ) ENGINE=InnoDB AUTO_INCREMENT=499 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `post_images` (
   `photo_id` bigint NOT NULL AUTO_INCREMENT,
   `post_id` bigint NOT NULL,
   `image_url` varchar(255) NOT NULL,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`photo_id`),
   KEY `fk_post_images_post_id` (`post_id`),
   CONSTRAINT `fk_post_images_post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `regions` (
   `region_id` tinyint NOT NULL,
   `region_name` varchar(255) NOT NULL COMMENT '경기도, 강원도, 충청남도, 충청북도, 제주도, 전라북도, 전라남도, 경상북도, 경상남도',
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`region_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `relationships` (
   `from_email` varchar(255) NOT NULL COMMENT 'user_email',
   `to_email` varchar(255) NOT NULL COMMENT 'user_email',
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`from_email`,`to_email`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `reviews` (
   `review_id` bigint NOT NULL,
   `kakao_place_id` bigint NOT NULL,
   `member_email` varchar(255) NOT NULL,
   `review_rating` bigint DEFAULT NULL,
   `review_content` text,
   `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`review_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
