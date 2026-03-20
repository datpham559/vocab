--liquibase formatted sql

--changeset vocab-dev:006-seed-initial-words
-- ============================================================
-- BEGINNER WORDS
-- ============================================================
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'apple', N'/ˈæp.əl/', N'quả táo', N'noun', N'I eat an apple every morning.', N'Tôi ăn một quả táo mỗi sáng.', N'BEGINNER', N'Food');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'beautiful', N'/ˈbjuː.tɪ.fəl/', N'đẹp, xinh đẹp', N'adjective', N'She has a beautiful smile.', N'Cô ấy có nụ cười đẹp.', N'BEGINNER', N'Descriptive');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'book', N'/bʊk/', N'cuốn sách', N'noun', N'I read a book before bed.', N'Tôi đọc sách trước khi ngủ.', N'BEGINNER', N'Education');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'cat', N'/kæt/', N'con mèo', N'noun', N'My cat sleeps all day.', N'Con mèo của tôi ngủ cả ngày.', N'BEGINNER', N'Animals');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'dog', N'/dɒɡ/', N'con chó', N'noun', N'The dog is playing in the park.', N'Con chó đang chơi trong công viên.', N'BEGINNER', N'Animals');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'friend', N'/frend/', N'người bạn, bạn bè', N'noun', N'She is my best friend.', N'Cô ấy là người bạn thân nhất của tôi.', N'BEGINNER', N'Social');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'happy', N'/ˈhæp.i/', N'vui vẻ, hạnh phúc', N'adjective', N'I am happy to meet you.', N'Tôi vui được gặp bạn.', N'BEGINNER', N'Emotions');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'house', N'/haʊs/', N'ngôi nhà', N'noun', N'They built a new house.', N'Họ xây một ngôi nhà mới.', N'BEGINNER', N'Places');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'learn', N'/lɜːrn/', N'học, học hỏi', N'verb', N'I want to learn English.', N'Tôi muốn học tiếng Anh.', N'BEGINNER', N'Education');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'music', N'/ˈmjuː.zɪk/', N'âm nhạc', N'noun', N'I love listening to music.', N'Tôi thích nghe nhạc.', N'BEGINNER', N'Entertainment');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'night', N'/naɪt/', N'ban đêm, đêm', N'noun', N'The stars shine at night.', N'Các ngôi sao toả sáng vào ban đêm.', N'BEGINNER', N'Time');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'open', N'/ˈoʊ.pən/', N'mở, mở ra', N'verb', N'Please open the window.', N'Xin hãy mở cửa sổ ra.', N'BEGINNER', N'Actions');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'water', N'/ˈwɔː.tər/', N'nước', N'noun', N'Drink plenty of water every day.', N'Uống nhiều nước mỗi ngày.', N'BEGINNER', N'Nature');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'school', N'/skuːl/', N'trường học', N'noun', N'Children go to school every day.', N'Trẻ em đi học mỗi ngày.', N'BEGINNER', N'Education');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'travel', N'/ˈtræv.əl/', N'du lịch, đi du lịch', N'verb', N'I love to travel around the world.', N'Tôi thích du lịch vòng quanh thế giới.', N'BEGINNER', N'Travel');

-- ============================================================
-- INTERMEDIATE WORDS
-- ============================================================
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'accomplish', N'/əˈkɒm.plɪʃ/', N'hoàn thành, đạt được', N'verb', N'She accomplished all her goals this year.', N'Cô ấy đã hoàn thành tất cả mục tiêu năm nay.', N'INTERMEDIATE', N'Achievement');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'advocate', N'/ˈæd.və.keɪt/', N'ủng hộ, vận động cho', N'verb', N'She advocates for children''s rights.', N'Cô ấy vận động cho quyền trẻ em.', N'INTERMEDIATE', N'Social');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'challenge', N'/ˈtʃæl.ɪndʒ/', N'thách thức', N'noun', N'Learning a new language is a challenge.', N'Học một ngôn ngữ mới là một thách thức.', N'INTERMEDIATE', N'Education');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'develop', N'/dɪˈvel.əp/', N'phát triển, xây dựng', N'verb', N'We need to develop new skills.', N'Chúng ta cần phát triển kỹ năng mới.', N'INTERMEDIATE', N'Work');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'environment', N'/ɪnˈvaɪ.rən.mənt/', N'môi trường', N'noun', N'We must protect our environment.', N'Chúng ta phải bảo vệ môi trường.', N'INTERMEDIATE', N'Nature');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'fortunate', N'/ˈfɔːr.tʃən.ɪt/', N'may mắn, hên', N'adjective', N'I am fortunate to have such good friends.', N'Tôi may mắn có những người bạn tốt như vậy.', N'INTERMEDIATE', N'Emotions');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'generate', N'/ˈdʒen.ər.eɪt/', N'tạo ra, sinh ra', N'verb', N'Solar panels generate electricity.', N'Pin mặt trời tạo ra điện.', N'INTERMEDIATE', N'Technology');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'initiative', N'/ɪˈnɪʃ.ɪ.ə.tɪv/', N'sáng kiến, chủ động', N'noun', N'She took the initiative to solve the problem.', N'Cô ấy chủ động giải quyết vấn đề.', N'INTERMEDIATE', N'Work');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'negotiate', N'/nɪˈɡoʊ.ʃi.eɪt/', N'đàm phán, thương lượng', N'verb', N'They negotiated a new contract.', N'Họ đã đàm phán một hợp đồng mới.', N'INTERMEDIATE', N'Business');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'opportunity', N'/ˌɒp.əˈtjuː.nɪ.ti/', N'cơ hội', N'noun', N'This is a great opportunity for growth.', N'Đây là cơ hội tuyệt vời để phát triển.', N'INTERMEDIATE', N'Work');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'perspective', N'/pəˈspek.tɪv/', N'quan điểm, góc nhìn', N'noun', N'Try to see things from a different perspective.', N'Hãy thử nhìn mọi thứ từ góc nhìn khác.', N'INTERMEDIATE', N'Thinking');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'strategy', N'/ˈstræt.ɪ.dʒi/', N'chiến lược', N'noun', N'We need a clear strategy to succeed.', N'Chúng ta cần một chiến lược rõ ràng để thành công.', N'INTERMEDIATE', N'Business');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'transform', N'/trænsˈfɔːrm/', N'biến đổi, chuyển hoá', N'verb', N'Exercise can transform your body.', N'Tập thể dục có thể biến đổi cơ thể bạn.', N'INTERMEDIATE', N'Health');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'vulnerable', N'/ˈvʌl.nər.ə.bəl/', N'dễ bị tổn thương, yếu đuối', N'adjective', N'Children are vulnerable to online dangers.', N'Trẻ em dễ bị tổn thương trước các nguy hiểm trực tuyến.', N'INTERMEDIATE', N'Descriptive');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'collaborate', N'/kəˈlæb.ər.eɪt/', N'hợp tác, cộng tác', N'verb', N'We need to collaborate to finish this project.', N'Chúng ta cần hợp tác để hoàn thành dự án này.', N'INTERMEDIATE', N'Work');

