--liquibase formatted sql

--changeset vocab:014-seed-words-batch7
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- BEGINNER: Numbers & Math
(N'number', N'/ˈnʌmbər/', N'con số', N'noun', N'BEGINNER', N'Write down the number.', N'Viết con số xuống.'),
(N'count', N'/kaʊnt/', N'đếm', N'verb', N'BEGINNER', N'Count from one to ten.', N'Đếm từ một đến mười.'),
(N'add', N'/æd/', N'cộng / thêm', N'verb', N'BEGINNER', N'Add these numbers together.', N'Cộng các con số này lại.'),
(N'subtract', N'/səbˈtrækt/', N'trừ', N'verb', N'BEGINNER', N'Subtract 5 from 10.', N'Trừ 5 cho 10.'),
(N'multiply', N'/ˈmʌltɪplaɪ/', N'nhân', N'verb', N'BEGINNER', N'Multiply 3 by 4.', N'Nhân 3 với 4.'),
(N'divide', N'/dɪˈvaɪd/', N'chia', N'verb', N'BEGINNER', N'Divide 20 by 4.', N'Chia 20 cho 4.'),
(N'half', N'/hɑːf/', N'một nửa', N'noun', N'BEGINNER', N'Cut it in half.', N'Cắt nó làm đôi.'),
(N'quarter', N'/ˈkwɔːrtər/', N'một phần tư', N'noun', N'BEGINNER', N'A quarter of the pie is left.', N'Còn lại một phần tư cái bánh.'),
(N'double', N'/ˈdʌbəl/', N'gấp đôi', N'adjective', N'BEGINNER', N'The price doubled this year.', N'Giá đã tăng gấp đôi năm nay.'),
(N'total', N'/ˈtoʊtəl/', N'tổng số', N'noun', N'BEGINNER', N'What is the total cost?', N'Tổng chi phí là bao nhiêu?'),
-- BEGINNER: Directions & Location
(N'here', N'/hɪr/', N'ở đây', N'adverb', N'BEGINNER', N'Come here please.', N'Lại đây đi.'),
(N'there', N'/ðer/', N'ở đó / ở kia', N'adverb', N'BEGINNER', N'Look over there.', N'Nhìn sang kia kìa.'),
(N'north', N'/nɔːrθ/', N'phía bắc', N'noun', N'BEGINNER', N'Drive north for 5 miles.', N'Lái xe về phía bắc 5 dặm.'),
(N'south', N'/saʊθ/', N'phía nam', N'noun', N'BEGINNER', N'The beach is to the south.', N'Bãi biển ở phía nam.'),
(N'east', N'/iːst/', N'phía đông', N'noun', N'BEGINNER', N'The sun rises in the east.', N'Mặt trời mọc ở phía đông.'),
(N'west', N'/west/', N'phía tây', N'noun', N'BEGINNER', N'They traveled west.', N'Họ đi về phía tây.'),
(N'left', N'/left/', N'bên trái', N'adjective', N'BEGINNER', N'Turn left at the traffic light.', N'Rẽ trái tại đèn giao thông.'),
(N'right', N'/raɪt/', N'bên phải', N'adjective', N'BEGINNER', N'Turn right at the corner.', N'Rẽ phải ở góc đường.'),
(N'up', N'/ʌp/', N'lên / ở trên', N'adverb', N'BEGINNER', N'Go up the stairs.', N'Đi lên cầu thang.'),
(N'down', N'/daʊn/', N'xuống / ở dưới', N'adverb', N'BEGINNER', N'Come down from the tree.', N'Xuống cây đi.'),
(N'front', N'/frʌnt/', N'phía trước', N'noun', N'BEGINNER', N'Wait in front of the building.', N'Chờ trước tòa nhà.'),
(N'behind', N'/bɪˈhaɪnd/', N'phía sau', N'preposition', N'BEGINNER', N'Stand behind the line.', N'Đứng sau vạch kẻ.'),
(N'inside', N'/ˈɪnsaɪd/', N'bên trong', N'preposition', N'BEGINNER', N'Wait inside the building.', N'Chờ bên trong tòa nhà.'),
(N'outside', N'/ˈaʊtsaɪd/', N'bên ngoài', N'preposition', N'BEGINNER', N'Play outside after school.', N'Chơi ngoài trời sau giờ học.'),
(N'near', N'/nɪr/', N'gần', N'preposition', N'BEGINNER', N'The store is near here.', N'Cửa hàng ở gần đây.'),
(N'far', N'/fɑːr/', N'xa', N'adjective', N'BEGINNER', N'The hospital is not far.', N'Bệnh viện không xa.'),
-- INTERMEDIATE: Communication
(N'communicate', N'/kəˈmjuːnɪkeɪt/', N'giao tiếp', N'verb', N'INTERMEDIATE', N'Communicate clearly and effectively.', N'Giao tiếp rõ ràng và hiệu quả.'),
(N'negotiation', N'/nɪˌɡoʊʃiˈeɪʃən/', N'đàm phán', N'noun', N'INTERMEDIATE', N'Negotiation requires patience.', N'Đàm phán đòi hỏi sự kiên nhẫn.'),
(N'presentation', N'/ˌprezənˈteɪʃən/', N'bài thuyết trình', N'noun', N'INTERMEDIATE', N'Give a presentation to the team.', N'Thuyết trình trước nhóm.'),
(N'feedback', N'/ˈfiːdbæk/', N'phản hồi', N'noun', N'INTERMEDIATE', N'Give constructive feedback.', N'Đưa ra phản hồi mang tính xây dựng.'),
(N'broadcast', N'/ˈbrɔːdkæst/', N'phát sóng', N'verb', N'INTERMEDIATE', N'The news will be broadcast at 7.', N'Tin tức sẽ được phát sóng lúc 7 giờ.'),
(N'translate', N'/trænsˈleɪt/', N'dịch thuật', N'verb', N'INTERMEDIATE', N'Translate this into Vietnamese.', N'Dịch cái này sang tiếng Việt.'),
(N'interpret', N'/ɪnˈtɜːrprɪt/', N'diễn giải / thông dịch', N'verb', N'INTERMEDIATE', N'He interpreted the speech.', N'Anh ấy thông dịch bài phát biểu.'),
(N'publish', N'/ˈpʌblɪʃ/', N'xuất bản', N'verb', N'INTERMEDIATE', N'She published her first book.', N'Cô ấy xuất bản cuốn sách đầu tiên.'),
(N'journalism', N'/ˈdʒɜːrnəlɪzəm/', N'báo chí', N'noun', N'INTERMEDIATE', N'She studied journalism at university.', N'Cô ấy học báo chí ở đại học.'),
(N'editorial', N'/ˌedɪˈtɔːriəl/', N'bài xã luận / biên tập', N'noun', N'INTERMEDIATE', N'Read the editorial in the newspaper.', N'Đọc bài xã luận trên báo.'),
(N'persuade', N'/pərˈsweɪd/', N'thuyết phục', N'verb', N'INTERMEDIATE', N'She persuaded him to join.', N'Cô ấy thuyết phục anh ấy tham gia.'),
(N'convince', N'/kənˈvɪns/', N'thuyết phục (tin tưởng)', N'verb', N'INTERMEDIATE', N'Convince your boss with facts.', N'Thuyết phục sếp bằng sự thật.'),
(N'emphasize', N'/ˈemfəsaɪz/', N'nhấn mạnh', N'verb', N'INTERMEDIATE', N'The teacher emphasized the key points.', N'Giáo viên nhấn mạnh các điểm quan trọng.'),
(N'summarize', N'/ˈsʌməraɪz/', N'tóm tắt', N'verb', N'INTERMEDIATE', N'Summarize the main ideas.', N'Tóm tắt các ý chính.'),
(N'verbal', N'/ˈvɜːrbəl/', N'bằng lời nói / ngôn ngữ', N'adjective', N'INTERMEDIATE', N'Verbal communication is essential.', N'Giao tiếp bằng lời nói rất quan trọng.'),
-- INTERMEDIATE: Personality & Character
(N'ambitious', N'/æmˈbɪʃəs/', N'có tham vọng', N'adjective', N'INTERMEDIATE', N'She is ambitious and hardworking.', N'Cô ấy có tham vọng và chăm chỉ.'),
(N'determined', N'/dɪˈtɜːrmɪnd/', N'quyết tâm', N'adjective', N'INTERMEDIATE', N'He is determined to succeed.', N'Anh ấy quyết tâm thành công.'),
(N'humble', N'/ˈhʌmbəl/', N'khiêm tốn', N'adjective', N'INTERMEDIATE', N'Stay humble despite your success.', N'Hãy khiêm tốn dù thành công.'),
(N'reliable', N'/rɪˈlaɪəbəl/', N'đáng tin cậy', N'adjective', N'INTERMEDIATE', N'She is a reliable employee.', N'Cô ấy là nhân viên đáng tin cậy.'),
(N'flexible', N'/ˈfleksɪbəl/', N'linh hoạt', N'adjective', N'INTERMEDIATE', N'Be flexible with your schedule.', N'Hãy linh hoạt với lịch trình của bạn.'),
(N'adaptable', N'/əˈdæptəbəl/', N'có khả năng thích nghi', N'adjective', N'INTERMEDIATE', N'Be adaptable to changes.', N'Hãy thích nghi với những thay đổi.'),
(N'innovative', N'/ˈɪnəveɪtɪv/', N'sáng tạo / đổi mới', N'adjective', N'INTERMEDIATE', N'We need innovative solutions.', N'Chúng ta cần các giải pháp đổi mới.'),
(N'tolerant', N'/ˈtɒlərənt/', N'khoan dung / bao dung', N'adjective', N'INTERMEDIATE', N'Be tolerant of different opinions.', N'Hãy khoan dung với những quan điểm khác nhau.'),
(N'diligent', N'/ˈdɪlɪdʒənt/', N'cần mẫn / chăm chỉ', N'adjective', N'INTERMEDIATE', N'Diligent students get better grades.', N'Học sinh chăm chỉ đạt điểm tốt hơn.'),
(N'straightforward', N'/ˌstreɪtˈfɔːrwərd/', N'thẳng thắn / đơn giản', N'adjective', N'INTERMEDIATE', N'He is always straightforward.', N'Anh ấy luôn thẳng thắn.'),
-- ADVANCED: Linguistics & Language
(N'linguistics', N'/lɪŋˈɡwɪstɪks/', N'ngôn ngữ học', N'noun', N'ADVANCED', N'He studies linguistics at university.', N'Anh ấy học ngôn ngữ học ở đại học.'),
(N'syntax', N'/ˈsɪntæks/', N'cú pháp', N'noun', N'ADVANCED', N'English syntax differs from Vietnamese.', N'Cú pháp tiếng Anh khác tiếng Việt.'),
(N'semantics', N'/sɪˈmæntɪks/', N'ngữ nghĩa học', N'noun', N'ADVANCED', N'Semantics studies word meaning.', N'Ngữ nghĩa học nghiên cứu ý nghĩa từ.'),
(N'phonology', N'/fəˈnɒlədʒi/', N'âm vị học', N'noun', N'ADVANCED', N'Phonology studies sound patterns.', N'Âm vị học nghiên cứu các mẫu âm thanh.'),
(N'morphology', N'/mɔːrˈfɒlədʒi/', N'hình thái học', N'noun', N'ADVANCED', N'Morphology studies word structure.', N'Hình thái học nghiên cứu cấu trúc từ.'),
(N'dialect', N'/ˈdaɪəlekt/', N'phương ngữ', N'noun', N'ADVANCED', N'Many dialects exist in China.', N'Nhiều phương ngữ tồn tại ở Trung Quốc.'),
(N'bilingual', N'/baɪˈlɪŋɡwəl/', N'song ngữ', N'adjective', N'ADVANCED', N'She is bilingual in English and French.', N'Cô ấy nói được cả tiếng Anh và Pháp.'),
(N'fluent', N'/ˈfluːənt/', N'thành thạo (ngoại ngữ)', N'adjective', N'ADVANCED', N'He is fluent in four languages.', N'Anh ấy thành thạo bốn ngôn ngữ.'),
(N'eloquent', N'/ˈeləkwənt/', N'hùng biện / lưu loát', N'adjective', N'ADVANCED', N'She gave an eloquent speech.', N'Cô ấy đã có bài phát biểu hùng hồn.'),
(N'articulate', N'/ɑːrˈtɪkjʊlɪt/', N'diễn đạt rõ ràng', N'adjective', N'ADVANCED', N'He is very articulate in debates.', N'Anh ấy diễn đạt rất rõ ràng trong các cuộc tranh luận.'),
-- ADVANCED: Psychology
(N'cognitive', N'/ˈkɒɡnɪtɪv/', N'nhận thức (thuộc)', N'adjective', N'ADVANCED', N'Cognitive skills improve with practice.', N'Kỹ năng nhận thức cải thiện theo thời gian.'),
(N'subconscious', N'/ˌsʌbˈkɒnʃəs/', N'tiềm thức', N'noun', N'ADVANCED', N'The subconscious affects our behavior.', N'Tiềm thức ảnh hưởng đến hành vi của chúng ta.'),
(N'resilience', N'/rɪˈzɪliəns/', N'sức bật / khả năng phục hồi', N'noun', N'ADVANCED', N'Resilience helps cope with adversity.', N'Khả năng phục hồi giúp đối phó với nghịch cảnh.'),
(N'empathy', N'/ˈempəθi/', N'sự đồng cảm', N'noun', N'ADVANCED', N'Empathy makes us better listeners.', N'Đồng cảm giúp chúng ta lắng nghe tốt hơn.'),
(N'intuition', N'/ˌɪntjuˈɪʃən/', N'trực giác', N'noun', N'ADVANCED', N'Trust your intuition sometimes.', N'Đôi khi hãy tin vào trực giác của bạn.'),
(N'compulsive', N'/kəmˈpʌlsɪv/', N'bộc phát không kiểm soát được', N'adjective', N'ADVANCED', N'He has compulsive tendencies.', N'Anh ấy có xu hướng hành động bộc phát.'),
(N'irrational', N'/ɪˈræʃənəl/', N'phi lý', N'adjective', N'ADVANCED', N'Fear can make people irrational.', N'Sợ hãi có thể khiến người ta hành động phi lý.'),
(N'procrastinate', N'/prəˈkræstɪneɪt/', N'trì hoãn', N'verb', N'ADVANCED', N'Don''t procrastinate important tasks.', N'Đừng trì hoãn những công việc quan trọng.'),
(N'obsession', N'/əbˈseʃən/', N'nỗi ám ảnh', N'noun', N'ADVANCED', N'His obsession with work is unhealthy.', N'Nỗi ám ảnh với công việc là không lành mạnh.'),
(N'introspection', N'/ˌɪntrəˈspekʃən/', N'tự xét bản thân', N'noun', N'ADVANCED', N'Introspection leads to self-awareness.', N'Tự xét bản thân dẫn đến nhận thức về bản thân.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('number','count','add','subtract','multiply','divide','half','quarter','double','total','here','there','north','south','east','west','left','right','up','down','front','behind','inside','outside','near','far','communicate','negotiation','presentation','feedback','broadcast','translate','interpret','publish','journalism','editorial','persuade','convince','emphasize','summarize','verbal','ambitious','determined','humble','reliable','flexible','adaptable','innovative','tolerant','diligent','straightforward','linguistics','syntax','semantics','phonology','morphology','dialect','bilingual','fluent','eloquent','articulate','cognitive','subconscious','resilience','empathy','intuition','compulsive','irrational','procrastinate','obsession','introspection');
