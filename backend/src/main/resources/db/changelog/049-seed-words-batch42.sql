--liquibase formatted sql

--changeset vocab:049-seed-words-batch42
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- More everyday words H-N
(N'holiday', N'/ˈhɒlɪdeɪ/', N'kỳ nghỉ / ngày lễ', N'noun', N'BEGINNER', N'We travel during the holiday.', N'Chúng tôi đi du lịch trong kỳ nghỉ.'),
(N'home', N'/hoʊm/', N'nhà / quê hương', N'noun', N'BEGINNER', N'There''s no place like home.', N'Không có nơi nào giống nhà.'),
(N'honest', N'/ˈɒnɪst/', N'trung thực', N'adjective', N'BEGINNER', N'Always be honest with others.', N'Luôn trung thực với người khác.'),
(N'hope', N'/hoʊp/', N'hy vọng', N'noun', N'BEGINNER', N'Never lose hope.', N'Đừng bao giờ mất hy vọng.'),
(N'hospital', N'/ˈhɒspɪtəl/', N'bệnh viện', N'noun', N'BEGINNER', N'Go to the hospital immediately.', N'Đến bệnh viện ngay lập tức.'),
(N'hot', N'/hɒt/', N'nóng', N'adjective', N'BEGINNER', N'The soup is very hot.', N'Canh rất nóng.'),
(N'hotel', N'/hoʊˈtel/', N'khách sạn', N'noun', N'BEGINNER', N'Book a hotel in advance.', N'Đặt khách sạn trước.'),
(N'hour', N'/aʊər/', N'giờ đồng hồ', N'noun', N'BEGINNER', N'Wait one more hour.', N'Đợi thêm một giờ nữa.'),
(N'house', N'/haʊs/', N'ngôi nhà', N'noun', N'BEGINNER', N'My house is near the park.', N'Nhà tôi gần công viên.'),
(N'hundred', N'/ˈhʌndrəd/', N'một trăm', N'number', N'BEGINNER', N'A hundred people attended.', N'Một trăm người tham dự.'),
(N'hungry', N'/ˈhʌŋɡri/', N'đói', N'adjective', N'BEGINNER', N'I''m hungry. Let''s eat.', N'Tôi đói. Hãy ăn thôi.'),
(N'husband', N'/ˈhʌzbənd/', N'chồng', N'noun', N'BEGINNER', N'Her husband is very supportive.', N'Chồng của cô ấy rất ủng hộ.'),
(N'idea', N'/aɪˈdɪə/', N'ý tưởng', N'noun', N'BEGINNER', N'That''s a great idea!', N'Đó là ý tưởng tuyệt vời!'),
(N'important', N'/ɪmˈpɔːrtənt/', N'quan trọng', N'adjective', N'BEGINNER', N'Health is the most important thing.', N'Sức khỏe là điều quan trọng nhất.'),
(N'inside', N'/ɪnˈsaɪd/', N'bên trong', N'adverb', N'BEGINNER', N'Come inside out of the cold.', N'Vào bên trong tránh lạnh.'),
(N'job', N'/dʒɒb/', N'công việc', N'noun', N'BEGINNER', N'Find a job you love.', N'Tìm một công việc bạn yêu thích.'),
(N'kind', N'/kaɪnd/', N'tử tế / loại', N'adjective', N'BEGINNER', N'Be kind to everyone.', N'Tử tế với mọi người.'),
(N'kitchen', N'/ˈkɪtʃɪn/', N'nhà bếp', N'noun', N'BEGINNER', N'Cook meals in the kitchen.', N'Nấu bữa ăn trong nhà bếp.'),
(N'large', N'/lɑːrdʒ/', N'lớn', N'adjective', N'BEGINNER', N'She lives in a large house.', N'Cô ấy sống trong một ngôi nhà lớn.'),
(N'late', N'/leɪt/', N'muộn / trễ', N'adjective', N'BEGINNER', N'Don''t be late for class.', N'Đừng đến muộn giờ học.'),
(N'laugh', N'/lɑːf/', N'cười', N'verb', N'BEGINNER', N'Laugh more, stress less.', N'Cười nhiều hơn, ít căng thẳng hơn.'),
(N'learn', N'/lɜːrn/', N'học / học hỏi', N'verb', N'BEGINNER', N'Learn something new every day.', N'Học điều mới mỗi ngày.'),
(N'leave', N'/liːv/', N'rời đi / để lại', N'verb', N'BEGINNER', N'Leave on time to avoid traffic.', N'Ra đi đúng giờ để tránh tắc đường.'),
(N'letter', N'/ˈletər/', N'thư / chữ cái', N'noun', N'BEGINNER', N'Write a letter to your friend.', N'Viết thư cho bạn.'),
(N'light', N'/laɪt/', N'ánh sáng / nhẹ', N'noun', N'BEGINNER', N'The light in the room is warm.', N'Ánh sáng trong phòng ấm áp.'),
(N'live', N'/lɪv/', N'sống / ở', N'verb', N'BEGINNER', N'Live each day to the fullest.', N'Sống hết mình mỗi ngày.'),
(N'long', N'/lɒŋ/', N'dài', N'adjective', N'BEGINNER', N'The road is very long.', N'Con đường rất dài.'),
(N'look', N'/lʊk/', N'nhìn', N'verb', N'BEGINNER', N'Look both ways before crossing.', N'Nhìn hai phía trước khi qua đường.'),
(N'lose', N'/luːz/', N'mất / thua', N'verb', N'BEGINNER', N'Don''t lose your keys.', N'Đừng làm mất chìa khóa.'),
(N'loud', N'/laʊd/', N'to / ồn ào', N'adjective', N'BEGINNER', N'The music is too loud.', N'Nhạc quá to.'),
(N'love', N'/lʌv/', N'tình yêu / yêu thích', N'noun', N'BEGINNER', N'Love is the most powerful force.', N'Tình yêu là sức mạnh mạnh nhất.'),
(N'lucky', N'/ˈlʌki/', N'may mắn', N'adjective', N'BEGINNER', N'You are very lucky today.', N'Bạn rất may mắn hôm nay.'),
(N'lunch', N'/lʌntʃ/', N'bữa trưa', N'noun', N'BEGINNER', N'Let''s have lunch together.', N'Hãy cùng ăn trưa.'),
(N'make', N'/meɪk/', N'làm / tạo ra', N'verb', N'BEGINNER', N'Make a difference in someone''s life.', N'Tạo ra sự khác biệt trong cuộc sống ai đó.'),
(N'mean', N'/miːn/', N'có nghĩa là / tàn nhẫn', N'verb', N'BEGINNER', N'What do you mean?', N'Bạn có ý nói gì?'),
(N'meet', N'/miːt/', N'gặp gỡ', N'verb', N'BEGINNER', N'Nice to meet you.', N'Rất vui được gặp bạn.'),
(N'money', N'/ˈmʌni/', N'tiền', N'noun', N'BEGINNER', N'Save money for the future.', N'Tiết kiệm tiền cho tương lai.'),
(N'month', N'/mʌnθ/', N'tháng', N'noun', N'BEGINNER', N'There are twelve months in a year.', N'Có mười hai tháng trong một năm.'),
(N'morning', N'/ˈmɔːrnɪŋ/', N'buổi sáng', N'noun', N'BEGINNER', N'Good morning!', N'Chào buổi sáng!'),
(N'mother', N'/ˈmʌðər/', N'mẹ', N'noun', N'BEGINNER', N'My mother is my hero.', N'Mẹ là anh hùng của tôi.'),
(N'mountain', N'/ˈmaʊntɪn/', N'núi', N'noun', N'BEGINNER', N'Climb the mountain if you dare.', N'Hãy leo núi nếu bạn dám.'),
(N'move', N'/muːv/', N'di chuyển', N'verb', N'BEGINNER', N'Move to a bigger place.', N'Chuyển đến nơi rộng hơn.'),
(N'much', N'/mʌtʃ/', N'nhiều', N'adverb', N'BEGINNER', N'Thank you very much.', N'Cảm ơn bạn rất nhiều.'),
(N'music', N'/ˈmjuːzɪk/', N'âm nhạc', N'noun', N'BEGINNER', N'Music soothes the soul.', N'Âm nhạc xoa dịu tâm hồn.'),
(N'name', N'/neɪm/', N'tên', N'noun', N'BEGINNER', N'What is your name?', N'Bạn tên là gì?'),
(N'near', N'/nɪər/', N'gần', N'adjective', N'BEGINNER', N'The school is near my house.', N'Trường gần nhà tôi.'),
(N'new', N'/njuː/', N'mới', N'adjective', N'BEGINNER', N'Try something new today.', N'Thử điều gì đó mới hôm nay.'),
(N'next', N'/nekst/', N'tiếp theo / bên cạnh', N'adjective', N'BEGINNER', N'Next time, be more careful.', N'Lần sau, hãy cẩn thận hơn.'),
(N'night', N'/naɪt/', N'đêm', N'noun', N'BEGINNER', N'Sleep well every night.', N'Ngủ ngon mỗi đêm.'),
(N'north', N'/nɔːrθ/', N'phía bắc', N'noun', N'BEGINNER', N'They traveled north.', N'Họ đi về phía bắc.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('holiday','home','honest','hope','hospital','hot','hotel','hour','house','hundred','hungry','husband','idea','important','inside','job','kind','kitchen','large','late','laugh','learn','leave','letter','light','live','long','look','lose','loud','love','lucky','lunch','make','mean','meet','money','month','morning','mother','mountain','move','much','music','name','near','new','next','night','north');
