--liquibase formatted sql

--changeset vocab:021-seed-words-batch14
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- BEGINNER: Time Expressions
(N'second', N'/ˈsekənd/', N'giây', N'noun', N'BEGINNER', N'Wait just one second.', N'Chờ một giây thôi.'),
(N'soon', N'/suːn/', N'sớm thôi', N'adverb', N'BEGINNER', N'She will arrive soon.', N'Cô ấy sẽ đến sớm thôi.'),
(N'later', N'/ˈleɪtər/', N'sau này / muộn hơn', N'adverb', N'BEGINNER', N'I''ll do it later.', N'Tôi sẽ làm sau.'),
(N'already', N'/ɔːlˈredi/', N'đã rồi', N'adverb', N'BEGINNER', N'I''ve already eaten.', N'Tôi đã ăn rồi.'),
(N'still', N'/stɪl/', N'vẫn còn', N'adverb', N'BEGINNER', N'Is he still there?', N'Anh ấy vẫn còn đó không?'),
(N'yet', N'/jet/', N'chưa / đã chưa', N'adverb', N'BEGINNER', N'Have you finished yet?', N'Bạn xong chưa?'),
(N'again', N'/əˈɡen/', N'lại / một lần nữa', N'adverb', N'BEGINNER', N'Say that again please.', N'Hãy nói lại đi.'),
(N'always', N'/ˈɔːlweɪz/', N'luôn luôn', N'adverb', N'BEGINNER', N'He always arrives on time.', N'Anh ấy luôn đến đúng giờ.'),
(N'never', N'/ˈnevər/', N'không bao giờ', N'adverb', N'BEGINNER', N'I have never been to Paris.', N'Tôi chưa bao giờ đến Paris.'),
(N'usually', N'/ˈjuːʒuəli/', N'thường thường', N'adverb', N'BEGINNER', N'I usually wake up early.', N'Tôi thường thức dậy sớm.'),
(N'sometimes', N'/ˈsʌmtaɪmz/', N'đôi khi', N'adverb', N'BEGINNER', N'Sometimes I cook at home.', N'Đôi khi tôi nấu ăn ở nhà.'),
(N'rarely', N'/ˈrerlɪ/', N'hiếm khi', N'adverb', N'BEGINNER', N'She rarely misses class.', N'Cô ấy hiếm khi nghỉ lớp.'),
(N'recently', N'/ˈriːsəntli/', N'gần đây', N'adverb', N'BEGINNER', N'I recently started exercising.', N'Gần đây tôi mới bắt đầu tập thể dục.'),
(N'immediately', N'/ɪˈmiːdiɪtli/', N'ngay lập tức', N'adverb', N'BEGINNER', N'Call me immediately.', N'Gọi cho tôi ngay lập tức.'),
(N'gradually', N'/ˈɡrædʒuəli/', N'dần dần', N'adverb', N'BEGINNER', N'He gradually improved.', N'Anh ấy dần dần tiến bộ.'),
-- BEGINNER: Question Words
(N'who', N'/huː/', N'ai', N'pronoun', N'BEGINNER', N'Who is that person?', N'Người đó là ai?'),
(N'what', N'/wɒt/', N'cái gì', N'pronoun', N'BEGINNER', N'What do you want?', N'Bạn muốn gì?'),
(N'where', N'/wer/', N'ở đâu', N'adverb', N'BEGINNER', N'Where do you live?', N'Bạn sống ở đâu?'),
(N'when', N'/wen/', N'khi nào', N'adverb', N'BEGINNER', N'When is your birthday?', N'Sinh nhật bạn là khi nào?'),
(N'why', N'/waɪ/', N'tại sao', N'adverb', N'BEGINNER', N'Why are you late?', N'Tại sao bạn trễ?'),
(N'how', N'/haʊ/', N'như thế nào', N'adverb', N'BEGINNER', N'How are you doing?', N'Bạn có khỏe không?'),
(N'how much', N'/haʊ mʌtʃ/', N'bao nhiêu (không đếm được)', N'phrase', N'BEGINNER', N'How much does it cost?', N'Cái này giá bao nhiêu?'),
(N'how many', N'/haʊ ˈmeni/', N'bao nhiêu (đếm được)', N'phrase', N'BEGINNER', N'How many people are coming?', N'Bao nhiêu người sẽ đến?'),
(N'which', N'/wɪtʃ/', N'cái nào', N'pronoun', N'BEGINNER', N'Which one do you prefer?', N'Bạn thích cái nào?'),
(N'whose', N'/huːz/', N'của ai', N'pronoun', N'BEGINNER', N'Whose bag is this?', N'Túi này của ai?'),
-- INTERMEDIATE: Abstract Verbs
(N'anticipate', N'/ænˈtɪsɪpeɪt/', N'dự đoán / trông đợi', N'verb', N'INTERMEDIATE', N'Anticipate problems before they happen.', N'Dự đoán vấn đề trước khi xảy ra.'),
(N'acknowledge', N'/əkˈnɒlɪdʒ/', N'thừa nhận', N'verb', N'INTERMEDIATE', N'Acknowledge your mistakes.', N'Hãy thừa nhận lỗi của bạn.'),
(N'distinguish', N'/dɪˈstɪŋɡwɪʃ/', N'phân biệt', N'verb', N'INTERMEDIATE', N'Distinguish between facts and opinions.', N'Phân biệt giữa sự thật và ý kiến.'),
(N'evaluate', N'/ɪˈvæljueɪt/', N'đánh giá', N'verb', N'INTERMEDIATE', N'Evaluate your progress monthly.', N'Đánh giá tiến độ hàng tháng.'),
(N'interpret', N'/ɪnˈtɜːrprɪt/', N'diễn giải', N'verb', N'INTERMEDIATE', N'Interpret the data carefully.', N'Diễn giải dữ liệu cẩn thận.'),
(N'demonstrate', N'/ˈdemənstreɪt/', N'chứng minh / thể hiện', N'verb', N'INTERMEDIATE', N'Demonstrate your skills.', N'Thể hiện kỹ năng của bạn.'),
(N'implement', N'/ˈɪmplɪment/', N'thực thi', N'verb', N'INTERMEDIATE', N'Implement the plan step by step.', N'Thực thi kế hoạch từng bước.'),
(N'incorporate', N'/ɪnˈkɔːrpəreɪt/', N'kết hợp / tích hợp', N'verb', N'INTERMEDIATE', N'Incorporate feedback into the design.', N'Tích hợp phản hồi vào thiết kế.'),
(N'integrate', N'/ˈɪntɪɡreɪt/', N'tích hợp / hội nhập', N'verb', N'INTERMEDIATE', N'Integrate the new system.', N'Tích hợp hệ thống mới.'),
(N'generate', N'/ˈdʒenəreɪt/', N'tạo ra', N'verb', N'INTERMEDIATE', N'Generate new ideas.', N'Tạo ra ý tưởng mới.'),
(N'transform', N'/trænsˈfɔːrm/', N'biến đổi', N'verb', N'INTERMEDIATE', N'Technology transforms our lives.', N'Công nghệ biến đổi cuộc sống của chúng ta.'),
(N'illustrate', N'/ˈɪləstreɪt/', N'minh họa', N'verb', N'INTERMEDIATE', N'Illustrate your point with examples.', N'Minh họa quan điểm bằng ví dụ.'),
(N'examine', N'/ɪɡˈzæmɪn/', N'kiểm tra / xem xét', N'verb', N'INTERMEDIATE', N'Examine all options.', N'Xem xét tất cả các lựa chọn.'),
(N'specify', N'/ˈspesɪfaɪ/', N'chỉ định / quy định cụ thể', N'verb', N'INTERMEDIATE', N'Specify your requirements.', N'Quy định cụ thể yêu cầu của bạn.'),
(N'justify', N'/ˈdʒʌstɪfaɪ/', N'biện minh / chứng minh', N'verb', N'INTERMEDIATE', N'Justify your decision.', N'Biện minh cho quyết định của bạn.'),
-- INTERMEDIATE: Descriptive Adjectives
(N'vivid', N'/ˈvɪvɪd/', N'sinh động / sặc sỡ', N'adjective', N'INTERMEDIATE', N'She has a vivid imagination.', N'Cô ấy có trí tưởng tượng phong phú.'),
(N'subtle', N'/ˈsʌtəl/', N'tinh tế / nhẹ nhàng', N'adjective', N'INTERMEDIATE', N'The difference is very subtle.', N'Sự khác biệt rất tinh tế.'),
(N'remarkable', N'/rɪˈmɑːrkəbəl/', N'đáng chú ý', N'adjective', N'INTERMEDIATE', N'She made remarkable progress.', N'Cô ấy đạt tiến bộ đáng chú ý.'),
(N'outstanding', N'/ˌaʊtˈstændɪŋ/', N'xuất sắc / nổi bật', N'adjective', N'INTERMEDIATE', N'His work is outstanding.', N'Công việc của anh ấy xuất sắc.'),
(N'spontaneous', N'/spɒnˈteɪniəs/', N'tự phát / ngẫu hứng', N'adjective', N'INTERMEDIATE', N'She made a spontaneous decision.', N'Cô ấy đưa ra quyết định tự phát.'),
(N'deliberate', N'/dɪˈlɪbərɪt/', N'có chủ ý / cố tình', N'adjective', N'INTERMEDIATE', N'It was a deliberate mistake.', N'Đó là lỗi cố tình.'),
(N'consistent', N'/kənˈsɪstənt/', N'nhất quán', N'adjective', N'INTERMEDIATE', N'Be consistent in your approach.', N'Hãy nhất quán trong cách tiếp cận.'),
(N'exceptional', N'/ɪkˈsepʃənəl/', N'đặc biệt / xuất chúng', N'adjective', N'INTERMEDIATE', N'She is an exceptional student.', N'Cô ấy là học sinh xuất chúng.'),
(N'genuine', N'/ˈdʒenjuɪn/', N'chân thực / thật sự', N'adjective', N'INTERMEDIATE', N'He showed genuine concern.', N'Anh ấy thể hiện sự quan tâm thật sự.'),
(N'profound', N'/prəˈfaʊnd/', N'sâu sắc', N'adjective', N'INTERMEDIATE', N'She gave a profound answer.', N'Cô ấy đưa ra câu trả lời sâu sắc.'),
-- ADVANCED: Cognitive Science
(N'neuroplasticity', N'/ˌnjʊərəʊplæˈstɪsɪti/', N'tính dẻo của thần kinh', N'noun', N'ADVANCED', N'Neuroplasticity allows the brain to change.', N'Tính dẻo thần kinh cho phép não thay đổi.'),
(N'cognitive bias', N'/ˈkɒɡnɪtɪv ˈbaɪəs/', N'thiên lệch nhận thức', N'noun', N'ADVANCED', N'We all have cognitive biases.', N'Tất cả chúng ta đều có thiên lệch nhận thức.'),
(N'heuristic', N'/hjʊˈrɪstɪk/', N'phương pháp thực nghiệm', N'noun', N'ADVANCED', N'Use heuristics to solve problems.', N'Dùng phương pháp thực nghiệm để giải quyết vấn đề.'),
(N'metacognition', N'/ˌmetəkɒɡˈnɪʃən/', N'siêu nhận thức', N'noun', N'ADVANCED', N'Metacognition is thinking about thinking.', N'Siêu nhận thức là suy nghĩ về việc suy nghĩ.'),
(N'working memory', N'/ˈwɜːrkɪŋ ˈmeməri/', N'bộ nhớ làm việc', N'noun', N'ADVANCED', N'Working memory holds temporary information.', N'Bộ nhớ làm việc lưu giữ thông tin tạm thời.'),
(N'confirmation bias', N'/ˌkɒnfɜːˈmeɪʃən ˈbaɪəs/', N'thiên lệch xác nhận', N'noun', N'ADVANCED', N'Confirmation bias makes us ignore contradicting evidence.', N'Thiên lệch xác nhận khiến chúng ta bỏ qua bằng chứng trái chiều.'),
(N'unconscious bias', N'/ʌnˈkɒnʃəs ˈbaɪəs/', N'thành kiến vô thức', N'noun', N'ADVANCED', N'Recognize and address unconscious bias.', N'Nhận ra và giải quyết thành kiến vô thức.'),
(N'placebo effect', N'/pləˈsiːboʊ ɪˈfekt/', N'hiệu ứng giả dược', N'noun', N'ADVANCED', N'The placebo effect can be powerful.', N'Hiệu ứng giả dược có thể rất mạnh.'),
(N'dopamine', N'/ˈdoʊpəmiːn/', N'dopamine (chất dẫn truyền thần kinh)', N'noun', N'ADVANCED', N'Dopamine controls reward and motivation.', N'Dopamine kiểm soát phần thưởng và động lực.'),
(N'serotonin', N'/ˌserəˈtoʊnɪn/', N'serotonin (chất tạo hạnh phúc)', N'noun', N'ADVANCED', N'Serotonin affects mood and happiness.', N'Serotonin ảnh hưởng đến tâm trạng và hạnh phúc.'),
-- ADVANCED: International Relations
(N'bilateral', N'/baɪˈlætərəl/', N'song phương', N'adjective', N'ADVANCED', N'Sign a bilateral agreement.', N'Ký hiệp định song phương.'),
(N'multilateral', N'/ˌmʌltiˈlætərəl/', N'đa phương', N'adjective', N'ADVANCED', N'Multilateral talks are needed.', N'Cần có đàm phán đa phương.'),
(N'embargo', N'/ɪmˈbɑːrɡoʊ/', N'lệnh cấm vận', N'noun', N'ADVANCED', N'The trade embargo was lifted.', N'Lệnh cấm vận thương mại đã được dỡ bỏ.'),
(N'extradition', N'/ˌekstrəˈdɪʃən/', N'dẫn độ', N'noun', N'ADVANCED', N'The suspect faced extradition.', N'Nghi phạm phải đối mặt với việc dẫn độ.'),
(N'annexation', N'/ˌænekˈseɪʃən/', N'sáp nhập lãnh thổ', N'noun', N'ADVANCED', N'The annexation was condemned.', N'Việc sáp nhập bị lên án.'),
(N'intervention', N'/ˌɪntərˈvenʃən/', N'sự can thiệp', N'noun', N'ADVANCED', N'Military intervention was avoided.', N'Việc can thiệp quân sự đã được tránh.'),
(N'veto', N'/ˈviːtoʊ/', N'quyền phủ quyết', N'noun', N'ADVANCED', N'The country used its veto.', N'Đất nước đó đã dùng quyền phủ quyết.'),
(N'ceasefire', N'/ˈsiːsfaɪər/', N'ngừng bắn', N'noun', N'ADVANCED', N'Both sides agreed to a ceasefire.', N'Cả hai bên đồng ý ngừng bắn.'),
(N'deterrence', N'/dɪˈterəns/', N'sức răn đe', N'noun', N'ADVANCED', N'Nuclear deterrence prevents war.', N'Sức răn đe hạt nhân ngăn chiến tranh.'),
(N'geopolitical', N'/ˌdʒiːoʊpəˈlɪtɪkəl/', N'địa chính trị', N'adjective', N'ADVANCED', N'Geopolitical tensions are rising.', N'Căng thẳng địa chính trị đang leo thang.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('second','soon','later','already','still','yet','again','always','never','usually','sometimes','rarely','recently','immediately','gradually','who','what','where','when','why','how','how much','how many','which','whose','anticipate','acknowledge','distinguish','evaluate','interpret','demonstrate','implement','incorporate','integrate','generate','transform','illustrate','examine','specify','justify','vivid','subtle','remarkable','outstanding','spontaneous','deliberate','consistent','exceptional','genuine','profound','neuroplasticity','cognitive bias','heuristic','metacognition','working memory','confirmation bias','unconscious bias','placebo effect','dopamine','serotonin','bilateral','multilateral','embargo','extradition','annexation','intervention','veto','ceasefire','deterrence','geopolitical');
