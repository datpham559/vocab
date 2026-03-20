--liquibase formatted sql

--changeset vocab:046-seed-words-batch39
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Advanced vocabulary M-Z
(N'magnanimous', N'/mæɡˈnænɪməs/', N'độ lượng / rộng lượng', N'adjective', N'ADVANCED', N'She was magnanimous in victory.', N'Cô ấy rộng lượng khi chiến thắng.'),
(N'malevolent', N'/məˈlevələnt/', N'ác ý / độc ác', N'adjective', N'ADVANCED', N'A malevolent smile crossed his face.', N'Nụ cười ác ý hiện trên mặt anh ấy.'),
(N'meticulous', N'/mɪˈtɪkjʊləs/', N'cẩn thận tỉ mỉ', N'adjective', N'ADVANCED', N'He is meticulous about details.', N'Anh ấy cẩn thận tỉ mỉ về chi tiết.'),
(N'mitigate', N'/ˈmɪtɪɡeɪt/', N'giảm nhẹ / làm dịu', N'verb', N'ADVANCED', N'Mitigate risks before they occur.', N'Giảm nhẹ rủi ro trước khi chúng xảy ra.'),
(N'mundane', N'/mʌnˈdeɪn/', N'tầm thường / nhàm chán', N'adjective', N'ADVANCED', N'Even mundane tasks require focus.', N'Ngay cả những nhiệm vụ tầm thường cũng cần tập trung.'),
(N'nefarious', N'/nɪˈfeəriəs/', N'gian xảo / độc ác', N'adjective', N'ADVANCED', N'The nefarious plan was exposed.', N'Kế hoạch gian xảo đã bị phanh phui.'),
(N'negligent', N'/ˈneɡlɪdʒənt/', N'bất cẩn / cẩu thả', N'adjective', N'ADVANCED', N'Negligent behavior causes accidents.', N'Hành vi bất cẩn gây ra tai nạn.'),
(N'nonchalant', N'/ˌnɒnʃəˈlɑːnt/', N'thờ ơ / bình thản', N'adjective', N'ADVANCED', N'She was nonchalant about the news.', N'Cô ấy thờ ơ với tin tức.'),
(N'oblivious', N'/əˈblɪviəs/', N'không để ý / quên lãng', N'adjective', N'ADVANCED', N'He was oblivious to the danger.', N'Anh ấy không để ý đến nguy hiểm.'),
(N'obstinate', N'/ˈɒbstɪnɪt/', N'bướng bỉnh', N'adjective', N'ADVANCED', N'He was obstinate in his refusal.', N'Anh ấy bướng bỉnh trong sự từ chối.'),
(N'ominous', N'/ˈɒmɪnəs/', N'điềm gở / đáng lo ngại', N'adjective', N'ADVANCED', N'Dark clouds looked ominous.', N'Những đám mây đen trông điềm gở.'),
(N'opaque', N'/oʊˈpeɪk/', N'mờ đục / khó hiểu', N'adjective', N'ADVANCED', N'The instructions were opaque.', N'Hướng dẫn khó hiểu.'),
(N'ostensible', N'/ɒˈstensɪbəl/', N'bề ngoài / có vẻ', N'adjective', N'ADVANCED', N'His ostensible reason was believable.', N'Lý do bề ngoài của anh ấy có vẻ đáng tin.'),
(N'overt', N'/oʊˈvɜːrt/', N'công khai / lộ liễu', N'adjective', N'ADVANCED', N'His overt hostility surprised all.', N'Sự thù địch công khai của anh ấy làm tất cả ngạc nhiên.'),
(N'paradigm', N'/ˈpærədaɪm/', N'mô hình / khuôn mẫu', N'noun', N'ADVANCED', N'A paradigm shift changed the field.', N'Sự thay đổi mô hình đã thay đổi lĩnh vực.'),
(N'paradox', N'/ˈpærədɒks/', N'nghịch lý', N'noun', N'ADVANCED', N'Life is full of paradoxes.', N'Cuộc sống đầy nghịch lý.'),
(N'partisan', N'/ˈpɑːrtɪzæn/', N'thiên vị / đảng phái', N'adjective', N'ADVANCED', N'Avoid partisan politics.', N'Tránh chính trị đảng phái.'),
(N'patronize', N'/ˈpeɪtrənaɪz/', N'bảo trợ / cư xử trịch thượng', N'verb', N'ADVANCED', N'Don''t patronize younger colleagues.', N'Đừng cư xử trịch thượng với đồng nghiệp trẻ hơn.'),
(N'pernicious', N'/pəˈnɪʃəs/', N'nguy hại', N'adjective', N'ADVANCED', N'Pernicious habits are hard to break.', N'Thói quen nguy hại khó bỏ.'),
(N'pertinent', N'/ˈpɜːrtɪnənt/', N'thích hợp / liên quan', N'adjective', N'ADVANCED', N'Only pertinent information was shared.', N'Chỉ thông tin liên quan được chia sẻ.'),
(N'placid', N'/ˈplæsɪd/', N'bình thản / yên tĩnh', N'adjective', N'ADVANCED', N'She remained placid under pressure.', N'Cô ấy vẫn bình thản dưới áp lực.'),
(N'plausible', N'/ˈplɔːzɪbəl/', N'có lý / đáng tin', N'adjective', N'ADVANCED', N'Her alibi was plausible.', N'Bằng chứng ngoại phạm của cô ấy có lý.'),
(N'pompous', N'/ˈpɒmpəs/', N'kiêu ngạo / khoa trương', N'adjective', N'ADVANCED', N'His pompous attitude annoyed people.', N'Thái độ kiêu ngạo của anh ấy làm khó chịu.'),
(N'pragmatic', N'/præɡˈmætɪk/', N'thực dụng', N'adjective', N'ADVANCED', N'Take a pragmatic approach.', N'Áp dụng cách tiếp cận thực dụng.'),
(N'precipitate', N'/prɪˈsɪpɪteɪt/', N'thúc đẩy vội vàng / gây ra đột ngột', N'verb', N'ADVANCED', N'Don''t precipitate a crisis.', N'Đừng gây ra khủng hoảng vội vàng.'),
(N'precocious', N'/prɪˈkoʊʃəs/', N'sớm phát triển', N'adjective', N'ADVANCED', N'She was a precocious child.', N'Cô ấy là một đứa trẻ sớm phát triển.'),
(N'presumptuous', N'/prɪˈzʌmptʃuəs/', N'kiêu ngạo / thái quá', N'adjective', N'ADVANCED', N'It was presumptuous of him to assume.', N'Anh ấy kiêu ngạo khi cho rằng như vậy.'),
(N'prevalent', N'/ˈprevələnt/', N'phổ biến', N'adjective', N'ADVANCED', N'This disease is prevalent here.', N'Bệnh này rất phổ biến ở đây.'),
(N'prodigious', N'/prəˈdɪdʒəs/', N'phi thường / khổng lồ', N'adjective', N'ADVANCED', N'He had a prodigious memory.', N'Anh ấy có trí nhớ phi thường.'),
(N'proliferate', N'/prəˈlɪfəreɪt/', N'sinh sôi nảy nở / lan rộng', N'verb', N'ADVANCED', N'Social media platforms proliferate.', N'Các nền tảng mạng xã hội ngày càng lan rộng.'),
(N'propitious', N'/prəˈpɪʃəs/', N'thuận lợi / may mắn', N'adjective', N'ADVANCED', N'The timing was propitious.', N'Thời điểm thật thuận lợi.'),
(N'prudent', N'/ˈpruːdənt/', N'cẩn trọng / khôn ngoan', N'adjective', N'ADVANCED', N'A prudent investor diversifies.', N'Nhà đầu tư khôn ngoan đa dạng hóa.'),
(N'querulous', N'/ˈkwerʊləs/', N'hay phàn nàn', N'adjective', N'ADVANCED', N'She became querulous when tired.', N'Cô ấy trở nên hay phàn nàn khi mệt mỏi.'),
(N'recalcitrant', N'/rɪˈkælsɪtrənt/', N'bất phục / khó bảo', N'adjective', N'ADVANCED', N'The recalcitrant student refused to listen.', N'Học sinh bất phục từ chối lắng nghe.'),
(N'reclusive', N'/rɪˈkluːsɪv/', N'ẩn dật / xa lánh xã hội', N'adjective', N'ADVANCED', N'He became reclusive after retirement.', N'Anh ấy trở nên ẩn dật sau khi nghỉ hưu.'),
(N'rectify', N'/ˈrektɪfaɪ/', N'sửa chữa / khắc phục', N'verb', N'ADVANCED', N'Rectify the error immediately.', N'Khắc phục lỗi ngay lập tức.'),
(N'redundant', N'/rɪˈdʌndənt/', N'thừa thãi / dư thừa', N'adjective', N'ADVANCED', N'Remove redundant information.', N'Loại bỏ thông tin thừa thãi.'),
(N'refute', N'/rɪˈfjuːt/', N'bác bỏ', N'verb', N'ADVANCED', N'Refute the claim with evidence.', N'Bác bỏ tuyên bố bằng bằng chứng.'),
(N'reprehensible', N'/ˌreprɪˈhensɪbəl/', N'đáng chê trách', N'adjective', N'ADVANCED', N'Bullying is reprehensible.', N'Bắt nạt là điều đáng chê trách.'),
(N'resilience', N'/rɪˈzɪliəns/', N'khả năng phục hồi', N'noun', N'ADVANCED', N'Build resilience through hardship.', N'Xây dựng khả năng phục hồi qua gian khó.'),
(N'reticent', N'/ˈretɪsənt/', N'ít nói / kín đáo', N'adjective', N'ADVANCED', N'She was reticent about her past.', N'Cô ấy kín đáo về quá khứ.'),
(N'rigorous', N'/ˈrɪɡərəs/', N'nghiêm ngặt / kỹ lưỡng', N'adjective', N'ADVANCED', N'Rigorous testing ensures quality.', N'Kiểm tra kỹ lưỡng đảm bảo chất lượng.'),
(N'rudimentary', N'/ˌruːdɪˈmentəri/', N'sơ cấp / cơ bản', N'adjective', N'ADVANCED', N'She had only rudimentary knowledge.', N'Cô ấy chỉ có kiến thức sơ cấp.'),
(N'scrutinize', N'/ˈskruːtɪnaɪz/', N'xem xét kỹ lưỡng', N'verb', N'ADVANCED', N'Scrutinize every detail carefully.', N'Xem xét kỹ từng chi tiết.'),
(N'spurious', N'/ˈspjʊəriəs/', N'giả mạo / không có cơ sở', N'adjective', N'ADVANCED', N'His claims were spurious.', N'Tuyên bố của anh ấy không có cơ sở.'),
(N'stoic', N'/ˈstoʊɪk/', N'điềm tĩnh / khắc kỷ', N'adjective', N'ADVANCED', N'He remained stoic throughout.', N'Anh ấy vẫn điềm tĩnh xuyên suốt.'),
(N'subversive', N'/səbˈvɜːrsɪv/', N'phá hoại / lật đổ', N'adjective', N'ADVANCED', N'The subversive group was monitored.', N'Nhóm phá hoại bị giám sát.'),
(N'tenacious', N'/tɪˈneɪʃəs/', N'kiên gan / bền bỉ', N'adjective', N'ADVANCED', N'A tenacious fighter never gives up.', N'Người chiến đấu kiên gan không bao giờ bỏ cuộc.'),
(N'transient', N'/ˈtrænziənt/', N'tạm thời / ngắn ngủi', N'adjective', N'ADVANCED', N'Happiness can be transient.', N'Hạnh phúc có thể là tạm thời.'),
(N'ubiquitous', N'/juːˈbɪkwɪtəs/', N'có mặt khắp nơi', N'adjective', N'ADVANCED', N'Smartphones are ubiquitous today.', N'Điện thoại thông minh có mặt khắp nơi ngày nay.'),
(N'unequivocal', N'/ˌʌnɪˈkwɪvəkəl/', N'rõ ràng / không nghi ngờ', N'adjective', N'ADVANCED', N'She gave an unequivocal answer.', N'Cô ấy đưa ra câu trả lời rõ ràng.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('magnanimous','malevolent','mitigate','mundane','nefarious','negligent','nonchalant','oblivious','obstinate','ominous','opaque','ostensible','overt','paradigm','paradox','partisan','patronize','pernicious','pertinent','placid','plausible','pompous','pragmatic','precipitate','precocious','presumptuous','prevalent','prodigious','proliferate','propitious','prudent','querulous','recalcitrant','reclusive','rectify','redundant','refute','reprehensible','resilience','reticent','rigorous','rudimentary','scrutinize','spurious','stoic','subversive','tenacious','transient','ubiquitous','unequivocal');
