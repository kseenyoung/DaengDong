DROP TABLE IF EXISTS `Member`;

CREATE TABLE `Member` (
	`member_email`	varchar(255)	NOT NULL,
	`member_name`	varchar(255)	NOT NULL,
	`member_nickname`	varchar(255)	NOT NULL,
	`member_profile_photo`	varchar(255)	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `PhotoCard`;

CREATE TABLE `PhotoCard` (
	`photo_card_id`	bigint	NOT NULL,
	`user_email`	varchar(255)	NOT NULL,
	`kakao_place_id`	bigint	NOT NULL,
	`photo_card_image_url`	varchar(255)	NOT NULL,
	`photo_card_perior`	date	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`금액`	int	NOT NULL
);

DROP TABLE IF EXISTS `plan`;

CREATE TABLE `plan` (
	`plan_id`	bigint	NOT NULL,
	`member_email`	varchar(255)	NOT NULL,
	`start_date`	datetime	NULL,
	`end_date`	datetime	NULL,
	`plan_state`	tinyint	NOT NULL	DEFAULT 0: 비공개, 1: 공개	COMMENT 'public/ private',
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `Post`;

CREATE TABLE `Post` (
	`post_id`	bigint	NOT NULL,
	`user_email`	varchar(255)	NOT NULL,
	`plan_id`	bigint	NOT NULL,
	`category_id`	bigint	NOT NULL,
	`post_title`	varchar2(255)	NOT NULL,
	`post_content`	text	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `Review`;

CREATE TABLE `Review` (
	`review_id`	bigint	NULL,
	`kakao_place_id`	bigint	NOT NULL,
	`user_email`	varchar(255)	NOT NULL,
	`review_rating`	bigint	NULL,
	`review_content`	bigint	NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `Pet`;

CREATE TABLE `Pet` (
	`pet_id`	bigint	NOT NULL,
	`user_id`	bigint	NOT NULL,
	`pet_name`	varchar(255)	NOT NULL,
	`pet_gender`	enum('Male', 'Female')	NULL,
	`pet_birthday`	date	NULL,
	`pet_blood_type`	varchar(255)	NULL,
	`pet_profile_photo`	bigint	NULL,
	`pet_species`	varchar(255)	NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `Place`;

CREATE TABLE `Place` (
	`kakao_place_id`	bigint	NOT NULL,
	`region_id`	tinyint	NOT NULL,
	`kakao_place_name`	varchar(255)	NOT NULL,
	`kakao_road_address_name`	varchar(255)	NOT NULL,
	`kakao_ phone`	varchar(255)	NULL,
	`kakao_ x`	double	NOT NULL,
	`kakao_ y`	double	NOT NULL,
	`kakao_ place_url`	varchar(255)	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `Comment`;

CREATE TABLE `Comment` (
	`comment_id`	bigint	NOT NULL,
	`post_id`	bigint	NOT NULL,
	`member_email`	varchar(255)	NOT NULL,
	`coment`	text	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `region`;

CREATE TABLE `region` (
	`region_id`	tinyint	NOT NULL,
	`region_name`	enum('경기도', '강원도', '충청남도', '충청북도', '제주도', '전라북도', '전라남도', '경상북도', '경상남도')	NOT NULL,
	`create_at`	timpstamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timpstamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `relationship`;

CREATE TABLE `relationship` (
	`from_email`	varchar2(255)	NOT NULL	COMMENT 'user_email',
	`to_email`	varchar2(255)	NOT NULL	COMMENT 'user_email',
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `PlanPlace`;

CREATE TABLE `PlanPlace` (
	`planner_place_id`	bigint	NOT NULL,
	`plan_id`	bigint	NOT NULL,
	`kakao_place_id`	bigint	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `Star`;

CREATE TABLE `Star` (
	`star_id`	bigint	NOT NULL,
	`user_email`	varchar2(255)	NOT NULL,
	`kakao_place_id`	bigint	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `Like`;

CREATE TABLE `Like` (
	`member_email`	varchar2(255)	NOT NULL,
	`post_id`	bigint	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `Keyword`;

CREATE TABLE `Keyword` (
	`keyword_id`	bigint	NOT NULL,
	`plan_id`	bigint	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `MemberPlan`;

CREATE TABLE `MemberPlan` (
	`member_plan_id`	bigint	NOT NULL,
	`member_email`	varchar2(255)	NOT NULL,
	`plan_id`	bigint	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `MemberRegion`;

CREATE TABLE `MemberRegion` (
	`member_region_id`	bigint	NOT NULL	COMMENT '반정규화',
	`region_id`	tinyint	NOT NULL,
	`user_email`	varchar2(255)	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `Photo`;

CREATE TABLE `Photo` (
	`photo_id`	bigint	NOT NULL,
	`post_id`	bigint	NOT NULL,
	`image_url`	bigint	NOT NULL,
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
	`category_id`	bigint	NOT NULL,
	`category_name`	varchar2(255)	NOT NULL	COMMENT '여행공유,  여행도움, 꿀팁, 사진자랑',
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
	`notification_id`	bigint	NOT NULL,
	`sender_email`	varchar2(255)	NOT NULL	COMMENT 'user_email',
	`receiver_email`	varchar2(255)	NOT NULL	COMMENT 'user_email',
	`notification_type`	tinyint	NOT NULL	COMMENT '1: 팔로우, 2: 좋아요, 3: 댓글 4: 동행요청, 5: 여행초대',
	`is_checked`	tinyint	NOT NULL	COMMENT '0: 미확인, 1: 확인',
	`create_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`update_at`	timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE `Member` ADD CONSTRAINT `PK_MEMBER` PRIMARY KEY (
	`member_email`
);

ALTER TABLE `PhotoCard` ADD CONSTRAINT `PK_PHOTOCARD` PRIMARY KEY (
	`photo_card_id`
);

ALTER TABLE `plan` ADD CONSTRAINT `PK_PLAN` PRIMARY KEY (
	`plan_id`
);

ALTER TABLE `Post` ADD CONSTRAINT `PK_POST` PRIMARY KEY (
	`post_id`
);

ALTER TABLE `Review` ADD CONSTRAINT `PK_REVIEW` PRIMARY KEY (
	`review_id`
);

ALTER TABLE `Pet` ADD CONSTRAINT `PK_PET` PRIMARY KEY (
	`pet_id`
);

ALTER TABLE `Place` ADD CONSTRAINT `PK_PLACE` PRIMARY KEY (
	`kakao_place_id`
);

ALTER TABLE `Comment` ADD CONSTRAINT `PK_COMMENT` PRIMARY KEY (
	`comment_id`
);

ALTER TABLE `region` ADD CONSTRAINT `PK_REGION` PRIMARY KEY (
	`region_id`
);

ALTER TABLE `PlanPlace` ADD CONSTRAINT `PK_PLANPLACE` PRIMARY KEY (
	`planner_place_id`
);

ALTER TABLE `Star` ADD CONSTRAINT `PK_STAR` PRIMARY KEY (
	`star_id`
);

ALTER TABLE `Like` ADD CONSTRAINT `PK_LIKE` PRIMARY KEY (
	`member_email`,
	`post_id`
);

ALTER TABLE `Keyword` ADD CONSTRAINT `PK_KEYWORD` PRIMARY KEY (
	`keyword_id`
);

ALTER TABLE `MemberPlan` ADD CONSTRAINT `PK_MEMBERPLAN` PRIMARY KEY (
	`member_plan_id`
);

ALTER TABLE `MemberRegion` ADD CONSTRAINT `PK_MEMBERREGION` PRIMARY KEY (
	`member_region_id`
);

ALTER TABLE `Photo` ADD CONSTRAINT `PK_PHOTO` PRIMARY KEY (
	`photo_id`
);

ALTER TABLE `category` ADD CONSTRAINT `PK_CATEGORY` PRIMARY KEY (
	`category_id`
);

ALTER TABLE `notification` ADD CONSTRAINT `PK_NOTIFICATION` PRIMARY KEY (
	`notification_id`
);

