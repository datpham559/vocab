--liquibase formatted sql

--changeset vocab:038-seed-words-batch31
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Phrasal Verbs (high frequency)
(N'break down', N'/breɪk daʊn/', N'hỏng hóc / phân tích', N'phrasal verb', N'INTERMEDIATE', N'The car broke down on the highway.', N'Xe bị hỏng trên đường cao tốc.'),
(N'break out', N'/breɪk aʊt/', N'bùng phát / thoát ra', N'phrasal verb', N'INTERMEDIATE', N'A fire broke out in the building.', N'Một đám cháy bùng phát trong tòa nhà.'),
(N'bring about', N'/brɪŋ əˈbaʊt/', N'gây ra / mang lại', N'phrasal verb', N'INTERMEDIATE', N'Hard work brings about success.', N'Làm việc chăm chỉ mang lại thành công.'),
(N'bring up', N'/brɪŋ ʌp/', N'nuôi dưỡng / đề cập', N'phrasal verb', N'INTERMEDIATE', N'He was brought up in the countryside.', N'Anh ấy được nuôi dưỡng ở nông thôn.'),
(N'call off', N'/kɔːl ɒf/', N'hủy bỏ', N'phrasal verb', N'INTERMEDIATE', N'The event was called off due to rain.', N'Sự kiện bị hủy do mưa.'),
(N'carry on', N'/ˈkæri ɒn/', N'tiếp tục', N'phrasal verb', N'BEGINNER', N'Carry on even when things are hard.', N'Tiếp tục ngay cả khi mọi thứ khó khăn.'),
(N'catch up', N'/kætʃ ʌp/', N'bắt kịp', N'phrasal verb', N'BEGINNER', N'Let''s catch up over coffee.', N'Hãy gặp nhau uống cà phê nhé.'),
(N'check in', N'/tʃek ɪn/', N'nhận phòng / đăng ký', N'phrasal verb', N'BEGINNER', N'Check in at the hotel first.', N'Nhận phòng khách sạn trước.'),
(N'check out', N'/tʃek aʊt/', N'trả phòng / khám phá', N'phrasal verb', N'BEGINNER', N'Check out the new restaurant.', N'Khám phá nhà hàng mới.'),
(N'come across', N'/kʌm əˈkrɒs/', N'tình cờ gặp', N'phrasal verb', N'INTERMEDIATE', N'I came across an old friend.', N'Tôi tình cờ gặp một người bạn cũ.'),
(N'come up with', N'/kʌm ʌp wɪð/', N'nghĩ ra / đề xuất', N'phrasal verb', N'INTERMEDIATE', N'Come up with a creative solution.', N'Nghĩ ra giải pháp sáng tạo.'),
(N'cut back', N'/kʌt bæk/', N'cắt giảm', N'phrasal verb', N'INTERMEDIATE', N'Cut back on expenses this month.', N'Cắt giảm chi tiêu tháng này.'),
(N'deal with', N'/diːl wɪð/', N'giải quyết / đối phó', N'phrasal verb', N'BEGINNER', N'Deal with problems calmly.', N'Giải quyết vấn đề bình tĩnh.'),
(N'figure out', N'/ˈfɪɡər aʊt/', N'tìm ra / hiểu ra', N'phrasal verb', N'INTERMEDIATE', N'Figure out the best approach.', N'Tìm ra cách tiếp cận tốt nhất.'),
(N'get along', N'/ɡet əˈlɒŋ/', N'hòa hợp với', N'phrasal verb', N'BEGINNER', N'They get along very well.', N'Họ hòa hợp rất tốt.'),
(N'get away', N'/ɡet əˈweɪ/', N'trốn thoát / nghỉ ngơi', N'phrasal verb', N'BEGINNER', N'We need to get away for a weekend.', N'Chúng ta cần đi nghỉ một cuối tuần.'),
(N'give up', N'/ɡɪv ʌp/', N'từ bỏ', N'phrasal verb', N'BEGINNER', N'Never give up on your dreams.', N'Đừng bao giờ từ bỏ ước mơ.'),
(N'go ahead', N'/ɡoʊ əˈhed/', N'tiến hành / cứ tiếp tục', N'phrasal verb', N'BEGINNER', N'Go ahead with the plan.', N'Tiến hành theo kế hoạch.'),
(N'go over', N'/ɡoʊ ˈoʊvər/', N'xem lại / kiểm tra', N'phrasal verb', N'INTERMEDIATE', N'Go over the report once more.', N'Xem lại báo cáo thêm một lần nữa.'),
(N'grow up', N'/ɡroʊ ʌp/', N'lớn lên / trưởng thành', N'phrasal verb', N'BEGINNER', N'Where did you grow up?', N'Bạn lớn lên ở đâu?'),
(N'hand in', N'/hænd ɪn/', N'nộp / giao', N'phrasal verb', N'BEGINNER', N'Hand in your assignment today.', N'Nộp bài tập hôm nay.'),
(N'hold on', N'/hoʊld ɒn/', N'chờ đợi / giữ vững', N'phrasal verb', N'BEGINNER', N'Hold on, I''ll be right there.', N'Chờ tôi, tôi đến ngay.'),
(N'keep up', N'/kiːp ʌp/', N'theo kịp / duy trì', N'phrasal verb', N'INTERMEDIATE', N'Keep up the good work.', N'Tiếp tục duy trì công việc tốt.'),
(N'look after', N'/lʊk ˈɑːftər/', N'chăm sóc', N'phrasal verb', N'BEGINNER', N'Look after your health.', N'Chăm sóc sức khỏe của bạn.'),
(N'look forward to', N'/lʊk ˈfɔːrwərd tuː/', N'mong đợi', N'phrasal verb', N'BEGINNER', N'I look forward to seeing you.', N'Tôi mong gặp bạn.'),
(N'look into', N'/lʊk ˈɪntuː/', N'điều tra / xem xét', N'phrasal verb', N'INTERMEDIATE', N'Look into the matter carefully.', N'Xem xét vấn đề cẩn thận.'),
(N'make up', N'/meɪk ʌp/', N'bịa ra / bù đắp / trang điểm', N'phrasal verb', N'INTERMEDIATE', N'Don''t make up excuses.', N'Đừng bịa ra lý do.'),
(N'move on', N'/muːv ɒn/', N'tiếp tục / bỏ qua', N'phrasal verb', N'INTERMEDIATE', N'It''s time to move on.', N'Đã đến lúc tiếp tục.'),
(N'point out', N'/pɔɪnt aʊt/', N'chỉ ra', N'phrasal verb', N'INTERMEDIATE', N'Point out any mistakes you find.', N'Chỉ ra bất kỳ lỗi nào bạn tìm thấy.'),
(N'pull off', N'/pʊl ɒf/', N'hoàn thành khó khăn', N'phrasal verb', N'INTERMEDIATE', N'She pulled off an amazing performance.', N'Cô ấy thực hiện màn trình diễn tuyệt vời.'),
(N'put off', N'/pʊt ɒf/', N'trì hoãn', N'phrasal verb', N'INTERMEDIATE', N'Don''t put off important tasks.', N'Đừng trì hoãn công việc quan trọng.'),
(N'run out', N'/rʌn aʊt/', N'hết / cạn kiệt', N'phrasal verb', N'BEGINNER', N'We ran out of time.', N'Chúng tôi hết thời gian.'),
(N'set up', N'/set ʌp/', N'thiết lập / thành lập', N'phrasal verb', N'INTERMEDIATE', N'Set up a new account online.', N'Thiết lập tài khoản mới trực tuyến.'),
(N'show up', N'/ʃoʊ ʌp/', N'xuất hiện / có mặt', N'phrasal verb', N'BEGINNER', N'Please show up on time.', N'Vui lòng có mặt đúng giờ.'),
(N'take over', N'/teɪk ˈoʊvər/', N'tiếp quản', N'phrasal verb', N'INTERMEDIATE', N'She will take over the project.', N'Cô ấy sẽ tiếp quản dự án.'),
(N'talk over', N'/tɔːk ˈoʊvər/', N'thảo luận', N'phrasal verb', N'INTERMEDIATE', N'Let''s talk over the options.', N'Hãy thảo luận về các lựa chọn.'),
(N'think over', N'/θɪŋk ˈoʊvər/', N'suy nghĩ kỹ', N'phrasal verb', N'INTERMEDIATE', N'Think over your decision.', N'Suy nghĩ kỹ về quyết định của bạn.'),
(N'throw away', N'/θroʊ əˈweɪ/', N'vứt bỏ', N'phrasal verb', N'BEGINNER', N'Throw away the garbage.', N'Vứt rác đi.'),
(N'turn down', N'/tɜːrn daʊn/', N'từ chối / vặn nhỏ', N'phrasal verb', N'INTERMEDIATE', N'He turned down the job offer.', N'Anh ấy từ chối lời đề nghị việc làm.'),
(N'work out', N'/wɜːrk aʊt/', N'tập thể dục / giải quyết', N'phrasal verb', N'BEGINNER', N'Work out the problem together.', N'Cùng nhau giải quyết vấn đề.'),
-- Thematic: Collocations & Expressions
(N'on the contrary', N'/ɒn ðə ˈkɒntrəri/', N'ngược lại', N'expression', N'INTERMEDIATE', N'On the contrary, I agree with you.', N'Ngược lại, tôi đồng ý với bạn.'),
(N'by contrast', N'/baɪ ˈkɒntrɑːst/', N'trái lại', N'expression', N'INTERMEDIATE', N'By contrast, the old method was slow.', N'Trái lại, phương pháp cũ chậm chạp.'),
(N'for instance', N'/fər ˈɪnstəns/', N'ví dụ như', N'expression', N'BEGINNER', N'For instance, you could try yoga.', N'Ví dụ như, bạn có thể thử yoga.'),
(N'in addition', N'/ɪn əˈdɪʃən/', N'thêm vào đó', N'expression', N'BEGINNER', N'In addition, we offer free shipping.', N'Thêm vào đó, chúng tôi cung cấp vận chuyển miễn phí.'),
(N'in conclusion', N'/ɪn kənˈkluːʒən/', N'kết lại', N'expression', N'INTERMEDIATE', N'In conclusion, the project was a success.', N'Kết lại, dự án đã thành công.'),
(N'in other words', N'/ɪn ˈʌðər wɜːrdz/', N'nói cách khác', N'expression', N'INTERMEDIATE', N'In other words, it''s too expensive.', N'Nói cách khác, nó quá đắt.'),
(N'in spite of', N'/ɪn spaɪt əv/', N'mặc dù', N'expression', N'INTERMEDIATE', N'In spite of the rain, we went out.', N'Mặc dù trời mưa, chúng tôi vẫn ra ngoài.'),
(N'in terms of', N'/ɪn tɜːrmz əv/', N'về mặt / xét về', N'expression', N'INTERMEDIATE', N'In terms of quality, this is the best.', N'Về mặt chất lượng, đây là tốt nhất.'),
(N'not only but also', N'/nɒt ˈoʊnli bʌt ˈɔːlsoʊ/', N'không chỉ... mà còn', N'expression', N'INTERMEDIATE', N'Not only is she smart but also kind.', N'Cô ấy không chỉ thông minh mà còn tốt bụng.'),
(N'on the other hand', N'/ɒn ðə ˈʌðər hænd/', N'mặt khác', N'expression', N'INTERMEDIATE', N'On the other hand, it has benefits.', N'Mặt khác, nó có những lợi ích.'),
(N'such as', N'/sʌtʃ əz/', N'chẳng hạn như', N'expression', N'BEGINNER', N'Eat healthy foods such as vegetables.', N'Ăn thực phẩm lành mạnh như rau quả.'),
(N'that is to say', N'/ðæt ɪz tuː seɪ/', N'nghĩa là', N'expression', N'INTERMEDIATE', N'That is to say, we need more time.', N'Nghĩa là chúng ta cần thêm thời gian.'),
(N'to begin with', N'/tuː bɪˈɡɪn wɪð/', N'để bắt đầu', N'expression', N'BEGINNER', N'To begin with, let me explain the plan.', N'Để bắt đầu, hãy để tôi giải thích kế hoạch.'),
(N'with regard to', N'/wɪð rɪˈɡɑːrd tuː/', N'liên quan đến', N'expression', N'INTERMEDIATE', N'With regard to your question, here is the answer.', N'Liên quan đến câu hỏi của bạn, đây là câu trả lời.'),
(N'as a result', N'/æz ə rɪˈzʌlt/', N'kết quả là', N'expression', N'BEGINNER', N'As a result, sales increased.', N'Kết quả là doanh số tăng.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('break down','break out','bring about','bring up','call off','carry on','catch up','check in','check out','come across','come up with','cut back','deal with','figure out','get along','get away','give up','go ahead','go over','grow up','hand in','hold on','keep up','look after','look forward to','look into','make up','move on','point out','pull off','put off','run out','set up','show up','take over','talk over','think over','throw away','turn down','work out','on the contrary','by contrast','for instance','in addition','in conclusion','in other words','in spite of','in terms of','not only but also','on the other hand','such as','that is to say','to begin with','with regard to','as a result');