-- ============================================================
-- ADVANCED WORDS
-- ============================================================
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'ambiguous', N'/æmˈbɪɡ.ju.əs/', N'mơ hồ, không rõ ràng', N'adjective', N'The contract terms were ambiguous.', N'Các điều khoản hợp đồng mơ hồ.', N'ADVANCED', N'Language');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'benevolent', N'/bɪˈnev.ə.lənt/', N'nhân từ, độ lượng', N'adjective', N'The benevolent king helped his people.', N'Vị vua nhân từ đã giúp đỡ người dân.', N'ADVANCED', N'Character');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'circumvent', N'/ˌsɜː.kəmˈvent/', N'tránh né, lách luật', N'verb', N'They tried to circumvent the rules.', N'Họ cố gắng lách các quy tắc.', N'ADVANCED', N'Actions');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'diligent', N'/ˈdɪl.ɪ.dʒənt/', N'chăm chỉ, cần cù', N'adjective', N'She is a diligent student who always studies hard.', N'Cô ấy là học sinh chăm chỉ luôn học hành tích cực.', N'ADVANCED', N'Character');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'eloquent', N'/ˈel.ə.kwənt/', N'hùng hồn, lưu loát, ăn nói khéo léo', N'adjective', N'She gave an eloquent speech at the conference.', N'Cô ấy đã có bài phát biểu hùng hồn tại hội nghị.', N'ADVANCED', N'Language');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'formidable', N'/ˈfɔːr.mɪ.də.bəl/', N'đáng sợ, ghê gớm, ấn tượng', N'adjective', N'She is a formidable opponent in chess.', N'Cô ấy là đối thủ đáng gờm trong cờ vua.', N'ADVANCED', N'Descriptive');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'gregarious', N'/ɡrɪˈɡeə.ri.əs/', N'thích giao thiệp, hướng ngoại', N'adjective', N'He is a gregarious person who loves parties.', N'Anh ấy là người hướng ngoại thích các bữa tiệc.', N'ADVANCED', N'Character');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'inevitable', N'/ɪnˈev.ɪ.tə.bəl/', N'không thể tránh khỏi, tất yếu', N'adjective', N'Change is inevitable in life.', N'Thay đổi là điều không thể tránh khỏi trong cuộc sống.', N'ADVANCED', N'Thinking');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'meticulous', N'/məˈtɪk.jʊ.ləs/', N'tỉ mỉ, cẩn thận từng chi tiết', N'adjective', N'The surgeon was meticulous in every procedure.', N'Bác sĩ phẫu thuật rất tỉ mỉ trong từng quy trình.', N'ADVANCED', N'Character');

INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, example_sentence, example_translation, difficulty, category)
VALUES (N'paradox', N'/ˈpær.ə.dɒks/', N'nghịch lý, điều mâu thuẫn', N'noun', N'It is a paradox that the more you know, the more you realize you don''t know.', N'Đây là một nghịch lý: càng biết nhiều, bạn càng nhận ra mình không biết gì.', N'ADVANCED', N'Thinking');

--rollback DELETE FROM words WHERE word IN ('apple','beautiful','book','cat','dog','friend','happy','house','learn','music','night','open','water','school','travel','accomplish','advocate','challenge','develop','environment','fortunate','generate','initiative','negotiate','opportunity','perspective','strategy','transform','vulnerable','collaborate','ambiguous','benevolent','circumvent','diligent','eloquent','formidable','gregarious','inevitable','meticulous','paradox');
