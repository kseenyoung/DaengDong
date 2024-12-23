INSERT INTO `members` (`member_email`, `member_name`, `member_nickname`, `member_profile_photo`)
VALUES
('john.doe@example.com', 'John Doe', 'Johnny', 'photo1.jpg'),
('jane.smith@example.com', 'Jane Smith', 'Janey', 'photo2.jpg'),
('michael.brown@exampmembersmembersle.com', 'Michael Brown', 'MikeB', 'photo3.jpg'),
('susan.white@example.com', 'Susan White', 'SueW', 'photo4.jpg'),
('emma.jones@example.com', 'Emma Jones', 'EmJay', 'photo5.jpg'),
('will.taylor@example.com', 'Will Taylor', 'WillT', 'photo6.jpg'),
('olivia.lee@example.com', 'Olivia Lee', 'LivL', 'photo7.jpg'),
('lucas.kim@example.com', 'Lucas Kim', 'LukeK', 'photo8.jpg'),
('mason.harris@example.com', 'Mason Harris', 'MaseH', 'photo9.jpg'),
('ava.wilson@example.com', 'Ava Wilson', 'AvaW', 'photo10.jpg');


INSERT INTO `photocards` (`photo_card_id`, `user_email`, `kakao_place_id`, `photo_card_image_url`, `photo_card_perior`, `금액`)
VALUES
(1, 'john.doe@example.com', 101, 'card1.jpg', '2024-06-01', 15000),
(2, 'jane.smith@example.com', 102, 'card2.jpg', '2024-06-02', 20000),
(3, 'michael.brown@example.com', 103, 'card3.jpg', '2024-06-03', 10000),
(4, 'susan.white@example.com', 104, 'card4.jpg', '2024-06-04', 30000),
(5, 'emma.jones@example.com', 105, 'card5.jpg', '2024-06-05', 25000),
(6, 'will.taylor@example.com', 106, 'card6.jpg', '2024-06-06', 12000),
(7, 'olivia.lee@example.com', 107, 'card7.jpg', '2024-06-07', 18000),
(8, 'lucas.kim@example.com', 108, 'card8.jpg', '2024-06-08', 22000),
(9, 'mason.harris@example.com', 109, 'card9.jpg', '2024-06-09', 19000),
(10, 'ava.wilson@example.com', 110, 'card10.jpg', '2024-06-10', 21000);

select * from plans;
INSERT INTO `plans` (`plan_id`, `member_email`, `start_date`, `end_date`, `plan_state`)
VALUES
(1, 'john.doe@example.com', '2024-07-01', '2024-07-10', 1),
(2, 'jane.smith@example.com', '2024-08-01', '2024-08-05', 0),
(3, 'michael.brown@example.com', '2024-09-01', '2024-09-15', 1),
(4, 'susan.white@example.com', '2024-10-01', '2024-10-10', 0),
(5, 'emma.jones@example.com', '2024-11-01', '2024-11-20', 1),
(6, 'will.taylor@example.com', '2024-12-01', '2024-12-05', 0),
(7, 'olivia.lee@example.com', '2025-01-01', '2025-01-07', 1),
(8, 'lucas.kim@example.com', '2025-02-01', '2025-02-15', 0),
(9, 'mason.harris@example.com', '2025-03-01', '2025-03-10', 1),
(10, 'ava.wilson@example.com', '2025-04-01', '2025-04-05', 0);
select * from posts;
INSERT INTO `posts` (`post_id`, `user_email`, `plan_id`, `category_id`, `post_title`, `post_content`)
VALUES
(1, 'john.doe@example.com', 1, 1, 'Trip to Jeju Island', 'Amazing trip to Jeju with lots of food!'),
(2, 'jane.smith@example.com', 2, 2, 'Travel Tips for Busan', 'Top 5 travel tips for visiting Busan.'),
(3, 'michael.brown@example.com', 3, 3, 'Photography Fun', 'Captured some beautiful scenery in Seoul.'),
(4, 'susan.white@example.com', 4, 4, 'Best Hiking Trails', 'Sharing the best hiking trails in Korea.'),
(5, 'emma.jones@example.com', 5, 1, 'Family Trip to Jeonju', 'Our family enjoyed Jeonju Hanok Village.'),
(6, 'will.taylor@example.com', 6, 2, 'K-Drama Locations', 'Visiting popular K-drama filming spots!'),
(7, 'olivia.lee@example.com', 7, 3, 'Street Food Tour', 'Delicious street food adventures in Gwangjang Market.'),
(8, 'lucas.kim@example.com', 8, 4, 'Hidden Gems', 'Exploring hidden gems in Busan.'),
(9, 'mason.harris@example.com', 9, 1, 'Jeju Road Trip', 'Unforgettable road trip along Jeju coast.'),
(10, 'ava.wilson@example.com', 10, 2, 'Top Cafés in Seoul', 'Best coffee spots for café lovers!');

select * from reviews;
INSERT INTO `reviews` (`review_id`, `kakao_place_id`, `user_email`, `review_rating`, `review_content`)
VALUES
(1, 101, 'john.doe@example.com', 5, 'Excellent place to visit!'),
(2, 102, 'jane.smith@example.com', 4, 'Great experience overall.'),
(3, 103, 'michael.brown@example.com', 5, 'Beautiful scenery.'),
(4, 104, 'susan.white@example.com', 3, 'Average, but worth visiting.'),
(5, 105, 'emma.jones@example.com', 5, 'Highly recommend it!'),
(6, 106, 'will.taylor@example.com', 4, 'Nice and cozy.'),
(7, 107, 'olivia.lee@example.com', 3, 'Could be better.'),
(8, 108, 'lucas.kim@example.com', 5, 'Amazing views.'),
(9, 109, 'mason.harris@example.com', 4, 'Well worth the trip.'),
(10, 110, 'ava.wilson@example.com', 5, 'Absolutely loved it!');

select * from categories;
INSERT INTO `categories` (`category_id`, `category_name`)
VALUES
(1, '여행공유'),
(2, '여행도움'),
(3, '꿀팁'),
(4, '사진자랑');