--liquibase formatted sql

--changeset vocab:022-seed-words-batch15
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- BEGINNER: Classroom & Study Verbs
(N'listen', N'/ˈlɪsən/', N'lắng nghe', N'verb', N'BEGINNER', N'Listen to the teacher carefully.', N'Lắng nghe giáo viên cẩn thận.'),
(N'speak', N'/spiːk/', N'nói chuyện', N'verb', N'BEGINNER', N'Speak English every day.', N'Nói tiếng Anh mỗi ngày.'),
(N'repeat', N'/rɪˈpiːt/', N'nhắc lại', N'verb', N'BEGINNER', N'Please repeat that.', N'Làm ơn nhắc lại.'),
(N'spell', N'/spel/', N'đánh vần', N'verb', N'BEGINNER', N'Spell your name please.', N'Đánh vần tên bạn đi.'),
(N'translate', N'/trænsˈleɪt/', N'dịch', N'verb', N'BEGINNER', N'Translate this sentence.', N'Dịch câu này đi.'),
(N'practice', N'/ˈpræktɪs/', N'luyện tập', N'verb', N'BEGINNER', N'Practice speaking every day.', N'Luyện tập nói mỗi ngày.'),
(N'check', N'/tʃek/', N'kiểm tra', N'verb', N'BEGINNER', N'Check your answers before submitting.', N'Kiểm tra câu trả lời trước khi nộp.'),
(N'correct', N'/kəˈrekt/', N'sửa / đúng', N'verb', N'BEGINNER', N'Correct your mistakes.', N'Sửa lỗi của bạn.'),
(N'mark', N'/mɑːrk/', N'chấm điểm / đánh dấu', N'verb', N'BEGINNER', N'The teacher marked the papers.', N'Giáo viên chấm bài.'),
(N'pass', N'/pæs/', N'vượt qua / đậu', N'verb', N'BEGINNER', N'Did you pass the exam?', N'Bạn đậu kỳ thi chưa?'),
(N'fail', N'/feɪl/', N'thất bại / rớt', N'verb', N'BEGINNER', N'Don''t be afraid to fail.', N'Đừng sợ thất bại.'),
-- BEGINNER: Technology (basic)
(N'computer', N'/kəmˈpjuːtər/', N'máy tính', N'noun', N'BEGINNER', N'I use the computer for work.', N'Tôi dùng máy tính để làm việc.'),
(N'phone', N'/foʊn/', N'điện thoại', N'noun', N'BEGINNER', N'Call me on my phone.', N'Gọi cho tôi qua điện thoại.'),
(N'internet', N'/ˈɪntərnet/', N'internet', N'noun', N'BEGINNER', N'The internet connects the world.', N'Internet kết nối thế giới.'),
(N'email', N'/ˈiːmeɪl/', N'thư điện tử', N'noun', N'BEGINNER', N'Send me an email.', N'Gửi email cho tôi.'),
(N'message', N'/ˈmesɪdʒ/', N'tin nhắn', N'noun', N'BEGINNER', N'Did you get my message?', N'Bạn nhận được tin nhắn của tôi chưa?'),
(N'website', N'/ˈwebsaɪt/', N'trang web', N'noun', N'BEGINNER', N'Visit our website for more info.', N'Truy cập trang web của chúng tôi để biết thêm.'),
(N'video', N'/ˈvɪdioʊ/', N'video', N'noun', N'BEGINNER', N'Watch this video to learn.', N'Xem video này để học.'),
(N'photo', N'/ˈfoʊtoʊ/', N'ảnh / hình ảnh', N'noun', N'BEGINNER', N'Take a photo of the view.', N'Chụp ảnh cảnh đẹp.'),
(N'screen', N'/skriːn/', N'màn hình', N'noun', N'BEGINNER', N'The screen is too bright.', N'Màn hình quá sáng.'),
(N'battery', N'/ˈbætəri/', N'pin', N'noun', N'BEGINNER', N'The battery is almost dead.', N'Pin sắp hết.'),
(N'charge', N'/tʃɑːrdʒ/', N'sạc (pin)', N'verb', N'BEGINNER', N'Charge your phone tonight.', N'Sạc điện thoại tối nay.'),
(N'search', N'/sɜːrtʃ/', N'tìm kiếm', N'verb', N'BEGINNER', N'Search for information online.', N'Tìm kiếm thông tin trực tuyến.'),
(N'click', N'/klɪk/', N'nhấp chuột', N'verb', N'BEGINNER', N'Click the button to continue.', N'Nhấp nút để tiếp tục.'),
(N'type', N'/taɪp/', N'gõ (bàn phím)', N'verb', N'BEGINNER', N'Type your name here.', N'Gõ tên bạn vào đây.'),
(N'save', N'/seɪv/', N'lưu (file)', N'verb', N'BEGINNER', N'Save your work often.', N'Thường xuyên lưu công việc.'),
-- INTERMEDIATE: Sociology
(N'ethnicity', N'/eθˈnɪsɪti/', N'dân tộc', N'noun', N'INTERMEDIATE', N'People of all ethnicities are welcome.', N'Chào đón người thuộc mọi dân tộc.'),
(N'prejudice', N'/ˈpredʒʊdɪs/', N'thành kiến', N'noun', N'INTERMEDIATE', N'Overcome prejudice with education.', N'Vượt qua thành kiến bằng giáo dục.'),
(N'discrimination', N'/dɪˌskrɪmɪˈneɪʃən/', N'sự phân biệt đối xử', N'noun', N'INTERMEDIATE', N'Discrimination is unacceptable.', N'Phân biệt đối xử là không thể chấp nhận.'),
(N'stereotype', N'/ˈsteriəˌtaɪp/', N'khuôn mẫu định kiến', N'noun', N'INTERMEDIATE', N'Avoid stereotyping people.', N'Tránh áp dụng khuôn mẫu cho người khác.'),
(N'integration', N'/ˌɪntɪˈɡreɪʃən/', N'hội nhập', N'noun', N'INTERMEDIATE', N'Social integration promotes harmony.', N'Hội nhập xã hội thúc đẩy hòa hợp.'),
(N'marginalized', N'/ˈmɑːrdʒɪnəlaɪzd/', N'bị gạt ra lề xã hội', N'adjective', N'INTERMEDIATE', N'Help marginalized communities.', N'Giúp đỡ cộng đồng bị gạt ra ngoài xã hội.'),
(N'inclusive', N'/ɪnˈkluːsɪv/', N'bao gồm tất cả / hòa nhập', N'adjective', N'INTERMEDIATE', N'Create an inclusive environment.', N'Tạo môi trường hòa nhập.'),
(N'empowerment', N'/ɪmˈpaʊərmənt/', N'trao quyền', N'noun', N'INTERMEDIATE', N'Women''s empowerment is important.', N'Trao quyền cho phụ nữ rất quan trọng.'),
(N'solidarity', N'/ˌsɒlɪˈdærɪti/', N'sự đoàn kết', N'noun', N'INTERMEDIATE', N'Show solidarity with those in need.', N'Thể hiện sự đoàn kết với người cần.'),
(N'civic', N'/ˈsɪvɪk/', N'dân sự', N'adjective', N'INTERMEDIATE', N'Participate in civic duties.', N'Tham gia các nghĩa vụ công dân.'),
-- INTERMEDIATE: Marketing & Media
(N'brand', N'/brænd/', N'thương hiệu', N'noun', N'INTERMEDIATE', N'Build a strong brand identity.', N'Xây dựng bản sắc thương hiệu mạnh.'),
(N'target audience', N'/ˈtɑːrɡɪt ˈɔːdiəns/', N'đối tượng mục tiêu', N'noun', N'INTERMEDIATE', N'Know your target audience well.', N'Hiểu rõ đối tượng mục tiêu của bạn.'),
(N'advertising', N'/ˈædvərtaɪzɪŋ/', N'quảng cáo', N'noun', N'INTERMEDIATE', N'Advertising increases brand awareness.', N'Quảng cáo tăng nhận thức thương hiệu.'),
(N'social media', N'/ˈsoʊʃəl ˈmiːdiə/', N'mạng xã hội', N'noun', N'INTERMEDIATE', N'Social media connects people globally.', N'Mạng xã hội kết nối mọi người toàn cầu.'),
(N'engagement', N'/ɪnˈɡeɪdʒmənt/', N'sự tương tác / gắn kết', N'noun', N'INTERMEDIATE', N'High engagement boosts visibility.', N'Tương tác cao tăng độ hiển thị.'),
(N'viral', N'/ˈvaɪrəl/', N'lan truyền nhanh', N'adjective', N'INTERMEDIATE', N'The video went viral overnight.', N'Video đó lan truyền qua đêm.'),
(N'content', N'/ˈkɒntent/', N'nội dung', N'noun', N'INTERMEDIATE', N'Create valuable content daily.', N'Tạo nội dung có giá trị hàng ngày.'),
(N'platform', N'/ˈplætfɔːrm/', N'nền tảng', N'noun', N'INTERMEDIATE', N'Choose the right platform.', N'Chọn đúng nền tảng.'),
(N'influencer', N'/ˈɪnfluənsər/', N'người có sức ảnh hưởng', N'noun', N'INTERMEDIATE', N'Work with influencers to grow.', N'Hợp tác với influencer để phát triển.'),
(N'analytics', N'/ˌænəˈlɪtɪks/', N'phân tích dữ liệu', N'noun', N'INTERMEDIATE', N'Use analytics to track performance.', N'Dùng phân tích dữ liệu để theo dõi hiệu suất.'),
-- ADVANCED: Linguistics (continued)
(N'pidgin', N'/ˈpɪdʒɪn/', N'ngôn ngữ lai (pidgin)', N'noun', N'ADVANCED', N'A pidgin language develops for trade.', N'Ngôn ngữ lai phát triển để phục vụ thương mại.'),
(N'creole', N'/ˈkriːoʊl/', N'ngôn ngữ creole', N'noun', N'ADVANCED', N'Creole languages have complex grammar.', N'Ngôn ngữ creole có ngữ pháp phức tạp.'),
(N'register', N'/ˈredʒɪstər/', N'phong cách ngôn ngữ', N'noun', N'ADVANCED', N'Use formal register in professional settings.', N'Dùng phong cách trang trọng trong môi trường chuyên nghiệp.'),
(N'pragmatics', N'/præɡˈmætɪks/', N'ngữ dụng học', N'noun', N'ADVANCED', N'Pragmatics studies language in context.', N'Ngữ dụng học nghiên cứu ngôn ngữ trong ngữ cảnh.'),
(N'euphemism', N'/ˈjuːfɪmɪzəm/', N'uyển ngữ', N'noun', N'ADVANCED', N'Use a euphemism to avoid offense.', N'Dùng uyển ngữ để tránh xúc phạm.'),
(N'dysphemism', N'/ˈdɪsfɪmɪzəm/', N'cách nói thô tục', N'noun', N'ADVANCED', N'Dysphemism is the opposite of euphemism.', N'Cách nói thô tục là đối nghịch với uyển ngữ.'),
(N'onomatopoeia', N'/ˌɒnəˌmætəˈpiːə/', N'tượng thanh', N'noun', N'ADVANCED', N'Buzz and hiss are onomatopoeia.', N'Buzz và hiss là từ tượng thanh.'),
(N'polysemy', N'/pəˈlɪsɪmi/', N'hiện tượng đa nghĩa', N'noun', N'ADVANCED', N'Polysemy means one word has many meanings.', N'Đa nghĩa có nghĩa là một từ có nhiều ý nghĩa.'),
(N'morpheme', N'/ˈmɔːrfiːm/', N'hình vị', N'noun', N'ADVANCED', N'A morpheme is the smallest unit of meaning.', N'Hình vị là đơn vị nghĩa nhỏ nhất.'),
(N'intonation', N'/ˌɪntəˈneɪʃən/', N'ngữ điệu', N'noun', N'ADVANCED', N'Intonation changes the meaning of sentences.', N'Ngữ điệu thay đổi ý nghĩa câu.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('listen','speak','repeat','spell','translate','practice','check','correct','mark','pass','fail','computer','phone','internet','email','message','website','video','photo','screen','battery','charge','search','click','type','save','ethnicity','prejudice','discrimination','stereotype','integration','marginalized','inclusive','empowerment','solidarity','civic','brand','target audience','advertising','social media','engagement','viral','content','platform','influencer','analytics','pidgin','creole','register','pragmatics','euphemism','dysphemism','onomatopoeia','polysemy','morpheme','intonation');
