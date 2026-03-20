--liquibase formatted sql

--changeset vocab:031-seed-words-batch24
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Education (advanced topics)
(N'academic', N'/ˌækəˈdemɪk/', N'học thuật', N'adjective', N'INTERMEDIATE', N'She has strong academic performance.', N'Cô ấy có kết quả học thuật tốt.'),
(N'accreditation', N'/əˌkredɪˈteɪʃən/', N'công nhận / kiểm định', N'noun', N'ADVANCED', N'The school received full accreditation.', N'Trường nhận được công nhận đầy đủ.'),
(N'assignment', N'/əˈsaɪnmənt/', N'bài tập / nhiệm vụ', N'noun', N'BEGINNER', N'Submit your assignment by Friday.', N'Nộp bài tập trước thứ Sáu.'),
(N'campus', N'/ˈkæmpəs/', N'khuôn viên trường', N'noun', N'INTERMEDIATE', N'The campus is large and beautiful.', N'Khuôn viên trường rộng và đẹp.'),
(N'curriculum', N'/kəˈrɪkjʊləm/', N'chương trình giảng dạy', N'noun', N'INTERMEDIATE', N'The curriculum needs updating.', N'Chương trình giảng dạy cần cập nhật.'),
(N'dean', N'/diːn/', N'trưởng khoa', N'noun', N'INTERMEDIATE', N'Meet with the dean about your issue.', N'Gặp trưởng khoa về vấn đề của bạn.'),
(N'dissertation', N'/ˌdɪsəˈteɪʃən/', N'luận văn', N'noun', N'ADVANCED', N'She submitted her dissertation last month.', N'Cô ấy nộp luận văn tháng trước.'),
(N'enroll', N'/ɪnˈroʊl/', N'đăng ký / ghi danh', N'verb', N'INTERMEDIATE', N'Enroll in the spring semester.', N'Ghi danh vào học kỳ mùa xuân.'),
(N'faculty', N'/ˈfæklti/', N'khoa / giảng viên', N'noun', N'INTERMEDIATE', N'The faculty approved the new course.', N'Khoa thông qua khóa học mới.'),
(N'fellowship', N'/ˈfeloʊʃɪp/', N'học bổng nghiên cứu', N'noun', N'ADVANCED', N'She won a research fellowship.', N'Cô ấy giành được học bổng nghiên cứu.'),
(N'grade', N'/ɡreɪd/', N'điểm số / lớp học', N'noun', N'BEGINNER', N'Work hard to get good grades.', N'Học chăm chỉ để có điểm tốt.'),
(N'internship', N'/ˈɪntɜːrnʃɪp/', N'thực tập', N'noun', N'INTERMEDIATE', N'She did an internship at a tech company.', N'Cô ấy thực tập ở công ty công nghệ.'),
(N'lecture', N'/ˈlektʃər/', N'bài giảng', N'noun', N'INTERMEDIATE', N'The lecture starts at 9 AM.', N'Bài giảng bắt đầu lúc 9 giờ sáng.'),
(N'literacy', N'/ˈlɪtərəsi/', N'khả năng đọc viết', N'noun', N'INTERMEDIATE', N'Improve literacy in rural areas.', N'Cải thiện khả năng đọc viết ở vùng nông thôn.'),
(N'mentor', N'/ˈmentɔːr/', N'người hướng dẫn', N'noun', N'INTERMEDIATE', N'Find a good mentor in your field.', N'Tìm người hướng dẫn tốt trong lĩnh vực của bạn.'),
(N'module', N'/ˈmɒdjuːl/', N'mô-đun / học phần', N'noun', N'INTERMEDIATE', N'Complete module 3 before the exam.', N'Hoàn thành học phần 3 trước kỳ thi.'),
(N'orientation', N'/ˌɔːriənˈteɪʃən/', N'định hướng / tuần sinh hoạt', N'noun', N'INTERMEDIATE', N'Attend orientation before classes begin.', N'Tham dự tuần định hướng trước khi lớp học bắt đầu.'),
(N'plagiarism', N'/ˈpleɪdʒɪərɪzəm/', N'đạo văn', N'noun', N'ADVANCED', N'Plagiarism can lead to expulsion.', N'Đạo văn có thể dẫn đến đuổi học.'),
(N'portfolio', N'/pɔːrtˈfoʊlioʊ/', N'hồ sơ học tập', N'noun', N'INTERMEDIATE', N'Build a strong academic portfolio.', N'Xây dựng hồ sơ học tập vững chắc.'),
(N'professor', N'/prəˈfesər/', N'giáo sư', N'noun', N'BEGINNER', N'The professor gave an interesting lecture.', N'Giáo sư đã có một bài giảng thú vị.'),
(N'scholarship', N'/ˈskɒlərʃɪp/', N'học bổng', N'noun', N'INTERMEDIATE', N'Apply for a scholarship this year.', N'Đăng ký học bổng năm nay.'),
(N'seminar', N'/ˈsemɪnɑːr/', N'hội thảo', N'noun', N'INTERMEDIATE', N'Attend the marketing seminar.', N'Tham dự hội thảo marketing.'),
(N'syllabi', N'/ˈsɪləbaɪ/', N'đề cương môn học (số nhiều)', N'noun', N'ADVANCED', N'Review the syllabi for all courses.', N'Xem lại đề cương cho tất cả các môn.'),
(N'syllabus', N'/ˈsɪləbəs/', N'đề cương môn học', N'noun', N'INTERMEDIATE', N'The syllabus outlines all topics.', N'Đề cương phác thảo tất cả các chủ đề.'),
(N'thesis', N'/ˈθiːsɪs/', N'luận văn tốt nghiệp', N'noun', N'INTERMEDIATE', N'She defended her thesis successfully.', N'Cô ấy bảo vệ luận văn thành công.'),
(N'tuition', N'/tjuːˈɪʃən/', N'học phí', N'noun', N'INTERMEDIATE', N'The tuition fee increased this year.', N'Học phí tăng năm nay.'),
(N'undergraduate', N'/ˌʌndərˈɡrædʒuɪt/', N'sinh viên đại học', N'noun', N'INTERMEDIATE', N'He is an undergraduate student.', N'Anh ấy là sinh viên đại học.'),
-- Thematic: Arts & Culture
(N'abstract', N'/ˈæbstrækt/', N'trừu tượng', N'adjective', N'INTERMEDIATE', N'Abstract art uses shapes and colors.', N'Nghệ thuật trừu tượng sử dụng hình dạng và màu sắc.'),
(N'aesthetic', N'/iːsˈθetɪk/', N'thẩm mỹ', N'adjective', N'ADVANCED', N'The design has an aesthetic appeal.', N'Thiết kế có sức hút thẩm mỹ.'),
(N'canvas', N'/ˈkænvəs/', N'vải canvas / bức tranh', N'noun', N'INTERMEDIATE', N'She painted on a large canvas.', N'Cô ấy vẽ trên tấm vải canvas lớn.'),
(N'choreography', N'/ˌkɒriˈɒɡrəfi/', N'biên đạo múa', N'noun', N'ADVANCED', N'The choreography was stunning.', N'Biên đạo múa thật ấn tượng.'),
(N'classical', N'/ˈklæsɪkəl/', N'cổ điển', N'adjective', N'INTERMEDIATE', N'She plays classical piano.', N'Cô ấy chơi đàn piano cổ điển.'),
(N'composer', N'/kəmˈpoʊzər/', N'nhạc sĩ sáng tác', N'noun', N'INTERMEDIATE', N'Beethoven was a famous composer.', N'Beethoven là nhà soạn nhạc nổi tiếng.'),
(N'exhibition', N'/ˌeksɪˈbɪʃən/', N'triển lãm', N'noun', N'INTERMEDIATE', N'Visit the art exhibition this weekend.', N'Tham quan triển lãm nghệ thuật cuối tuần này.'),
(N'folk', N'/foʊk/', N'dân gian / người dân', N'adjective', N'INTERMEDIATE', N'Folk music tells stories of the people.', N'Âm nhạc dân gian kể câu chuyện của người dân.'),
(N'gallery', N'/ˈɡæləri/', N'phòng trưng bày', N'noun', N'INTERMEDIATE', N'Visit the art gallery downtown.', N'Tham quan phòng trưng bày nghệ thuật ở trung tâm thành phố.'),
(N'genre', N'/ˈʒɑːnrə/', N'thể loại', N'noun', N'INTERMEDIATE', N'What genre of music do you like?', N'Bạn thích thể loại âm nhạc nào?'),
(N'harmony', N'/ˈhɑːrməni/', N'sự hòa hợp / hòa âm', N'noun', N'INTERMEDIATE', N'The choir sang in harmony.', N'Hợp xướng hát trong hòa âm.'),
(N'heritage', N'/ˈherɪtɪdʒ/', N'di sản', N'noun', N'INTERMEDIATE', N'Preserve your cultural heritage.', N'Bảo tồn di sản văn hóa của bạn.'),
(N'melody', N'/ˈmelədi/', N'giai điệu', N'noun', N'INTERMEDIATE', N'The melody is soft and soothing.', N'Giai điệu nhẹ nhàng và êm dịu.'),
(N'mosaic', N'/moʊˈzeɪɪk/', N'tranh ghép mảnh', N'noun', N'ADVANCED', N'The floor has a beautiful mosaic design.', N'Sàn nhà có thiết kế tranh ghép đẹp.'),
(N'mural', N'/ˈmjʊərəl/', N'tranh tường', N'noun', N'INTERMEDIATE', N'The mural covers the entire wall.', N'Tranh tường bao phủ cả bức tường.'),
(N'orchestra', N'/ˈɔːrkɪstrə/', N'dàn nhạc giao hưởng', N'noun', N'INTERMEDIATE', N'The orchestra performed beautifully.', N'Dàn nhạc biểu diễn tuyệt vời.'),
(N'portrait', N'/ˈpɔːrtrɪt/', N'chân dung', N'noun', N'INTERMEDIATE', N'He painted a portrait of the queen.', N'Anh ấy vẽ chân dung nữ hoàng.'),
(N'sculpture', N'/ˈskʌlptʃər/', N'điêu khắc / tác phẩm điêu khắc', N'noun', N'INTERMEDIATE', N'The sculpture stands in the town square.', N'Tác phẩm điêu khắc đứng ở quảng trường thị trấn.'),
(N'symphony', N'/ˈsɪmfəni/', N'bản giao hưởng', N'noun', N'ADVANCED', N'Beethoven wrote nine symphonies.', N'Beethoven đã viết chín bản giao hưởng.'),
(N'theatrical', N'/θiˈætrɪkəl/', N'sân khấu / kịch tính', N'adjective', N'ADVANCED', N'She gave a theatrical performance.', N'Cô ấy trình diễn rất kịch tính.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('academic','accreditation','assignment','campus','curriculum','dean','dissertation','enroll','faculty','fellowship','grade','internship','lecture','literacy','mentor','module','orientation','plagiarism','professor','scholarship','seminar','syllabi','syllabus','thesis','tuition','undergraduate','abstract','aesthetic','canvas','choreography','classical','composer','exhibition','folk','gallery','genre','harmony','heritage','melody','mosaic','mural','orchestra','portrait','sculpture','symphony','theatrical');
