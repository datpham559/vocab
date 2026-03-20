--liquibase formatted sql

--changeset vocab:027-seed-words-batch20
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Common words T-V
(N'task', N'/tæsk/', N'nhiệm vụ', N'noun', N'BEGINNER', N'Complete the task on time.', N'Hoàn thành nhiệm vụ đúng hạn.'),
(N'technique', N'/tekˈniːk/', N'kỹ thuật', N'noun', N'INTERMEDIATE', N'Use the right technique.', N'Sử dụng kỹ thuật đúng.'),
(N'tend', N'/tend/', N'có xu hướng', N'verb', N'INTERMEDIATE', N'People tend to resist change.', N'Người ta có xu hướng chống lại sự thay đổi.'),
(N'term', N'/tɜːrm/', N'thuật ngữ / kỳ hạn', N'noun', N'INTERMEDIATE', N'Explain the term in simple words.', N'Giải thích thuật ngữ bằng lời đơn giản.'),
(N'theme', N'/θiːm/', N'chủ đề', N'noun', N'INTERMEDIATE', N'The theme of the novel is love.', N'Chủ đề của tiểu thuyết là tình yêu.'),
(N'theory', N'/ˈθɪəri/', N'lý thuyết', N'noun', N'INTERMEDIATE', N'The theory was proven correct.', N'Lý thuyết đã được chứng minh là đúng.'),
(N'threat', N'/θret/', N'mối đe dọa', N'noun', N'INTERMEDIATE', N'Climate change is a global threat.', N'Biến đổi khí hậu là mối đe dọa toàn cầu.'),
(N'throughout', N'/θruːˈaʊt/', N'xuyên suốt / khắp nơi', N'preposition', N'INTERMEDIATE', N'She worked hard throughout the year.', N'Cô ấy làm việc chăm chỉ suốt cả năm.'),
(N'tool', N'/tuːl/', N'công cụ', N'noun', N'BEGINNER', N'A good tool makes the job easier.', N'Công cụ tốt làm cho công việc dễ dàng hơn.'),
(N'topic', N'/ˈtɒpɪk/', N'chủ đề / đề tài', N'noun', N'BEGINNER', N'Choose an interesting topic.', N'Chọn một đề tài thú vị.'),
(N'touch', N'/tʌtʃ/', N'chạm vào / liên hệ', N'verb', N'BEGINNER', N'Keep in touch with old friends.', N'Giữ liên lạc với bạn cũ.'),
(N'tradition', N'/trəˈdɪʃən/', N'truyền thống', N'noun', N'INTERMEDIATE', N'Respect cultural traditions.', N'Tôn trọng truyền thống văn hóa.'),
(N'transfer', N'/trænsˈfɜːr/', N'chuyển giao / chuyển khoản', N'verb', N'INTERMEDIATE', N'Transfer the file to the new folder.', N'Chuyển tệp vào thư mục mới.'),
(N'trend', N'/trend/', N'xu hướng', N'noun', N'INTERMEDIATE', N'Follow the latest trend.', N'Theo kịp xu hướng mới nhất.'),
(N'trust', N'/trʌst/', N'tin tưởng', N'verb', N'BEGINNER', N'Trust is the foundation of friendship.', N'Sự tin tưởng là nền tảng của tình bạn.'),
(N'typical', N'/ˈtɪpɪkəl/', N'điển hình', N'adjective', N'INTERMEDIATE', N'That is a typical response.', N'Đó là một phản ứng điển hình.'),
(N'ultimately', N'/ˈʌltɪmətli/', N'cuối cùng', N'adverb', N'INTERMEDIATE', N'Ultimately, we made the right choice.', N'Cuối cùng, chúng tôi đã chọn đúng.'),
(N'unique', N'/juːˈniːk/', N'độc đáo / duy nhất', N'adjective', N'INTERMEDIATE', N'Each person is unique.', N'Mỗi người đều độc đáo.'),
(N'unit', N'/ˈjuːnɪt/', N'đơn vị', N'noun', N'BEGINNER', N'Measure in standard units.', N'Đo bằng đơn vị tiêu chuẩn.'),
(N'update', N'/ˈʌpdeɪt/', N'cập nhật', N'verb', N'BEGINNER', N'Update the software regularly.', N'Cập nhật phần mềm thường xuyên.'),
(N'utilize', N'/ˈjuːtɪlaɪz/', N'sử dụng / tận dụng', N'verb', N'INTERMEDIATE', N'Utilize all available resources.', N'Tận dụng tất cả nguồn lực sẵn có.'),
(N'valid', N'/ˈvælɪd/', N'hợp lệ / có giá trị', N'adjective', N'INTERMEDIATE', N'Your ticket is valid for one year.', N'Vé của bạn có giá trị một năm.'),
(N'value', N'/ˈvæljuː/', N'giá trị', N'noun', N'BEGINNER', N'Family values are important.', N'Giá trị gia đình rất quan trọng.'),
(N'variety', N'/vəˈraɪəti/', N'sự đa dạng', N'noun', N'INTERMEDIATE', N'A variety of foods is healthy.', N'Ăn nhiều loại thức ăn rất có lợi cho sức khỏe.'),
(N'version', N'/ˈvɜːrʒən/', N'phiên bản', N'noun', N'INTERMEDIATE', N'Download the latest version.', N'Tải xuống phiên bản mới nhất.'),
(N'victim', N'/ˈvɪktɪm/', N'nạn nhân', N'noun', N'INTERMEDIATE', N'Help the victims of the disaster.', N'Giúp đỡ nạn nhân của thảm họa.'),
(N'view', N'/vjuː/', N'quan điểm / tầm nhìn', N'noun', N'BEGINNER', N'Share your view on the topic.', N'Chia sẻ quan điểm của bạn về chủ đề này.'),
(N'visible', N'/ˈvɪzɪbəl/', N'có thể nhìn thấy', N'adjective', N'INTERMEDIATE', N'Stars are visible at night.', N'Sao có thể nhìn thấy vào ban đêm.'),
(N'vision', N'/ˈvɪʒən/', N'tầm nhìn / thị lực', N'noun', N'INTERMEDIATE', N'The company has a clear vision.', N'Công ty có tầm nhìn rõ ràng.'),
(N'vital', N'/ˈvaɪtəl/', N'quan trọng / thiết yếu', N'adjective', N'INTERMEDIATE', N'Water is vital for survival.', N'Nước rất thiết yếu cho sự sống còn.'),
(N'volume', N'/ˈvɒljuːm/', N'âm lượng / thể tích / tập', N'noun', N'BEGINNER', N'Turn down the volume please.', N'Vui lòng giảm âm lượng.'),
-- Common words W-Z
(N'warn', N'/wɔːrn/', N'cảnh báo', N'verb', N'INTERMEDIATE', N'Warn others about the danger.', N'Cảnh báo người khác về nguy hiểm.'),
(N'weakness', N'/ˈwiːknəs/', N'điểm yếu', N'noun', N'INTERMEDIATE', N'Identify your weaknesses.', N'Xác định điểm yếu của bạn.'),
(N'wealth', N'/welθ/', N'của cải / sự giàu có', N'noun', N'INTERMEDIATE', N'Health is more important than wealth.', N'Sức khỏe quan trọng hơn của cải.'),
(N'welfare', N'/ˈwelfeər/', N'phúc lợi', N'noun', N'INTERMEDIATE', N'The welfare of employees matters.', N'Phúc lợi của nhân viên quan trọng.'),
(N'whereas', N'/weərˈæz/', N'trong khi đó', N'conjunction', N'INTERMEDIATE', N'She likes tea whereas he prefers coffee.', N'Cô ấy thích trà trong khi anh ấy thích cà phê.'),
(N'wide', N'/waɪd/', N'rộng', N'adjective', N'BEGINNER', N'The street is very wide.', N'Con đường rất rộng.'),
(N'willing', N'/ˈwɪlɪŋ/', N'sẵn sàng', N'adjective', N'INTERMEDIATE', N'Are you willing to help?', N'Bạn có sẵn sàng giúp không?'),
(N'wisdom', N'/ˈwɪzdəm/', N'sự khôn ngoan', N'noun', N'INTERMEDIATE', N'Wisdom comes with experience.', N'Sự khôn ngoan đến từ kinh nghiệm.'),
(N'wonder', N'/ˈwʌndər/', N'tự hỏi / kỳ diệu', N'verb', N'BEGINNER', N'I wonder what will happen next.', N'Tôi tự hỏi điều gì sẽ xảy ra tiếp theo.'),
(N'worth', N'/wɜːrθ/', N'đáng giá / có giá trị', N'adjective', N'INTERMEDIATE', N'The trip was worth every penny.', N'Chuyến đi đáng từng đồng tiền.'),
(N'yield', N'/jiːld/', N'tạo ra / nhường đường', N'verb', N'INTERMEDIATE', N'The crops yield a good harvest.', N'Mùa màng cho thu hoạch tốt.'),
-- Thematic: Body Parts
(N'ankle', N'/ˈæŋkəl/', N'mắt cá chân', N'noun', N'BEGINNER', N'I twisted my ankle playing football.', N'Tôi bị bong gân mắt cá chân khi chơi bóng.'),
(N'elbow', N'/ˈelboʊ/', N'khuỷu tay', N'noun', N'BEGINNER', N'Don''t put your elbows on the table.', N'Đừng chống khuỷu tay lên bàn.'),
(N'eyebrow', N'/ˈaɪbraʊ/', N'lông mày', N'noun', N'BEGINNER', N'She raised an eyebrow in surprise.', N'Cô ấy nhướng lông mày ngạc nhiên.'),
(N'forehead', N'/ˈfɔːrhed/', N'trán', N'noun', N'BEGINNER', N'She touched his forehead to check fever.', N'Cô ấy chạm vào trán để kiểm tra sốt.'),
(N'jaw', N'/dʒɔː/', N'hàm', N'noun', N'BEGINNER', N'His jaw dropped in surprise.', N'Hàm anh ấy rơi xuống ngạc nhiên.'),
(N'lung', N'/lʌŋ/', N'phổi', N'noun', N'BEGINNER', N'Smoking damages your lungs.', N'Hút thuốc làm hại phổi.'),
(N'palm', N'/pɑːm/', N'lòng bàn tay', N'noun', N'BEGINNER', N'She held the coin in her palm.', N'Cô ấy giữ đồng xu trong lòng bàn tay.'),
(N'spine', N'/spaɪn/', N'cột sống', N'noun', N'INTERMEDIATE', N'Sit straight to protect your spine.', N'Ngồi thẳng để bảo vệ cột sống.'),
(N'temple', N'/ˈtempəl/', N'thái dương / đền thờ', N'noun', N'INTERMEDIATE', N'He rubbed his temple in thought.', N'Anh ấy xoa thái dương khi suy nghĩ.'),
(N'thumb', N'/θʌm/', N'ngón tay cái', N'noun', N'BEGINNER', N'Give a thumbs up if you agree.', N'Giơ ngón tay cái nếu bạn đồng ý.'),
(N'wrist', N'/rɪst/', N'cổ tay', N'noun', N'BEGINNER', N'She wore a bracelet on her wrist.', N'Cô ấy đeo vòng tay trên cổ tay.'),
-- Thematic: Clothes & Accessories
(N'blouse', N'/blaʊz/', N'áo blouse', N'noun', N'BEGINNER', N'She wore a white blouse to work.', N'Cô ấy mặc áo blouse trắng đi làm.'),
(N'bracelet', N'/ˈbreɪslɪt/', N'vòng tay', N'noun', N'BEGINNER', N'She got a gold bracelet as a gift.', N'Cô ấy được tặng vòng tay vàng.'),
(N'cap', N'/kæp/', N'mũ lưỡi trai', N'noun', N'BEGINNER', N'Wear a cap to protect from the sun.', N'Đội mũ lưỡi trai để che nắng.'),
(N'collar', N'/ˈkɒlər/', N'cổ áo', N'noun', N'BEGINNER', N'The collar of his shirt was dirty.', N'Cổ áo của anh ấy bị bẩn.'),
(N'costume', N'/ˈkɒstjuːm/', N'trang phục / trang phục hóa trang', N'noun', N'INTERMEDIATE', N'She wore a princess costume.', N'Cô ấy mặc trang phục công chúa.'),
(N'fabric', N'/ˈfæbrɪk/', N'vải / chất liệu', N'noun', N'INTERMEDIATE', N'This fabric is very soft.', N'Chất liệu này rất mềm.'),
(N'sleeve', N'/sliːv/', N'tay áo', N'noun', N'BEGINNER', N'Roll up your sleeves and get to work.', N'Xắn tay áo lên và bắt đầu làm việc.'),
(N'sweater', N'/ˈswetər/', N'áo len', N'noun', N'BEGINNER', N'Put on a sweater, it''s cold.', N'Mặc áo len vào, trời lạnh.'),
(N'uniform', N'/ˈjuːnɪfɔːrm/', N'đồng phục', N'noun', N'BEGINNER', N'Students wear a school uniform.', N'Học sinh mặc đồng phục trường.'),
(N'zipper', N'/ˈzɪpər/', N'dây kéo', N'noun', N'BEGINNER', N'The zipper is broken.', N'Dây kéo bị hỏng.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('task','technique','tend','term','theme','theory','threat','throughout','tool','topic','touch','tradition','transfer','trend','trust','typical','ultimately','unique','unit','update','utilize','valid','value','variety','version','victim','view','visible','vision','vital','volume','warn','weakness','wealth','welfare','whereas','wide','willing','wisdom','wonder','worth','yield','ankle','elbow','eyebrow','forehead','jaw','lung','palm','spine','temple','thumb','wrist','blouse','bracelet','cap','collar','costume','fabric','sleeve','sweater','uniform','zipper');
