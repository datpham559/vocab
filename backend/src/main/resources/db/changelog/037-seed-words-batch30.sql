--liquibase formatted sql

--changeset vocab:037-seed-words-batch30
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Nouns (abstract concepts)
(N'abundance', N'/əˈbʌndəns/', N'sự phong phú / dư thừa', N'noun', N'INTERMEDIATE', N'There is an abundance of food.', N'Có rất nhiều thức ăn.'),
(N'achievement', N'/əˈtʃiːvmənt/', N'thành tích / thành tựu', N'noun', N'BEGINNER', N'Be proud of your achievements.', N'Tự hào về thành tích của bạn.'),
(N'ambition', N'/æmˈbɪʃən/', N'tham vọng', N'noun', N'INTERMEDIATE', N'Her ambition drove her to succeed.', N'Tham vọng thúc đẩy cô ấy thành công.'),
(N'appearance', N'/əˈpɪərəns/', N'ngoại hình / vẻ ngoài', N'noun', N'INTERMEDIATE', N'Don''t judge by appearance alone.', N'Đừng chỉ đánh giá qua ngoại hình.'),
(N'attitude', N'/ˈætɪtjuːd/', N'thái độ', N'noun', N'INTERMEDIATE', N'Your attitude determines your success.', N'Thái độ của bạn quyết định thành công.'),
(N'authority', N'/ɔːˈθɒrɪti/', N'thẩm quyền / chính quyền', N'noun', N'INTERMEDIATE', N'Respect those in authority.', N'Tôn trọng những người có thẩm quyền.'),
(N'awareness', N'/əˈweənɪs/', N'nhận thức', N'noun', N'INTERMEDIATE', N'Raise awareness about climate change.', N'Nâng cao nhận thức về biến đổi khí hậu.'),
(N'behavior', N'/bɪˈheɪvjər/', N'hành vi', N'noun', N'BEGINNER', N'Good behavior is rewarded.', N'Hành vi tốt được khen thưởng.'),
(N'belief', N'/bɪˈliːf/', N'niềm tin', N'noun', N'BEGINNER', N'Hold on to your beliefs.', N'Giữ vững niềm tin của bạn.'),
(N'capability', N'/ˌkeɪpəˈbɪlɪti/', N'khả năng', N'noun', N'INTERMEDIATE', N'Expand your capabilities.', N'Mở rộng khả năng của bạn.'),
(N'character', N'/ˈkærəktər/', N'tính cách / nhân vật', N'noun', N'BEGINNER', N'Build a strong character.', N'Xây dựng tính cách mạnh mẽ.'),
(N'circumstance', N'/ˈsɜːrkəmstæns/', N'hoàn cảnh', N'noun', N'INTERMEDIATE', N'Consider all circumstances.', N'Xem xét tất cả hoàn cảnh.'),
(N'consciousness', N'/ˈkɒnʃəsnɪs/', N'ý thức', N'noun', N'ADVANCED', N'Consciousness defines human experience.', N'Ý thức xác định trải nghiệm của con người.'),
(N'consequence', N'/ˈkɒnsɪkwəns/', N'hậu quả / kết quả', N'noun', N'INTERMEDIATE', N'Think about the consequences.', N'Suy nghĩ về hậu quả.'),
(N'credibility', N'/ˌkredɪˈbɪlɪti/', N'độ tin cậy', N'noun', N'ADVANCED', N'Build your credibility over time.', N'Xây dựng độ tin cậy theo thời gian.'),
(N'discipline', N'/ˈdɪsɪplɪn/', N'kỷ luật', N'noun', N'INTERMEDIATE', N'Discipline is the key to success.', N'Kỷ luật là chìa khóa thành công.'),
(N'diversity', N'/daɪˈvɜːrsɪti/', N'đa dạng', N'noun', N'INTERMEDIATE', N'Diversity brings strength.', N'Sự đa dạng mang lại sức mạnh.'),
(N'efficiency', N'/ɪˈfɪʃənsi/', N'hiệu quả / năng suất', N'noun', N'INTERMEDIATE', N'Improve efficiency in operations.', N'Cải thiện hiệu quả trong hoạt động.'),
(N'expertise', N'/ˌekspɜːˈtiːz/', N'chuyên môn', N'noun', N'INTERMEDIATE', N'Share your expertise with others.', N'Chia sẻ chuyên môn của bạn với người khác.'),
(N'fairness', N'/ˈfeənɪs/', N'sự công bằng', N'noun', N'INTERMEDIATE', N'Treat everyone with fairness.', N'Đối xử với mọi người công bằng.'),
(N'foundation', N'/faʊnˈdeɪʃən/', N'nền tảng', N'noun', N'INTERMEDIATE', N'Build a strong foundation first.', N'Trước tiên xây dựng nền tảng vững chắc.'),
(N'imagination', N'/ɪˌmædʒɪˈneɪʃən/', N'trí tưởng tượng', N'noun', N'BEGINNER', N'Use your imagination to create.', N'Dùng trí tưởng tượng để sáng tạo.'),
(N'impact', N'/ˈɪmpækt/', N'tác động', N'noun', N'INTERMEDIATE', N'The decision had a big impact.', N'Quyết định có tác động lớn.'),
(N'independence', N'/ˌɪndɪˈpendəns/', N'sự độc lập', N'noun', N'INTERMEDIATE', N'Financial independence takes time.', N'Độc lập tài chính cần thời gian.'),
(N'integrity', N'/ɪnˈteɡrɪti/', N'tính chính trực', N'noun', N'INTERMEDIATE', N'Act with integrity in all things.', N'Hành động chính trực trong mọi việc.'),
(N'knowledge', N'/ˈnɒlɪdʒ/', N'kiến thức', N'noun', N'BEGINNER', N'Knowledge is power.', N'Kiến thức là sức mạnh.'),
(N'leadership', N'/ˈliːdəʃɪp/', N'khả năng lãnh đạo', N'noun', N'INTERMEDIATE', N'Good leadership inspires others.', N'Lãnh đạo tốt truyền cảm hứng cho người khác.'),
(N'mindset', N'/ˈmaɪndset/', N'tư duy', N'noun', N'INTERMEDIATE', N'Develop a growth mindset.', N'Phát triển tư duy tăng trưởng.'),
(N'momentum', N'/məˈmentəm/', N'đà phát triển', N'noun', N'ADVANCED', N'Build momentum and keep going.', N'Xây dựng đà phát triển và tiếp tục.'),
(N'motivation', N'/ˌmoʊtɪˈveɪʃən/', N'động lực', N'noun', N'BEGINNER', N'Find your motivation to keep going.', N'Tìm động lực để tiếp tục.'),
(N'objectivity', N'/ˌɒbdʒekˈtɪvɪti/', N'tính khách quan', N'noun', N'ADVANCED', N'Maintain objectivity when judging.', N'Duy trì tính khách quan khi đánh giá.'),
(N'opportunity', N'/ˌɒpəˈtjuːnɪti/', N'cơ hội', N'noun', N'BEGINNER', N'Every day brings new opportunities.', N'Mỗi ngày mang lại cơ hội mới.'),
(N'ownership', N'/ˈoʊnəʃɪp/', N'quyền sở hữu', N'noun', N'INTERMEDIATE', N'Take ownership of your work.', N'Làm chủ công việc của bạn.'),
(N'perspective', N'/pəˈspektɪv/', N'quan điểm / góc nhìn', N'noun', N'INTERMEDIATE', N'Consider multiple perspectives.', N'Xem xét nhiều góc nhìn khác nhau.'),
(N'reputation', N'/ˌrepjʊˈteɪʃən/', N'danh tiếng', N'noun', N'INTERMEDIATE', N'Protect your reputation always.', N'Luôn bảo vệ danh tiếng.'),
(N'responsibility', N'/rɪˌspɒnsɪˈbɪlɪti/', N'trách nhiệm', N'noun', N'BEGINNER', N'Accept responsibility for mistakes.', N'Chấp nhận trách nhiệm về lỗi lầm.'),
(N'sacrifice', N'/ˈsækrɪfaɪs/', N'sự hy sinh', N'noun', N'INTERMEDIATE', N'Success requires sacrifice.', N'Thành công đòi hỏi sự hy sinh.'),
(N'self-discipline', N'/self ˈdɪsɪplɪn/', N'tự kỷ luật', N'noun', N'INTERMEDIATE', N'Self-discipline is key to achievement.', N'Tự kỷ luật là chìa khóa cho thành tích.'),
(N'transparency', N'/trænsˈpærənsi/', N'sự minh bạch', N'noun', N'INTERMEDIATE', N'Transparency builds trust.', N'Minh bạch xây dựng lòng tin.'),
(N'trust', N'/trʌst/', N'sự tin tưởng', N'noun', N'BEGINNER', N'Build trust through honesty.', N'Xây dựng lòng tin qua sự trung thực.'),
(N'uncertainty', N'/ʌnˈsɜːrtnti/', N'sự không chắc chắn', N'noun', N'INTERMEDIATE', N'Learn to deal with uncertainty.', N'Học cách đối phó với sự không chắc chắn.'),
(N'unity', N'/ˈjuːnɪti/', N'sự đoàn kết', N'noun', N'INTERMEDIATE', N'Unity makes us stronger.', N'Đoàn kết làm cho chúng ta mạnh hơn.'),
(N'urgency', N'/ˈɜːrdʒənsi/', N'tính cấp bách', N'noun', N'INTERMEDIATE', N'Handle this with urgency.', N'Xử lý điều này với sự cấp bách.'),
(N'vulnerability', N'/ˌvʌlnərəˈbɪlɪti/', N'tính dễ tổn thương', N'noun', N'ADVANCED', N'Showing vulnerability is not weakness.', N'Thể hiện tính dễ tổn thương không phải yếu đuối.'),
(N'willpower', N'/ˈwɪlpaʊər/', N'ý chí', N'noun', N'INTERMEDIATE', N'Use your willpower to overcome habits.', N'Dùng ý chí để vượt qua thói quen.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('abundance','achievement','ambition','appearance','attitude','authority','awareness','behavior','belief','capability','character','circumstance','consciousness','consequence','credibility','discipline','efficiency','expertise','fairness','foundation','imagination','impact','independence','integrity','knowledge','leadership','mindset','momentum','motivation','objectivity','opportunity','ownership','perspective','reputation','responsibility','sacrifice','self-discipline','transparency','trust','uncertainty','unity','urgency','vulnerability','willpower');
