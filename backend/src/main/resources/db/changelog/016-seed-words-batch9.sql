--liquibase formatted sql

--changeset vocab:016-seed-words-batch9
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- INTERMEDIATE: Verbs (common actions)
(N'accept', N'/əkˈsept/', N'chấp nhận', N'verb', N'INTERMEDIATE', N'Please accept my apology.', N'Xin hãy chấp nhận lời xin lỗi của tôi.'),
(N'refuse', N'/rɪˈfjuːz/', N'từ chối', N'verb', N'INTERMEDIATE', N'She refused the offer.', N'Cô ấy từ chối lời đề nghị.'),
(N'agree', N'/əˈɡriː/', N'đồng ý', N'verb', N'INTERMEDIATE', N'I agree with your point.', N'Tôi đồng ý với quan điểm của bạn.'),
(N'disagree', N'/ˌdɪsəˈɡriː/', N'không đồng ý', N'verb', N'INTERMEDIATE', N'I disagree with this decision.', N'Tôi không đồng ý với quyết định này.'),
(N'suggest', N'/səˈdʒest/', N'đề xuất / gợi ý', N'verb', N'INTERMEDIATE', N'I suggest we start early.', N'Tôi đề xuất chúng ta bắt đầu sớm.'),
(N'recommend', N'/ˌrekəˈmend/', N'khuyến nghị', N'verb', N'INTERMEDIATE', N'I recommend this restaurant.', N'Tôi giới thiệu nhà hàng này.'),
(N'request', N'/rɪˈkwest/', N'yêu cầu / đề nghị', N'verb', N'INTERMEDIATE', N'I request your approval.', N'Tôi yêu cầu sự phê duyệt của bạn.'),
(N'demand', N'/dɪˈmɑːnd/', N'đòi hỏi / yêu cầu', N'verb', N'INTERMEDIATE', N'They demanded a refund.', N'Họ yêu cầu hoàn tiền.'),
(N'confirm', N'/kənˈfɜːrm/', N'xác nhận', N'verb', N'INTERMEDIATE', N'Confirm your booking by email.', N'Xác nhận đặt chỗ qua email.'),
(N'cancel', N'/ˈkænsəl/', N'hủy bỏ', N'verb', N'INTERMEDIATE', N'Cancel the reservation if needed.', N'Hủy đặt chỗ nếu cần.'),
(N'postpone', N'/poʊstˈpoʊn/', N'hoãn lại', N'verb', N'INTERMEDIATE', N'The meeting was postponed.', N'Cuộc họp đã bị hoãn.'),
(N'arrange', N'/əˈreɪndʒ/', N'sắp xếp', N'verb', N'INTERMEDIATE', N'Arrange a meeting for next week.', N'Sắp xếp một cuộc họp cho tuần tới.'),
(N'manage', N'/ˈmænɪdʒ/', N'quản lý', N'verb', N'INTERMEDIATE', N'She manages the team well.', N'Cô ấy quản lý nhóm tốt.'),
(N'control', N'/kənˈtroʊl/', N'kiểm soát', N'verb', N'INTERMEDIATE', N'Control your emotions in difficult times.', N'Kiểm soát cảm xúc trong lúc khó khăn.'),
(N'handle', N'/ˈhændəl/', N'xử lý', N'verb', N'INTERMEDIATE', N'How do you handle stress?', N'Bạn xử lý căng thẳng như thế nào?'),
(N'solve', N'/sɒlv/', N'giải quyết', N'verb', N'INTERMEDIATE', N'Solve the problem quickly.', N'Giải quyết vấn đề nhanh chóng.'),
(N'develop', N'/dɪˈveləp/', N'phát triển', N'verb', N'INTERMEDIATE', N'Develop your skills continuously.', N'Phát triển kỹ năng liên tục.'),
(N'improve', N'/ɪmˈpruːv/', N'cải thiện', N'verb', N'INTERMEDIATE', N'Improve your English every day.', N'Cải thiện tiếng Anh mỗi ngày.'),
(N'maintain', N'/meɪnˈteɪn/', N'duy trì', N'verb', N'INTERMEDIATE', N'Maintain a healthy lifestyle.', N'Duy trì lối sống lành mạnh.'),
(N'achieve', N'/əˈtʃiːv/', N'đạt được', N'verb', N'INTERMEDIATE', N'You can achieve anything you want.', N'Bạn có thể đạt được bất cứ điều gì bạn muốn.'),
-- INTERMEDIATE: Adjectives (describing quality)
(N'accurate', N'/ˈækjərɪt/', N'chính xác', N'adjective', N'INTERMEDIATE', N'The report is accurate.', N'Báo cáo chính xác.'),
(N'precise', N'/prɪˈsaɪs/', N'chính xác (chi tiết)', N'adjective', N'INTERMEDIATE', N'Be precise in your measurements.', N'Hãy chính xác trong việc đo lường.'),
(N'relevant', N'/ˈreləvənt/', N'có liên quan / phù hợp', N'adjective', N'INTERMEDIATE', N'Provide relevant information only.', N'Chỉ cung cấp thông tin có liên quan.'),
(N'significant', N'/sɪɡˈnɪfɪkənt/', N'quan trọng / đáng kể', N'adjective', N'INTERMEDIATE', N'This is a significant change.', N'Đây là sự thay đổi đáng kể.'),
(N'obvious', N'/ˈɒbviəs/', N'rõ ràng', N'adjective', N'INTERMEDIATE', N'The answer is obvious.', N'Câu trả lời rõ ràng.'),
(N'complex', N'/ˈkɒmpleks/', N'phức tạp', N'adjective', N'INTERMEDIATE', N'The problem is complex.', N'Vấn đề phức tạp.'),
(N'comprehensive', N'/ˌkɒmprɪˈhensɪv/', N'toàn diện', N'adjective', N'INTERMEDIATE', N'A comprehensive report is needed.', N'Cần có một báo cáo toàn diện.'),
(N'sufficient', N'/səˈfɪʃənt/', N'đủ', N'adjective', N'INTERMEDIATE', N'Is the amount sufficient?', N'Số lượng có đủ không?'),
(N'appropriate', N'/əˈproʊpriɪt/', N'phù hợp', N'adjective', N'INTERMEDIATE', N'Dress appropriately for the interview.', N'Ăn mặc phù hợp cho buổi phỏng vấn.'),
(N'effective', N'/ɪˈfektɪv/', N'hiệu quả', N'adjective', N'INTERMEDIATE', N'Find an effective solution.', N'Tìm giải pháp hiệu quả.'),
-- BEGINNER: Common Verbs 2
(N'come', N'/kʌm/', N'đến', N'verb', N'BEGINNER', N'Please come inside.', N'Vào trong đi.'),
(N'go', N'/ɡoʊ/', N'đi', N'verb', N'BEGINNER', N'Let''s go to the park.', N'Hãy đi đến công viên.'),
(N'make', N'/meɪk/', N'làm / tạo ra', N'verb', N'BEGINNER', N'Make a cup of tea for me.', N'Pha cho tôi tách trà.'),
(N'do', N'/duː/', N'làm (hành động)', N'verb', N'BEGINNER', N'What are you doing?', N'Bạn đang làm gì vậy?'),
(N'get', N'/ɡet/', N'lấy / nhận / trở nên', N'verb', N'BEGINNER', N'Get some rest tonight.', N'Nghỉ ngơi tối nay nhé.'),
(N'have', N'/hæv/', N'có / ăn', N'verb', N'BEGINNER', N'Do you have a pen?', N'Bạn có bút không?'),
(N'say', N'/seɪ/', N'nói', N'verb', N'BEGINNER', N'What did she say?', N'Cô ấy nói gì vậy?'),
(N'tell', N'/tel/', N'kể / nói cho biết', N'verb', N'BEGINNER', N'Tell me the truth.', N'Hãy nói thật với tôi.'),
(N'ask', N'/æsk/', N'hỏi', N'verb', N'BEGINNER', N'Ask the teacher if you have questions.', N'Hỏi giáo viên nếu bạn có thắc mắc.'),
(N'answer', N'/ˈænsər/', N'trả lời', N'verb', N'BEGINNER', N'Answer the question please.', N'Hãy trả lời câu hỏi.'),
(N'call', N'/kɔːl/', N'gọi điện / gọi tên', N'verb', N'BEGINNER', N'Call me when you arrive.', N'Gọi cho tôi khi bạn đến.'),
(N'show', N'/ʃoʊ/', N'cho xem / hiện ra', N'verb', N'BEGINNER', N'Show me your homework.', N'Cho tôi xem bài tập về nhà.'),
(N'bring', N'/brɪŋ/', N'mang đến', N'verb', N'BEGINNER', N'Bring your ID card.', N'Mang theo thẻ căn cước.'),
(N'send', N'/send/', N'gửi', N'verb', N'BEGINNER', N'Send me the document.', N'Gửi cho tôi tài liệu đó.'),
(N'receive', N'/rɪˈsiːv/', N'nhận', N'verb', N'BEGINNER', N'Did you receive my email?', N'Bạn có nhận được email của tôi không?'),
-- ADVANCED: Global Issues
(N'globalization', N'/ˌɡloʊbəlaɪˈzeɪʃən/', N'toàn cầu hóa', N'noun', N'ADVANCED', N'Globalization connects the world.', N'Toàn cầu hóa kết nối thế giới.'),
(N'migration', N'/maɪˈɡreɪʃən/', N'di cư', N'noun', N'ADVANCED', N'Migration affects labor markets.', N'Di cư ảnh hưởng đến thị trường lao động.'),
(N'refugee', N'/ˌrefjuˈdʒiː/', N'người tị nạn', N'noun', N'ADVANCED', N'Provide shelter for refugees.', N'Cung cấp nơi trú ẩn cho người tị nạn.'),
(N'diplomacy', N'/dɪˈploʊməsi/', N'ngoại giao', N'noun', N'ADVANCED', N'Diplomacy resolves conflicts peacefully.', N'Ngoại giao giải quyết xung đột một cách hòa bình.'),
(N'treaty', N'/ˈtriːti/', N'hiệp ước', N'noun', N'ADVANCED', N'Both nations signed the treaty.', N'Cả hai quốc gia đã ký hiệp ước.'),
(N'sanctions', N'/ˈsæŋkʃənz/', N'các biện pháp trừng phạt', N'noun', N'ADVANCED', N'Economic sanctions were imposed.', N'Các biện pháp trừng phạt kinh tế đã được áp đặt.'),
(N'sovereignty', N'/ˈsɒvrənti/', N'chủ quyền quốc gia', N'noun', N'ADVANCED', N'Protect national sovereignty.', N'Bảo vệ chủ quyền quốc gia.'),
(N'humanitarian', N'/hjuːˌmænɪˈteriən/', N'nhân đạo', N'adjective', N'ADVANCED', N'Provide humanitarian aid immediately.', N'Cung cấp viện trợ nhân đạo ngay lập tức.'),
(N'indigenous', N'/ɪnˈdɪdʒɪnəs/', N'bản địa', N'adjective', N'ADVANCED', N'Protect indigenous peoples'' rights.', N'Bảo vệ quyền của người bản địa.'),
(N'proliferation', N'/prəˌlɪfərˈeɪʃən/', N'sự phổ biến / nhân rộng', N'noun', N'ADVANCED', N'Prevent nuclear proliferation.', N'Ngăn chặn phổ biến vũ khí hạt nhân.'),
-- ADVANCED: Medicine & Biology
(N'diagnosis', N'/ˌdaɪəɡˈnoʊsɪs/', N'chẩn đoán bệnh', N'noun', N'ADVANCED', N'The diagnosis was confirmed.', N'Chẩn đoán đã được xác nhận.'),
(N'prognosis', N'/prɒɡˈnoʊsɪs/', N'tiên lượng bệnh', N'noun', N'ADVANCED', N'The prognosis is positive.', N'Tiên lượng bệnh tích cực.'),
(N'rehabilitation', N'/ˌriːhəˌbɪlɪˈteɪʃən/', N'phục hồi chức năng', N'noun', N'ADVANCED', N'Physical rehabilitation takes time.', N'Phục hồi chức năng mất thời gian.'),
(N'chromosome', N'/ˈkroʊməsoʊm/', N'nhiễm sắc thể', N'noun', N'ADVANCED', N'Humans have 46 chromosomes.', N'Con người có 46 nhiễm sắc thể.'),
(N'antibody', N'/ˈæntɪbɒdi/', N'kháng thể', N'noun', N'ADVANCED', N'Antibodies fight infections.', N'Kháng thể chống lại nhiễm trùng.'),
(N'vaccination', N'/ˌvæksɪˈneɪʃən/', N'tiêm vắc-xin', N'noun', N'ADVANCED', N'Vaccination prevents disease spread.', N'Tiêm vắc-xin ngăn bệnh lây lan.'),
(N'pathology', N'/pəˈθɒlədʒi/', N'bệnh lý học', N'noun', N'ADVANCED', N'Pathology identifies disease causes.', N'Bệnh lý học xác định nguyên nhân bệnh.'),
(N'therapeutic', N'/ˌθerəˈpjuːtɪk/', N'có tính trị liệu', N'adjective', N'ADVANCED', N'Therapeutic massage relieves pain.', N'Massage trị liệu giảm đau.'),
(N'contagious', N'/kənˈteɪdʒəs/', N'lây nhiễm', N'adjective', N'ADVANCED', N'The disease is highly contagious.', N'Bệnh lây lan rất mạnh.'),
(N'susceptible', N'/səˈseptɪbəl/', N'dễ bị ảnh hưởng', N'adjective', N'ADVANCED', N'Children are susceptible to the flu.', N'Trẻ em dễ bị nhiễm cúm.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('accept','refuse','agree','disagree','suggest','recommend','request','demand','confirm','cancel','postpone','arrange','manage','control','handle','solve','develop','improve','maintain','achieve','accurate','precise','relevant','significant','obvious','complex','comprehensive','sufficient','appropriate','effective','come','go','make','do','get','have','say','tell','ask','answer','call','show','bring','send','receive','globalization','migration','refugee','diplomacy','treaty','sanctions','sovereignty','humanitarian','indigenous','proliferation','diagnosis','prognosis','rehabilitation','chromosome','antibody','vaccination','pathology','therapeutic','contagious','susceptible');
