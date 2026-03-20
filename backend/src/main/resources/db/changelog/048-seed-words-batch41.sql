--liquibase formatted sql

--changeset vocab:048-seed-words-batch41
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- More everyday words D-H
(N'delicious', N'/dɪˈlɪʃəs/', N'ngon', N'adjective', N'BEGINNER', N'This food is delicious!', N'Món ăn này ngon quá!'),
(N'dentist', N'/ˈdentɪst/', N'nha sĩ', N'noun', N'BEGINNER', N'Visit the dentist every six months.', N'Đến nha sĩ mỗi sáu tháng.'),
(N'describe', N'/dɪˈskraɪb/', N'mô tả', N'verb', N'BEGINNER', N'Describe what you see.', N'Mô tả những gì bạn thấy.'),
(N'dictionary', N'/ˈdɪkʃəneri/', N'từ điển', N'noun', N'BEGINNER', N'Look it up in the dictionary.', N'Tra trong từ điển.'),
(N'difficult', N'/ˈdɪfɪkəlt/', N'khó khăn', N'adjective', N'BEGINNER', N'This task is difficult but doable.', N'Nhiệm vụ này khó nhưng có thể làm được.'),
(N'dinner', N'/ˈdɪnər/', N'bữa tối', N'noun', N'BEGINNER', N'What''s for dinner tonight?', N'Tối nay ăn gì?'),
(N'direction', N'/dɪˈrekʃən/', N'phương hướng / chỉ dẫn', N'noun', N'BEGINNER', N'Follow the directions carefully.', N'Làm theo chỉ dẫn cẩn thận.'),
(N'dirty', N'/ˈdɜːrti/', N'bẩn', N'adjective', N'BEGINNER', N'Wash your dirty hands.', N'Rửa tay bẩn của bạn.'),
(N'drive', N'/draɪv/', N'lái xe', N'verb', N'BEGINNER', N'Drive safely on the road.', N'Lái xe an toàn trên đường.'),
(N'early', N'/ˈɜːrli/', N'sớm', N'adjective', N'BEGINNER', N'Wake up early to exercise.', N'Thức dậy sớm để tập thể dục.'),
(N'east', N'/iːst/', N'phía đông', N'noun', N'BEGINNER', N'The sun rises in the east.', N'Mặt trời mọc ở phía đông.'),
(N'easy', N'/ˈiːzi/', N'dễ', N'adjective', N'BEGINNER', N'This exercise is easy.', N'Bài tập này dễ.'),
(N'empty', N'/ˈempti/', N'trống / rỗng', N'adjective', N'BEGINNER', N'The glass is empty.', N'Cốc trống rỗng.'),
(N'enter', N'/ˈentər/', N'vào / nhập vào', N'verb', N'BEGINNER', N'Enter through the main door.', N'Vào qua cửa chính.'),
(N'evening', N'/ˈiːvnɪŋ/', N'buổi tối', N'noun', N'BEGINNER', N'Good evening, how are you?', N'Chào buổi tối, bạn có khỏe không?'),
(N'every', N'/ˈevri/', N'mỗi / mọi', N'adjective', N'BEGINNER', N'Exercise every day.', N'Tập thể dục mỗi ngày.'),
(N'exercise', N'/ˈeksərsaɪz/', N'bài tập / tập thể dục', N'noun', N'BEGINNER', N'Regular exercise is healthy.', N'Tập thể dục thường xuyên rất có lợi.'),
(N'expensive', N'/ɪkˈspensɪv/', N'đắt tiền', N'adjective', N'BEGINNER', N'That car is very expensive.', N'Chiếc xe đó rất đắt tiền.'),
(N'face', N'/feɪs/', N'khuôn mặt / đối mặt', N'noun', N'BEGINNER', N'Wash your face every morning.', N'Rửa mặt mỗi sáng.'),
(N'fall', N'/fɔːl/', N'ngã / mùa thu / rơi', N'verb', N'BEGINNER', N'Leaves fall in autumn.', N'Lá rơi vào mùa thu.'),
(N'family', N'/ˈfæməli/', N'gia đình', N'noun', N'BEGINNER', N'Family is most important.', N'Gia đình là quan trọng nhất.'),
(N'far', N'/fɑːr/', N'xa', N'adjective', N'BEGINNER', N'How far is the hospital?', N'Bệnh viện cách bao xa?'),
(N'fast', N'/fɑːst/', N'nhanh', N'adjective', N'BEGINNER', N'Run as fast as you can.', N'Chạy nhanh nhất có thể.'),
(N'feel', N'/fiːl/', N'cảm thấy', N'verb', N'BEGINNER', N'How do you feel today?', N'Hôm nay bạn cảm thấy thế nào?'),
(N'few', N'/fjuː/', N'vài / ít', N'adjective', N'BEGINNER', N'Only a few people attended.', N'Chỉ có một vài người tham dự.'),
(N'fight', N'/faɪt/', N'chiến đấu / cãi nhau', N'verb', N'BEGINNER', N'Fight for what you believe in.', N'Chiến đấu cho những gì bạn tin.'),
(N'find', N'/faɪnd/', N'tìm / nhận thấy', N'verb', N'BEGINNER', N'Can you find my keys?', N'Bạn có thể tìm chìa khóa của tôi không?'),
(N'finish', N'/ˈfɪnɪʃ/', N'hoàn thành / kết thúc', N'verb', N'BEGINNER', N'Finish your homework first.', N'Làm xong bài tập về nhà trước.'),
(N'fire', N'/faɪər/', N'lửa / sa thải', N'noun', N'BEGINNER', N'Be careful with fire.', N'Cẩn thận với lửa.'),
(N'fly', N'/flaɪ/', N'bay', N'verb', N'BEGINNER', N'I want to fly to Paris.', N'Tôi muốn bay đến Paris.'),
(N'friend', N'/frend/', N'bạn bè', N'noun', N'BEGINNER', N'Good friends support each other.', N'Bạn tốt hỗ trợ lẫn nhau.'),
(N'full', N'/fʊl/', N'đầy / no', N'adjective', N'BEGINNER', N'The glass is full of water.', N'Cốc đầy nước.'),
(N'fun', N'/fʌn/', N'vui vẻ / thú vị', N'noun', N'BEGINNER', N'Learning can be fun.', N'Học tập có thể là niềm vui.'),
(N'garden', N'/ˈɡɑːrdən/', N'khu vườn', N'noun', N'BEGINNER', N'Water the garden every morning.', N'Tưới vườn mỗi sáng.'),
(N'give', N'/ɡɪv/', N'cho / đưa', N'verb', N'BEGINNER', N'Give generously to those in need.', N'Cho rộng rãi với người cần.'),
(N'glad', N'/ɡlæd/', N'vui mừng', N'adjective', N'BEGINNER', N'I''m glad you came.', N'Tôi vui vì bạn đến.'),
(N'glass', N'/ɡlɑːs/', N'ly thủy tinh / kính', N'noun', N'BEGINNER', N'Fill the glass with water.', N'Rót đầy nước vào ly.'),
(N'go', N'/ɡoʊ/', N'đi', N'verb', N'BEGINNER', N'Go to school on time.', N'Đi học đúng giờ.'),
(N'good', N'/ɡʊd/', N'tốt', N'adjective', N'BEGINNER', N'You did a good job.', N'Bạn đã làm tốt.'),
(N'green', N'/ɡriːn/', N'màu xanh / xanh lá', N'adjective', N'BEGINNER', N'Eat more green vegetables.', N'Ăn nhiều rau xanh hơn.'),
(N'grow', N'/ɡroʊ/', N'lớn lên / phát triển', N'verb', N'BEGINNER', N'Watch your business grow.', N'Xem công việc kinh doanh phát triển.'),
(N'hand', N'/hænd/', N'bàn tay / đưa', N'noun', N'BEGINNER', N'Wash your hands before eating.', N'Rửa tay trước khi ăn.'),
(N'happy', N'/ˈhæpi/', N'vui vẻ / hạnh phúc', N'adjective', N'BEGINNER', N'Be happy with what you have.', N'Hãy vui vẻ với những gì bạn có.'),
(N'hard', N'/hɑːrd/', N'cứng / khó / chăm chỉ', N'adjective', N'BEGINNER', N'Work hard and be patient.', N'Làm việc chăm chỉ và kiên nhẫn.'),
(N'hear', N'/hɪər/', N'nghe', N'verb', N'BEGINNER', N'Can you hear me clearly?', N'Bạn có nghe rõ tôi không?'),
(N'heart', N'/hɑːrt/', N'trái tim', N'noun', N'BEGINNER', N'Follow your heart.', N'Hãy theo tiếng gọi trái tim.'),
(N'heavy', N'/ˈhevi/', N'nặng', N'adjective', N'BEGINNER', N'The box is too heavy to lift.', N'Hộp quá nặng để nhấc.'),
(N'help', N'/help/', N'giúp đỡ', N'verb', N'BEGINNER', N'Always help those in need.', N'Luôn giúp đỡ người cần.'),
(N'high', N'/haɪ/', N'cao', N'adjective', N'BEGINNER', N'Set high goals for yourself.', N'Đặt mục tiêu cao cho bản thân.'),
(N'hold', N'/hoʊld/', N'giữ / nắm', N'verb', N'BEGINNER', N'Hold the door for others.', N'Giữ cửa cho người khác.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('delicious','dentist','describe','dictionary','difficult','dinner','direction','dirty','drive','early','east','easy','empty','enter','evening','every','exercise','expensive','face','fall','family','far','fast','feel','few','fight','find','finish','fire','fly','friend','full','fun','garden','give','glad','glass','go','good','green','grow','hand','happy','hard','hear','heart','heavy','help','high','hold');
