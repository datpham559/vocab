--liquibase formatted sql

--changeset vocab:050-seed-words-batch43
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- More everyday words O-Z
(N'often', N'/ˈɒfən/', N'thường xuyên', N'adverb', N'BEGINNER', N'I often eat out on weekends.', N'Tôi thường ăn ngoài vào cuối tuần.'),
(N'old', N'/oʊld/', N'già / cũ', N'adjective', N'BEGINNER', N'Respect the old and help the young.', N'Kính già yêu trẻ.'),
(N'only', N'/ˈoʊnli/', N'chỉ / duy nhất', N'adverb', N'BEGINNER', N'There is only one chance.', N'Chỉ có một cơ hội.'),
(N'outside', N'/ˌaʊtˈsaɪd/', N'bên ngoài', N'adverb', N'BEGINNER', N'Play outside in the fresh air.', N'Chơi ngoài trời trong không khí trong lành.'),
(N'own', N'/oʊn/', N'của mình / sở hữu', N'adjective', N'BEGINNER', N'Have your own goals in life.', N'Có mục tiêu của riêng mình trong cuộc sống.'),
(N'parents', N'/ˈpeərənts/', N'cha mẹ', N'noun', N'BEGINNER', N'Love and respect your parents.', N'Yêu thương và kính trọng cha mẹ.'),
(N'park', N'/pɑːrk/', N'công viên / đậu xe', N'noun', N'BEGINNER', N'Walk in the park every day.', N'Đi bộ trong công viên mỗi ngày.'),
(N'pay', N'/peɪ/', N'trả tiền / lương', N'verb', N'BEGINNER', N'Pay attention in class.', N'Chú ý trong lớp học.'),
(N'people', N'/ˈpiːpəl/', N'mọi người', N'noun', N'BEGINNER', N'People are basically good.', N'Mọi người về cơ bản đều tốt.'),
(N'pick', N'/pɪk/', N'hái / lấy', N'verb', N'BEGINNER', N'Pick the best option.', N'Chọn lựa chọn tốt nhất.'),
(N'place', N'/pleɪs/', N'nơi chốn', N'noun', N'BEGINNER', N'This is a beautiful place.', N'Đây là nơi đẹp.'),
(N'plant', N'/plɑːnt/', N'cây trồng / trồng cây', N'noun', N'BEGINNER', N'Water the plant every day.', N'Tưới cây mỗi ngày.'),
(N'play', N'/pleɪ/', N'chơi / biểu diễn', N'verb', N'BEGINNER', N'Play outside after school.', N'Chơi ngoài trời sau khi học.'),
(N'please', N'/pliːz/', N'làm ơn / làm hài lòng', N'adverb', N'BEGINNER', N'Please sit down.', N'Làm ơn ngồi xuống.'),
(N'poor', N'/pʊər/', N'nghèo / tội nghiệp', N'adjective', N'BEGINNER', N'Help the poor when you can.', N'Giúp đỡ người nghèo khi có thể.'),
(N'price', N'/praɪs/', N'giá cả', N'noun', N'BEGINNER', N'What is the price of this shirt?', N'Giá của chiếc áo này là bao nhiêu?'),
(N'problem', N'/ˈprɒbləm/', N'vấn đề', N'noun', N'BEGINNER', N'Every problem has a solution.', N'Mọi vấn đề đều có giải pháp.'),
(N'put', N'/pʊt/', N'đặt / để', N'verb', N'BEGINNER', N'Put your bag on the table.', N'Để túi lên bàn.'),
(N'quickly', N'/ˈkwɪkli/', N'nhanh chóng', N'adverb', N'BEGINNER', N'Act quickly before it''s too late.', N'Hành động nhanh trước khi quá muộn.'),
(N'quiet', N'/ˈkwaɪɪt/', N'yên tĩnh', N'adjective', N'BEGINNER', N'Please be quiet in the library.', N'Giữ yên tĩnh trong thư viện.'),
(N'read', N'/riːd/', N'đọc', N'verb', N'BEGINNER', N'Read books every day.', N'Đọc sách mỗi ngày.'),
(N'ready', N'/ˈredi/', N'sẵn sàng', N'adjective', N'BEGINNER', N'Are you ready to start?', N'Bạn đã sẵn sàng chưa?'),
(N'remember', N'/rɪˈmembər/', N'nhớ', N'verb', N'BEGINNER', N'Remember to say thank you.', N'Nhớ nói cảm ơn.'),
(N'rest', N'/rest/', N'nghỉ ngơi', N'verb', N'BEGINNER', N'Take a rest when you are tired.', N'Nghỉ ngơi khi bạn mệt.'),
(N'rich', N'/rɪtʃ/', N'giàu có', N'adjective', N'BEGINNER', N'Being rich doesn''t mean happiness.', N'Giàu có không có nghĩa là hạnh phúc.'),
(N'right', N'/raɪt/', N'đúng / bên phải', N'adjective', N'BEGINNER', N'You made the right decision.', N'Bạn đã đưa ra quyết định đúng.'),
(N'road', N'/roʊd/', N'con đường', N'noun', N'BEGINNER', N'The road to success is long.', N'Con đường đến thành công rất dài.'),
(N'room', N'/ruːm/', N'phòng / không gian', N'noun', N'BEGINNER', N'Clean your room regularly.', N'Dọn phòng thường xuyên.'),
(N'round', N'/raʊnd/', N'tròn / vòng', N'adjective', N'BEGINNER', N'The Earth is round.', N'Trái Đất có hình tròn.'),
(N'run', N'/rʌn/', N'chạy', N'verb', N'BEGINNER', N'Run every morning for health.', N'Chạy bộ mỗi sáng cho sức khỏe.'),
(N'safe', N'/seɪf/', N'an toàn', N'adjective', N'BEGINNER', N'Keep your family safe.', N'Giữ gia đình an toàn.'),
(N'say', N'/seɪ/', N'nói', N'verb', N'BEGINNER', N'Say what you mean clearly.', N'Nói rõ ý bạn muốn.'),
(N'second', N'/ˈsekənd/', N'giây / thứ hai', N'noun', N'BEGINNER', N'Every second counts.', N'Từng giây đều quý giá.'),
(N'see', N'/siː/', N'nhìn thấy / hiểu', N'verb', N'BEGINNER', N'See the beauty in everything.', N'Nhìn thấy vẻ đẹp trong mọi thứ.'),
(N'send', N'/send/', N'gửi', N'verb', N'BEGINNER', N'Send the email right away.', N'Gửi email ngay.'),
(N'short', N'/ʃɔːrt/', N'ngắn / lùn', N'adjective', N'BEGINNER', N'Keep your speech short.', N'Giữ bài phát biểu ngắn.'),
(N'show', N'/ʃoʊ/', N'cho thấy / chương trình', N'verb', N'BEGINNER', N'Show kindness to strangers.', N'Thể hiện lòng tử tế với người lạ.'),
(N'slow', N'/sloʊ/', N'chậm', N'adjective', N'BEGINNER', N'Slow and steady wins the race.', N'Chậm mà chắc thắng cuộc.'),
(N'small', N'/smɔːl/', N'nhỏ', N'adjective', N'BEGINNER', N'Small actions create big changes.', N'Hành động nhỏ tạo ra thay đổi lớn.'),
(N'smile', N'/smaɪl/', N'nụ cười', N'noun', N'BEGINNER', N'A smile can brighten someone''s day.', N'Một nụ cười có thể làm sáng lên ngày của ai đó.'),
(N'son', N'/sʌn/', N'con trai', N'noun', N'BEGINNER', N'He is a proud father of a son.', N'Anh ấy là người cha tự hào của một con trai.'),
(N'soon', N'/suːn/', N'sớm', N'adverb', N'BEGINNER', N'See you soon!', N'Hẹn gặp sớm!'),
(N'south', N'/saʊθ/', N'phía nam', N'noun', N'BEGINNER', N'Birds fly south in winter.', N'Chim bay về phía nam vào mùa đông.'),
(N'stand', N'/stænd/', N'đứng', N'verb', N'BEGINNER', N'Stand up for what is right.', N'Đứng lên vì điều đúng đắn.'),
(N'start', N'/stɑːrt/', N'bắt đầu', N'verb', N'BEGINNER', N'Start each day with gratitude.', N'Bắt đầu mỗi ngày với lòng biết ơn.'),
(N'stay', N'/steɪ/', N'ở lại / duy trì', N'verb', N'BEGINNER', N'Stay healthy and active.', N'Duy trì sức khỏe và năng động.'),
(N'still', N'/stɪl/', N'vẫn / yên lặng', N'adverb', N'BEGINNER', N'He is still working hard.', N'Anh ấy vẫn đang làm việc chăm chỉ.'),
(N'stop', N'/stɒp/', N'dừng lại', N'verb', N'BEGINNER', N'Stop and think before acting.', N'Dừng lại và suy nghĩ trước khi hành động.'),
(N'tall', N'/tɔːl/', N'cao', N'adjective', N'BEGINNER', N'She is the tallest in her class.', N'Cô ấy cao nhất trong lớp.'),
(N'teach', N'/tiːtʃ/', N'dạy học', N'verb', N'BEGINNER', N'Teach others what you know.', N'Dạy người khác những gì bạn biết.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('often','old','only','outside','own','parents','park','pay','people','pick','place','plant','play','please','poor','price','problem','put','quickly','quiet','read','ready','remember','rest','rich','right','road','room','round','run','safe','say','second','see','send','short','show','slow','small','smile','son','soon','south','stand','start','stay','still','stop','tall','teach');
