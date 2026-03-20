--liquibase formatted sql

--changeset vocab:044-seed-words-batch37
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Advanced Vocabulary (IELTS/TOEFL level)
(N'aberrant', N'/æˈberənt/', N'lệch lạc / bất thường', N'adjective', N'ADVANCED', N'The aberrant behavior raised concerns.', N'Hành vi lệch lạc làm dấy lên lo ngại.'),
(N'abide', N'/əˈbaɪd/', N'tuân theo / chịu đựng', N'verb', N'ADVANCED', N'Abide by the rules at all times.', N'Luôn tuân theo các quy tắc.'),
(N'abridge', N'/əˈbrɪdʒ/', N'rút ngắn / tóm tắt', N'verb', N'ADVANCED', N'The editor abridged the long novel.', N'Biên tập viên rút gọn cuốn tiểu thuyết dài.'),
(N'abstain', N'/əbˈsteɪn/', N'kiêng / từ chối tham gia', N'verb', N'ADVANCED', N'Abstain from alcohol for better health.', N'Kiêng rượu để có sức khỏe tốt hơn.'),
(N'acrimony', N'/ˈækrɪməni/', N'sự cay đắng / thù hận', N'noun', N'ADVANCED', N'The divorce was full of acrimony.', N'Vụ ly hôn đầy sự cay đắng.'),
(N'adroit', N'/əˈdrɔɪt/', N'khéo léo', N'adjective', N'ADVANCED', N'She is adroit at handling conflicts.', N'Cô ấy khéo léo trong việc xử lý mâu thuẫn.'),
(N'affable', N'/ˈæfəbəl/', N'thân thiện / dễ gần', N'adjective', N'ADVANCED', N'He is affable and easy to talk to.', N'Anh ấy thân thiện và dễ nói chuyện.'),
(N'alleviate', N'/əˈliːvieɪt/', N'giảm nhẹ', N'verb', N'ADVANCED', N'Exercise can alleviate depression.', N'Tập thể dục có thể giảm nhẹ trầm cảm.'),
(N'aloof', N'/əˈluːf/', N'xa cách / lạnh lùng', N'adjective', N'ADVANCED', N'He remained aloof during the debate.', N'Anh ấy vẫn xa cách trong suốt buổi tranh luận.'),
(N'ambiguous', N'/æmˈbɪɡjuəs/', N'mơ hồ', N'adjective', N'ADVANCED', N'The contract terms were ambiguous.', N'Các điều khoản hợp đồng mơ hồ.'),
(N'ameliorate', N'/əˈmiːliəreɪt/', N'cải thiện', N'verb', N'ADVANCED', N'We must ameliorate the situation.', N'Chúng ta phải cải thiện tình huống.'),
(N'amiable', N'/ˈeɪmiəbəl/', N'thân ái / dễ mến', N'adjective', N'ADVANCED', N'She has an amiable personality.', N'Cô ấy có tính cách dễ mến.'),
(N'anomalous', N'/əˈnɒmələs/', N'bất thường', N'adjective', N'ADVANCED', N'The anomalous result needed review.', N'Kết quả bất thường cần được xem xét.'),
(N'antipathy', N'/ænˈtɪpəθi/', N'sự phản cảm / ghét', N'noun', N'ADVANCED', N'He felt antipathy toward dishonesty.', N'Anh ấy cảm thấy phản cảm với sự không trung thực.'),
(N'apprehension', N'/ˌæprɪˈhenʃən/', N'sự lo sợ', N'noun', N'ADVANCED', N'She felt apprehension before the speech.', N'Cô ấy cảm thấy lo sợ trước bài phát biểu.'),
(N'apt', N'/æpt/', N'thích hợp / có khả năng', N'adjective', N'ADVANCED', N'That is an apt description.', N'Đó là mô tả thích hợp.'),
(N'arduous', N'/ˈɑːrdjuəs/', N'gian khổ / cực nhọc', N'adjective', N'ADVANCED', N'The journey was long and arduous.', N'Cuộc hành trình dài và gian khổ.'),
(N'articulate', N'/ɑːrˈtɪkjʊlɪt/', N'diễn đạt rõ ràng', N'adjective', N'ADVANCED', N'She is articulate and persuasive.', N'Cô ấy diễn đạt rõ ràng và thuyết phục.'),
(N'ascertain', N'/ˌæsərˈteɪn/', N'xác định / tìm hiểu', N'verb', N'ADVANCED', N'Ascertain the facts before concluding.', N'Xác định sự kiện trước khi kết luận.'),
(N'astute', N'/əˈstjuːt/', N'sắc sảo / tinh khôn', N'adjective', N'ADVANCED', N'He made an astute business decision.', N'Anh ấy đưa ra quyết định kinh doanh sắc sảo.'),
(N'atrocity', N'/əˈtrɒsɪti/', N'hành động tàn ác', N'noun', N'ADVANCED', N'War crimes are atrocities.', N'Tội ác chiến tranh là hành động tàn ác.'),
(N'audacious', N'/ɔːˈdeɪʃəs/', N'táo bạo', N'adjective', N'ADVANCED', N'Her audacious plan surprised everyone.', N'Kế hoạch táo bạo của cô ấy làm mọi người ngạc nhiên.'),
(N'augment', N'/ɔːɡˈment/', N'tăng cường / bổ sung', N'verb', N'ADVANCED', N'Augment your skills with training.', N'Tăng cường kỹ năng của bạn bằng đào tạo.'),
(N'avert', N'/əˈvɜːrt/', N'ngăn chặn / né tránh', N'verb', N'ADVANCED', N'Avert a crisis with early action.', N'Ngăn chặn khủng hoảng bằng hành động sớm.'),
(N'benevolent', N'/bɪˈnevələnt/', N'nhân từ', N'adjective', N'ADVANCED', N'She was a benevolent leader.', N'Cô ấy là một nhà lãnh đạo nhân từ.'),
(N'brevity', N'/ˈbrevɪti/', N'sự ngắn gọn', N'noun', N'ADVANCED', N'Brevity is the soul of wit.', N'Sự ngắn gọn là linh hồn của sự thông minh.'),
(N'candor', N'/ˈkændər/', N'sự thẳng thắn', N'noun', N'ADVANCED', N'I admire her candor.', N'Tôi ngưỡng mộ sự thẳng thắn của cô ấy.'),
(N'circumspect', N'/ˈsɜːrkəmspekt/', N'thận trọng', N'adjective', N'ADVANCED', N'Be circumspect when making investments.', N'Thận trọng khi đầu tư.'),
(N'cogent', N'/ˈkoʊdʒənt/', N'thuyết phục / mạnh mẽ', N'adjective', N'ADVANCED', N'She made a cogent argument.', N'Cô ấy đưa ra lập luận thuyết phục.'),
(N'compel', N'/kəmˈpel/', N'buộc phải / thôi thúc', N'verb', N'ADVANCED', N'The evidence compels us to act.', N'Bằng chứng buộc chúng ta phải hành động.'),
(N'complicit', N'/kəmˈplɪsɪt/', N'đồng lõa', N'adjective', N'ADVANCED', N'He was complicit in the fraud.', N'Anh ấy đồng lõa trong vụ gian lận.'),
(N'convoluted', N'/ˈkɒnvəluːtɪd/', N'rắc rối / phức tạp', N'adjective', N'ADVANCED', N'The explanation was too convoluted.', N'Giải thích quá rắc rối.'),
(N'covet', N'/ˈkʌvɪt/', N'thèm muốn của người khác', N'verb', N'ADVANCED', N'Don''t covet what others have.', N'Đừng thèm muốn những gì người khác có.'),
(N'cynical', N'/ˈsɪnɪkəl/', N'hoài nghi / yếm thế', N'adjective', N'ADVANCED', N'He was cynical about politics.', N'Anh ấy hoài nghi về chính trị.'),
(N'daunt', N'/dɔːnt/', N'làm nản lòng', N'verb', N'ADVANCED', N'Don''t be daunted by challenges.', N'Đừng nản lòng trước thử thách.'),
(N'debilitating', N'/dɪˈbɪlɪteɪtɪŋ/', N'làm suy yếu', N'adjective', N'ADVANCED', N'Chronic illness can be debilitating.', N'Bệnh mãn tính có thể làm suy yếu.'),
(N'deceive', N'/dɪˈsiːv/', N'lừa dối', N'verb', N'INTERMEDIATE', N'Don''t deceive people who trust you.', N'Đừng lừa dối người tin tưởng bạn.'),
(N'decipher', N'/dɪˈsaɪfər/', N'giải mã', N'verb', N'ADVANCED', N'Can you decipher this message?', N'Bạn có thể giải mã tin nhắn này không?'),
(N'deference', N'/ˈdefərəns/', N'sự kính trọng', N'noun', N'ADVANCED', N'Show deference to elders.', N'Thể hiện sự kính trọng với người lớn tuổi.'),
(N'denigrate', N'/ˈdenɪɡreɪt/', N'bôi nhọ / hạ thấp', N'verb', N'ADVANCED', N'Don''t denigrate others'' work.', N'Đừng hạ thấp công việc của người khác.'),
(N'denounce', N'/dɪˈnaʊns/', N'tố cáo / lên án', N'verb', N'ADVANCED', N'She denounced the corrupt official.', N'Cô ấy tố cáo quan chức tham nhũng.'),
(N'despondent', N'/dɪˈspɒndənt/', N'chán nản / tuyệt vọng', N'adjective', N'ADVANCED', N'He was despondent after the failure.', N'Anh ấy chán nản sau thất bại.'),
(N'detrimental', N'/ˌdetrɪˈmentəl/', N'có hại', N'adjective', N'ADVANCED', N'Stress is detrimental to health.', N'Căng thẳng có hại cho sức khỏe.'),
(N'devoid', N'/dɪˈvɔɪd/', N'thiếu / không có', N'adjective', N'ADVANCED', N'The report was devoid of facts.', N'Báo cáo không có sự kiện nào.'),
(N'diligent', N'/ˈdɪlɪdʒənt/', N'cần cù / siêng năng', N'adjective', N'INTERMEDIATE', N'Be diligent in your studies.', N'Cần cù trong học tập.'),
(N'discern', N'/dɪˈsɜːrn/', N'nhận ra / phân biệt', N'verb', N'ADVANCED', N'Discern the truth from the lies.', N'Nhận ra sự thật từ những lời nói dối.'),
(N'disdain', N'/dɪsˈdeɪn/', N'coi thường', N'noun', N'ADVANCED', N'He looked at them with disdain.', N'Anh ấy nhìn họ với sự coi thường.'),
(N'diverge', N'/daɪˈvɜːrdʒ/', N'phân kỳ / khác nhau', N'verb', N'ADVANCED', N'Our opinions diverged on that topic.', N'Ý kiến của chúng tôi khác nhau về chủ đề đó.'),
(N'dubious', N'/ˈdjuːbiəs/', N'nghi ngờ / đáng ngờ', N'adjective', N'ADVANCED', N'His claim seemed dubious.', N'Tuyên bố của anh ấy có vẻ đáng ngờ.'),
(N'elicit', N'/ɪˈlɪsɪt/', N'gợi ra / khơi dậy', N'verb', N'ADVANCED', N'Her speech elicited strong emotions.', N'Bài phát biểu của cô ấy gợi lên cảm xúc mạnh.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('aberrant','abide','abridge','abstain','acrimony','adroit','affable','alleviate','aloof','ambiguous','ameliorate','amiable','anomalous','antipathy','apprehension','apt','arduous','articulate','ascertain','astute','atrocity','audacious','augment','avert','benevolent','brevity','candor','circumspect','cogent','compel','complicit','convoluted','covet','cynical','daunt','debilitating','deceive','decipher','deference','denigrate','denounce','despondent','detrimental','devoid','diligent','discern','disdain','diverge','dubious','elicit');
