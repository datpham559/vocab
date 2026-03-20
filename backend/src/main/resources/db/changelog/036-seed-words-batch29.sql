--liquibase formatted sql

--changeset vocab:036-seed-words-batch29
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Adjectives (describing qualities)
(N'accurate', N'/ˈækjʊrɪt/', N'chính xác', N'adjective', N'INTERMEDIATE', N'Give an accurate description.', N'Đưa ra mô tả chính xác.'),
(N'aggressive', N'/əˈɡresɪv/', N'hung hăng / mạnh mẽ', N'adjective', N'INTERMEDIATE', N'Don''t be aggressive in negotiations.', N'Đừng hung hăng trong đàm phán.'),
(N'ambitious', N'/æmˈbɪʃəs/', N'tham vọng', N'adjective', N'INTERMEDIATE', N'She is ambitious and hardworking.', N'Cô ấy tham vọng và chăm chỉ.'),
(N'appropriate', N'/əˈproʊpriɪt/', N'thích hợp', N'adjective', N'INTERMEDIATE', N'Wear appropriate clothes to work.', N'Mặc quần áo thích hợp đi làm.'),
(N'authentic', N'/ɔːˈθentɪk/', N'xác thực / chân thực', N'adjective', N'INTERMEDIATE', N'Be authentic in your relationships.', N'Hãy chân thực trong các mối quan hệ.'),
(N'brilliant', N'/ˈbrɪliənt/', N'xuất sắc / sáng ngời', N'adjective', N'BEGINNER', N'She has a brilliant idea.', N'Cô ấy có một ý tưởng xuất sắc.'),
(N'cautious', N'/ˈkɔːʃəs/', N'thận trọng', N'adjective', N'INTERMEDIATE', N'Be cautious when making decisions.', N'Thận trọng khi đưa ra quyết định.'),
(N'complex', N'/ˈkɒmpleks/', N'phức tạp', N'adjective', N'INTERMEDIATE', N'The problem is more complex than expected.', N'Vấn đề phức tạp hơn dự kiến.'),
(N'comprehensive', N'/ˌkɒmprɪˈhensɪv/', N'toàn diện', N'adjective', N'INTERMEDIATE', N'Write a comprehensive report.', N'Viết một báo cáo toàn diện.'),
(N'consistent', N'/kənˈsɪstənt/', N'nhất quán', N'adjective', N'INTERMEDIATE', N'Be consistent in your efforts.', N'Nhất quán trong nỗ lực của bạn.'),
(N'constructive', N'/kənˈstrʌktɪv/', N'mang tính xây dựng', N'adjective', N'INTERMEDIATE', N'Offer constructive criticism.', N'Đưa ra lời phê bình mang tính xây dựng.'),
(N'controversial', N'/ˌkɒntrəˈvɜːrsiəl/', N'gây tranh cãi', N'adjective', N'ADVANCED', N'The policy is controversial.', N'Chính sách gây tranh cãi.'),
(N'convenient', N'/kənˈviːniənt/', N'tiện lợi', N'adjective', N'BEGINNER', N'Online shopping is very convenient.', N'Mua sắm trực tuyến rất tiện lợi.'),
(N'cooperative', N'/koʊˈɒpərətɪv/', N'hợp tác', N'adjective', N'INTERMEDIATE', N'A cooperative team achieves more.', N'Đội hợp tác đạt được nhiều hơn.'),
(N'creative', N'/kriˈeɪtɪv/', N'sáng tạo', N'adjective', N'BEGINNER', N'Be creative in your approach.', N'Hãy sáng tạo trong cách tiếp cận.'),
(N'critical', N'/ˈkrɪtɪkəl/', N'quan trọng / phê phán', N'adjective', N'INTERMEDIATE', N'Critical thinking is a key skill.', N'Tư duy phê phán là kỹ năng quan trọng.'),
(N'decisive', N'/dɪˈsaɪsɪv/', N'quyết đoán', N'adjective', N'INTERMEDIATE', N'Be decisive in tough situations.', N'Quyết đoán trong tình huống khó.'),
(N'dedicated', N'/ˈdedɪkeɪtɪd/', N'tận tụy', N'adjective', N'INTERMEDIATE', N'She is a dedicated teacher.', N'Cô ấy là giáo viên tận tụy.'),
(N'demanding', N'/dɪˈmɑːndɪŋ/', N'đòi hỏi nhiều', N'adjective', N'INTERMEDIATE', N'Teaching is a demanding job.', N'Dạy học là công việc đòi hỏi nhiều.'),
(N'dependable', N'/dɪˈpendəbəl/', N'đáng tin cậy', N'adjective', N'INTERMEDIATE', N'Choose a dependable partner.', N'Chọn người cộng tác đáng tin cậy.'),
(N'efficient', N'/ɪˈfɪʃənt/', N'hiệu quả', N'adjective', N'INTERMEDIATE', N'Use an efficient method.', N'Sử dụng phương pháp hiệu quả.'),
(N'eloquent', N'/ˈeləkwənt/', N'hùng hồn / diễn đạt tốt', N'adjective', N'ADVANCED', N'She gave an eloquent speech.', N'Cô ấy có bài phát biểu hùng hồn.'),
(N'ethical', N'/ˈeθɪkəl/', N'đạo đức', N'adjective', N'INTERMEDIATE', N'Make ethical business decisions.', N'Đưa ra quyết định kinh doanh đạo đức.'),
(N'excessive', N'/ɪkˈsesɪv/', N'quá mức', N'adjective', N'INTERMEDIATE', N'Excessive work leads to burnout.', N'Làm việc quá mức dẫn đến kiệt sức.'),
(N'explicit', N'/ɪkˈsplɪsɪt/', N'rõ ràng / tường minh', N'adjective', N'INTERMEDIATE', N'Give explicit instructions.', N'Đưa ra hướng dẫn rõ ràng.'),
(N'flexible', N'/ˈfleksɪbəl/', N'linh hoạt', N'adjective', N'BEGINNER', N'Be flexible with your schedule.', N'Linh hoạt với lịch trình của bạn.'),
(N'fundamental', N'/ˌfʌndəˈmentəl/', N'cơ bản / nền tảng', N'adjective', N'INTERMEDIATE', N'Understanding basics is fundamental.', N'Hiểu cơ bản là điều nền tảng.'),
(N'genuine', N'/ˈdʒenjuɪn/', N'chân thực / thật sự', N'adjective', N'INTERMEDIATE', N'Show genuine interest in others.', N'Thể hiện sự quan tâm chân thực đến người khác.'),
(N'idealistic', N'/aɪˌdɪəˈlɪstɪk/', N'lý tưởng hóa', N'adjective', N'ADVANCED', N'He has an idealistic view of the world.', N'Anh ấy có cái nhìn lý tưởng về thế giới.'),
(N'imaginative', N'/ɪˈmædʒɪnətɪv/', N'sáng tạo / giàu tưởng tượng', N'adjective', N'INTERMEDIATE', N'She is an imaginative writer.', N'Cô ấy là nhà văn giàu tưởng tượng.'),
(N'innovative', N'/ˈɪnəveɪtɪv/', N'đổi mới sáng tạo', N'adjective', N'INTERMEDIATE', N'The company is highly innovative.', N'Công ty rất đổi mới sáng tạo.'),
(N'insightful', N'/ɪnˈsaɪtfəl/', N'sâu sắc / thấu đáo', N'adjective', N'ADVANCED', N'She gave an insightful analysis.', N'Cô ấy đưa ra phân tích sâu sắc.'),
(N'logical', N'/ˈlɒdʒɪkəl/', N'hợp lý / có logic', N'adjective', N'INTERMEDIATE', N'Provide a logical explanation.', N'Đưa ra giải thích hợp lý.'),
(N'meticulous', N'/mɪˈtɪkjʊləs/', N'tỉ mỉ', N'adjective', N'ADVANCED', N'She is meticulous in her work.', N'Cô ấy rất tỉ mỉ trong công việc.'),
(N'modest', N'/ˈmɒdɪst/', N'khiêm tốn / vừa phải', N'adjective', N'INTERMEDIATE', N'Be modest about your achievements.', N'Khiêm tốn về thành tích của bạn.'),
(N'objective', N'/əbˈdʒektɪv/', N'khách quan', N'adjective', N'INTERMEDIATE', N'Try to be objective.', N'Hãy cố gắng khách quan.'),
(N'outgoing', N'/ˈaʊtɡoʊɪŋ/', N'hoạt bát / hướng ngoại', N'adjective', N'BEGINNER', N'She is outgoing and friendly.', N'Cô ấy hoạt bát và thân thiện.'),
(N'passionate', N'/ˈpæʃənɪt/', N'đam mê', N'adjective', N'INTERMEDIATE', N'She is passionate about teaching.', N'Cô ấy đam mê giảng dạy.'),
(N'persistent', N'/pəˈsɪstənt/', N'kiên trì', N'adjective', N'INTERMEDIATE', N'Be persistent in achieving your goals.', N'Kiên trì trong việc đạt mục tiêu.'),
(N'practical', N'/ˈpræktɪkəl/', N'thực tế / thực tiễn', N'adjective', N'INTERMEDIATE', N'Choose a practical solution.', N'Chọn giải pháp thực tế.'),
(N'proactive', N'/ˌproʊˈæktɪv/', N'chủ động', N'adjective', N'INTERMEDIATE', N'Be proactive instead of reactive.', N'Chủ động thay vì phản ứng.'),
(N'productive', N'/prəˈdʌktɪv/', N'năng suất cao', N'adjective', N'INTERMEDIATE', N'Stay productive throughout the day.', N'Duy trì năng suất cao suốt ngày.'),
(N'rational', N'/ˈræʃənəl/', N'lý trí / hợp lý', N'adjective', N'INTERMEDIATE', N'Make rational decisions under pressure.', N'Đưa ra quyết định lý trí dưới áp lực.'),
(N'reliable', N'/rɪˈlaɪəbəl/', N'đáng tin cậy', N'adjective', N'INTERMEDIATE', N'Be a reliable team member.', N'Là thành viên nhóm đáng tin cậy.'),
(N'resilient', N'/rɪˈzɪliənt/', N'kiên cường', N'adjective', N'INTERMEDIATE', N'A resilient person bounces back quickly.', N'Người kiên cường phục hồi nhanh chóng.'),
(N'resourceful', N'/rɪˈsɔːrsfəl/', N'khéo léo / tháo vát', N'adjective', N'INTERMEDIATE', N'She is resourceful and creative.', N'Cô ấy tháo vát và sáng tạo.'),
(N'responsible', N'/rɪˈspɒnsɪbəl/', N'có trách nhiệm', N'adjective', N'BEGINNER', N'Be responsible for your actions.', N'Chịu trách nhiệm về hành động của bạn.'),
(N'straightforward', N'/ˌstreɪtˈfɔːrwərd/', N'thẳng thắn / đơn giản', N'adjective', N'INTERMEDIATE', N'Give a straightforward answer.', N'Đưa ra câu trả lời thẳng thắn.'),
(N'systematic', N'/ˌsɪstəˈmætɪk/', N'có hệ thống', N'adjective', N'INTERMEDIATE', N'Use a systematic approach.', N'Dùng cách tiếp cận có hệ thống.'),
(N'versatile', N'/ˈvɜːrsətaɪl/', N'linh hoạt / đa năng', N'adjective', N'INTERMEDIATE', N'A versatile employee adapts easily.', N'Nhân viên đa năng dễ thích nghi.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('accurate','aggressive','ambitious','appropriate','authentic','brilliant','cautious','complex','comprehensive','consistent','constructive','controversial','convenient','cooperative','creative','critical','decisive','dedicated','demanding','dependable','efficient','eloquent','ethical','excessive','explicit','flexible','fundamental','genuine','idealistic','imaginative','innovative','insightful','logical','meticulous','modest','objective','outgoing','passionate','persistent','practical','proactive','productive','rational','reliable','resilient','resourceful','responsible','straightforward','systematic','versatile');
