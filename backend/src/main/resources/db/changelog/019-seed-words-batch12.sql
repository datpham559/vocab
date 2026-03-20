--liquibase formatted sql

--changeset vocab:019-seed-words-batch12
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- BEGINNER: Occupations
(N'doctor', N'/ˈdɒktər/', N'bác sĩ', N'noun', N'BEGINNER', N'The doctor checks the patient.', N'Bác sĩ kiểm tra bệnh nhân.'),
(N'nurse', N'/nɜːrs/', N'y tá', N'noun', N'BEGINNER', N'The nurse helps sick people.', N'Y tá giúp đỡ người bệnh.'),
(N'engineer', N'/ˌendʒɪˈnɪər/', N'kỹ sư', N'noun', N'BEGINNER', N'He is a software engineer.', N'Anh ấy là kỹ sư phần mềm.'),
(N'lawyer', N'/ˈlɔɪər/', N'luật sư', N'noun', N'BEGINNER', N'Hire a good lawyer.', N'Thuê luật sư giỏi.'),
(N'police officer', N'/pəˈliːs ˈɒfɪsər/', N'cảnh sát', N'noun', N'BEGINNER', N'The police officer directs traffic.', N'Cảnh sát điều tiết giao thông.'),
(N'firefighter', N'/ˈfaɪərfaɪtər/', N'lính cứu hỏa', N'noun', N'BEGINNER', N'Firefighters save lives.', N'Lính cứu hỏa cứu người.'),
(N'chef', N'/ʃef/', N'đầu bếp', N'noun', N'BEGINNER', N'The chef makes delicious food.', N'Đầu bếp làm đồ ăn ngon.'),
(N'pilot', N'/ˈpaɪlɪt/', N'phi công', N'noun', N'BEGINNER', N'The pilot landed the plane safely.', N'Phi công hạ cánh máy bay an toàn.'),
(N'farmer', N'/ˈfɑːrmər/', N'nông dân', N'noun', N'BEGINNER', N'The farmer grows vegetables.', N'Nông dân trồng rau.'),
(N'artist', N'/ˈɑːrtɪst/', N'nghệ sĩ', N'noun', N'BEGINNER', N'The artist paints beautiful pictures.', N'Nghệ sĩ vẽ những bức tranh đẹp.'),
(N'singer', N'/ˈsɪŋər/', N'ca sĩ', N'noun', N'BEGINNER', N'She is a famous singer.', N'Cô ấy là ca sĩ nổi tiếng.'),
(N'driver', N'/ˈdraɪvər/', N'tài xế', N'noun', N'BEGINNER', N'The driver knows the city well.', N'Tài xế biết rõ thành phố.'),
(N'soldier', N'/ˈsoʊldʒər/', N'người lính', N'noun', N'BEGINNER', N'The soldier guards the border.', N'Người lính canh biên giới.'),
(N'dentist', N'/ˈdentɪst/', N'nha sĩ', N'noun', N'BEGINNER', N'Visit the dentist twice a year.', N'Đến nha sĩ hai lần một năm.'),
(N'accountant', N'/əˈkaʊntənt/', N'kế toán', N'noun', N'BEGINNER', N'The accountant manages the finances.', N'Kế toán quản lý tài chính.'),
(N'programmer', N'/ˈproʊɡræmər/', N'lập trình viên', N'noun', N'BEGINNER', N'The programmer writes code all day.', N'Lập trình viên viết code cả ngày.'),
(N'architect', N'/ˈɑːrkɪtekt/', N'kiến trúc sư', N'noun', N'BEGINNER', N'The architect designs buildings.', N'Kiến trúc sư thiết kế tòa nhà.'),
(N'scientist', N'/ˈsaɪəntɪst/', N'nhà khoa học', N'noun', N'BEGINNER', N'The scientist conducts experiments.', N'Nhà khoa học tiến hành thí nghiệm.'),
(N'journalist', N'/ˈdʒɜːrnəlɪst/', N'nhà báo', N'noun', N'BEGINNER', N'The journalist reports the news.', N'Nhà báo đưa tin tức.'),
(N'athlete', N'/ˈæθliːt/', N'vận động viên', N'noun', N'BEGINNER', N'The athlete trains every day.', N'Vận động viên luyện tập mỗi ngày.'),
-- BEGINNER: Common Prepositions & Conjunctions
(N'with', N'/wɪð/', N'với / cùng với', N'preposition', N'BEGINNER', N'Come with me.', N'Đi cùng tôi.'),
(N'without', N'/wɪˈðaʊt/', N'không có', N'preposition', N'BEGINNER', N'I can''t work without coffee.', N'Tôi không thể làm việc thiếu cà phê.'),
(N'between', N'/bɪˈtwiːn/', N'ở giữa (hai)', N'preposition', N'BEGINNER', N'Sit between the two chairs.', N'Ngồi giữa hai chiếc ghế.'),
(N'among', N'/əˈmʌŋ/', N'ở giữa (nhiều)', N'preposition', N'BEGINNER', N'She was among the winners.', N'Cô ấy nằm trong số những người chiến thắng.'),
(N'during', N'/ˈdjʊərɪŋ/', N'trong suốt', N'preposition', N'BEGINNER', N'Don''t talk during class.', N'Đừng nói chuyện trong giờ học.'),
(N'before', N'/bɪˈfɔːr/', N'trước khi', N'preposition', N'BEGINNER', N'Wash hands before eating.', N'Rửa tay trước khi ăn.'),
(N'after', N'/ˈæftər/', N'sau khi', N'preposition', N'BEGINNER', N'Brush teeth after eating.', N'Đánh răng sau khi ăn.'),
(N'because', N'/bɪˈkɒz/', N'bởi vì', N'conjunction', N'BEGINNER', N'I stayed home because I was sick.', N'Tôi ở nhà vì tôi bị bệnh.'),
(N'although', N'/ɔːlˈðoʊ/', N'mặc dù', N'conjunction', N'BEGINNER', N'Although it rained, we went out.', N'Mặc dù trời mưa, chúng tôi vẫn ra ngoài.'),
(N'therefore', N'/ˈðerfɔːr/', N'vì vậy', N'conjunction', N'BEGINNER', N'I was tired, therefore I slept early.', N'Tôi mệt, vì vậy tôi ngủ sớm.'),
(N'however', N'/haʊˈevər/', N'tuy nhiên', N'conjunction', N'BEGINNER', N'It was expensive. However, I bought it.', N'Nó đắt. Tuy nhiên tôi vẫn mua.'),
(N'furthermore', N'/ˈfɜːrðərmɔːr/', N'hơn nữa', N'conjunction', N'BEGINNER', N'Furthermore, the plan is risky.', N'Hơn nữa, kế hoạch này rủi ro.'),
-- INTERMEDIATE: Idioms & Common Expressions
(N'by heart', N'/baɪ hɑːrt/', N'thuộc lòng', N'idiom', N'INTERMEDIATE', N'Learn the poem by heart.', N'Học bài thơ thuộc lòng.'),
(N'once in a while', N'/wʌns ɪn ə waɪl/', N'thỉnh thoảng', N'idiom', N'INTERMEDIATE', N'We meet once in a while.', N'Chúng tôi gặp nhau thỉnh thoảng.'),
(N'all of a sudden', N'/ɔːl əv ə ˈsʌdən/', N'đột nhiên', N'idiom', N'INTERMEDIATE', N'All of a sudden, it started raining.', N'Đột nhiên trời bắt đầu mưa.'),
(N'at first glance', N'/æt fɜːrst ɡlæns/', N'thoạt nhìn', N'idiom', N'INTERMEDIATE', N'At first glance, it looks simple.', N'Thoạt nhìn, nó có vẻ đơn giản.'),
(N'in the long run', N'/ɪn ðə lɒŋ rʌn/', N'về lâu dài', N'idiom', N'INTERMEDIATE', N'In the long run, it''s worth it.', N'Về lâu dài, điều đó xứng đáng.'),
(N'on the contrary', N'/ɒn ðə ˈkɒntrəri/', N'ngược lại', N'idiom', N'INTERMEDIATE', N'On the contrary, I disagree.', N'Ngược lại, tôi không đồng ý.'),
(N'in terms of', N'/ɪn tɜːrmz əv/', N'về mặt / xét về', N'idiom', N'INTERMEDIATE', N'In terms of cost, it''s too high.', N'Về mặt chi phí, nó quá cao.'),
(N'take into account', N'/teɪk ɪntə əˈkaʊnt/', N'tính đến / xem xét', N'idiom', N'INTERMEDIATE', N'Take all factors into account.', N'Hãy xem xét tất cả các yếu tố.'),
(N'as a result', N'/æz ə rɪˈzʌlt/', N'kết quả là', N'idiom', N'INTERMEDIATE', N'As a result, we missed the train.', N'Kết quả là chúng tôi lỡ tàu.'),
(N'in other words', N'/ɪn ˈʌðər wɜːrdz/', N'nói cách khác', N'idiom', N'INTERMEDIATE', N'In other words, you disagree.', N'Nói cách khác, bạn không đồng ý.'),
-- INTERMEDIATE: Science vocabulary
(N'experiment', N'/ɪkˈsperɪmənt/', N'thí nghiệm', N'noun', N'INTERMEDIATE', N'Conduct an experiment in the lab.', N'Tiến hành thí nghiệm trong phòng lab.'),
(N'theory', N'/ˈθɪəri/', N'lý thuyết', N'noun', N'INTERMEDIATE', N'His theory changed science forever.', N'Lý thuyết của ông đã thay đổi khoa học mãi mãi.'),
(N'evidence', N'/ˈevɪdəns/', N'bằng chứng khoa học', N'noun', N'INTERMEDIATE', N'Provide scientific evidence.', N'Cung cấp bằng chứng khoa học.'),
(N'observation', N'/ˌɒbzərˈveɪʃən/', N'sự quan sát', N'noun', N'INTERMEDIATE', N'Careful observation is key.', N'Quan sát cẩn thận là chìa khóa.'),
(N'analysis', N'/əˈnælɪsɪs/', N'phân tích', N'noun', N'INTERMEDIATE', N'The analysis shows clear results.', N'Phân tích cho thấy kết quả rõ ràng.'),
(N'conclusion', N'/kənˈkluːʒən/', N'kết luận', N'noun', N'INTERMEDIATE', N'Draw a conclusion from the data.', N'Rút ra kết luận từ dữ liệu.'),
(N'variable', N'/ˈveriəbəl/', N'biến số', N'noun', N'INTERMEDIATE', N'Change only one variable at a time.', N'Chỉ thay đổi một biến số mỗi lần.'),
(N'laboratory', N'/ˈlæbrətɔːri/', N'phòng thí nghiệm', N'noun', N'INTERMEDIATE', N'Work safely in the laboratory.', N'Làm việc an toàn trong phòng thí nghiệm.'),
(N'molecule', N'/ˈmɒlɪkjuːl/', N'phân tử', N'noun', N'INTERMEDIATE', N'Water is made of two hydrogen molecules.', N'Nước được tạo từ hai phân tử hydro.'),
(N'atom', N'/ˈætəm/', N'nguyên tử', N'noun', N'INTERMEDIATE', N'Atoms are the building blocks of matter.', N'Nguyên tử là đơn vị cơ bản của vật chất.'),
-- ADVANCED: Medical Specialties
(N'cardiology', N'/ˌkɑːrdiˈɒlədʒi/', N'tim mạch học', N'noun', N'ADVANCED', N'She specializes in cardiology.', N'Cô ấy chuyên về tim mạch học.'),
(N'neurology', N'/njʊˈrɒlədʒi/', N'thần kinh học', N'noun', N'ADVANCED', N'Neurology studies brain diseases.', N'Thần kinh học nghiên cứu bệnh não.'),
(N'oncology', N'/ɒŋˈkɒlədʒi/', N'ung thư học', N'noun', N'ADVANCED', N'Oncology deals with cancer treatment.', N'Ung thư học liên quan đến điều trị ung thư.'),
(N'pediatrics', N'/ˌpiːdiˈætrɪks/', N'nhi khoa', N'noun', N'ADVANCED', N'He works in pediatrics.', N'Anh ấy làm ở khoa nhi.'),
(N'anesthesia', N'/ˌænɪsˈθiːziə/', N'gây mê / gây tê', N'noun', N'ADVANCED', N'The patient was under anesthesia.', N'Bệnh nhân được gây mê.'),
(N'biopsy', N'/ˈbaɪɒpsi/', N'sinh thiết', N'noun', N'ADVANCED', N'A biopsy confirmed the diagnosis.', N'Sinh thiết xác nhận chẩn đoán.'),
(N'chemotherapy', N'/ˌkiːmoʊˈθerəpi/', N'hóa trị liệu', N'noun', N'ADVANCED', N'She underwent chemotherapy.', N'Cô ấy trải qua hóa trị liệu.'),
(N'osteoporosis', N'/ˌɒstiəʊpəˈroʊsɪs/', N'loãng xương', N'noun', N'ADVANCED', N'Osteoporosis weakens bones.', N'Loãng xương làm yếu xương.'),
(N'hypertension', N'/ˌhaɪpərˈtenʃən/', N'huyết áp cao', N'noun', N'ADVANCED', N'Manage hypertension with medication.', N'Kiểm soát huyết áp cao bằng thuốc.'),
(N'autoimmune', N'/ˌɔːtoʊɪˈmjuːn/', N'tự miễn dịch', N'adjective', N'ADVANCED', N'An autoimmune disease attacks the body.', N'Bệnh tự miễn tấn công cơ thể.'),
-- ADVANCED: Philosophical Concepts
(N'determinism', N'/dɪˈtɜːrmɪnɪzəm/', N'thuyết tất định', N'noun', N'ADVANCED', N'Determinism says everything is predetermined.', N'Thuyết tất định nói mọi thứ đều được định sẵn.'),
(N'existentialism', N'/ˌeɡzɪˈstenʃəlɪzəm/', N'triết học hiện sinh', N'noun', N'ADVANCED', N'Existentialism focuses on individual freedom.', N'Triết học hiện sinh tập trung vào tự do cá nhân.'),
(N'nihilism', N'/ˈnaɪɪlɪzəm/', N'chủ nghĩa hư vô', N'noun', N'ADVANCED', N'Nihilism rejects meaning and values.', N'Chủ nghĩa hư vô phủ nhận ý nghĩa và giá trị.'),
(N'epistemology', N'/ɪˌpɪstɪˈmɒlədʒi/', N'nhận thức luận', N'noun', N'ADVANCED', N'Epistemology studies how we know things.', N'Nhận thức luận nghiên cứu cách chúng ta biết mọi thứ.'),
(N'ontology', N'/ɒnˈtɒlədʒi/', N'bản thể luận', N'noun', N'ADVANCED', N'Ontology studies the nature of being.', N'Bản thể luận nghiên cứu bản chất của sự tồn tại.'),
(N'dialectic', N'/ˌdaɪəˈlektɪk/', N'biện chứng pháp', N'noun', N'ADVANCED', N'Hegel developed dialectic thinking.', N'Hegel phát triển tư duy biện chứng.'),
(N'utilitarian', N'/ˌjuːtɪlɪˈteriən/', N'công lợi / vị lợi', N'adjective', N'ADVANCED', N'A utilitarian approach maximizes benefit.', N'Cách tiếp cận công lợi tối đa hóa lợi ích.'),
(N'empiricism', N'/ɪmˈpɪrɪsɪzəm/', N'chủ nghĩa kinh nghiệm', N'noun', N'ADVANCED', N'Empiricism values observation over theory.', N'Chủ nghĩa kinh nghiệm đề cao quan sát hơn lý thuyết.'),
(N'rationalism', N'/ˈræʃənəlɪzəm/', N'chủ nghĩa duy lý', N'noun', N'ADVANCED', N'Rationalism relies on reason alone.', N'Chủ nghĩa duy lý dựa hoàn toàn vào lý trí.'),
(N'phenomenology', N'/fɪˌnɒmɪˈnɒlədʒi/', N'hiện tượng học', N'noun', N'ADVANCED', N'Phenomenology studies lived experience.', N'Hiện tượng học nghiên cứu trải nghiệm sống.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('doctor','nurse','engineer','lawyer','police officer','firefighter','chef','pilot','farmer','artist','singer','driver','soldier','dentist','accountant','programmer','architect','scientist','journalist','athlete','with','without','between','among','during','before','after','because','although','therefore','however','furthermore','by heart','once in a while','all of a sudden','at first glance','in the long run','on the contrary','in terms of','take into account','as a result','in other words','experiment','theory','evidence','observation','analysis','conclusion','variable','laboratory','molecule','atom','cardiology','neurology','oncology','pediatrics','anesthesia','biopsy','chemotherapy','osteoporosis','hypertension','autoimmune','determinism','existentialism','nihilism','epistemology','ontology','dialectic','utilitarian','empiricism','rationalism','phenomenology');
