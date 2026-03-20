--liquibase formatted sql

--changeset vocab:045-seed-words-batch38
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Advanced vocabulary (continued E-Z)
(N'eloquence', N'/ˈeləkwəns/', N'sự hùng hồn', N'noun', N'ADVANCED', N'Her eloquence moved the audience.', N'Sự hùng hồn của cô ấy làm khán giả xúc động.'),
(N'eminent', N'/ˈemɪnənt/', N'nổi tiếng / lỗi lạc', N'adjective', N'ADVANCED', N'He is an eminent scientist.', N'Anh ấy là một nhà khoa học lỗi lạc.'),
(N'encompass', N'/ɪnˈkʌmpəs/', N'bao gồm / bao quanh', N'verb', N'ADVANCED', N'The report encompasses all aspects.', N'Báo cáo bao gồm tất cả các khía cạnh.'),
(N'endeavor', N'/ɪnˈdevər/', N'nỗ lực / cố gắng', N'noun', N'ADVANCED', N'Her endeavor paid off in the end.', N'Nỗ lực của cô ấy được đền đáp.'),
(N'enigmatic', N'/ˌenɪɡˈmætɪk/', N'bí ẩn', N'adjective', N'ADVANCED', N'She had an enigmatic smile.', N'Cô ấy có nụ cười bí ẩn.'),
(N'ephemeral', N'/ɪˈfemərəl/', N'thoáng qua / ngắn ngủi', N'adjective', N'ADVANCED', N'Fame is often ephemeral.', N'Danh tiếng thường ngắn ngủi.'),
(N'equivocal', N'/ɪˈkwɪvəkəl/', N'mơ hồ / hai nghĩa', N'adjective', N'ADVANCED', N'His answer was equivocal.', N'Câu trả lời của anh ấy mơ hồ.'),
(N'erratic', N'/ɪˈrætɪk/', N'thất thường / khó đoán', N'adjective', N'ADVANCED', N'His behavior was erratic.', N'Hành vi của anh ấy thất thường.'),
(N'exacerbate', N'/ɪɡˈzæsərbeɪt/', N'làm trầm trọng thêm', N'verb', N'ADVANCED', N'Stress exacerbates health problems.', N'Căng thẳng làm trầm trọng thêm vấn đề sức khỏe.'),
(N'exemplary', N'/ɪɡˈzempləri/', N'gương mẫu', N'adjective', N'ADVANCED', N'She showed exemplary leadership.', N'Cô ấy thể hiện khả năng lãnh đạo gương mẫu.'),
(N'exert', N'/ɪɡˈzɜːrt/', N'vận dụng / gây áp lực', N'verb', N'ADVANCED', N'Exert yourself to reach your goals.', N'Nỗ lực hết mình để đạt mục tiêu.'),
(N'exhaustive', N'/ɪɡˈzɔːstɪv/', N'triệt để / toàn diện', N'adjective', N'ADVANCED', N'Conduct an exhaustive investigation.', N'Tiến hành điều tra triệt để.'),
(N'expedite', N'/ˈekspɪdaɪt/', N'đẩy nhanh', N'verb', N'ADVANCED', N'Expedite the approval process.', N'Đẩy nhanh quy trình phê duyệt.'),
(N'explicit', N'/ɪkˈsplɪsɪt/', N'tường minh / rõ ràng', N'adjective', N'ADVANCED', N'Give explicit instructions.', N'Đưa ra hướng dẫn tường minh.'),
(N'exploit', N'/ɪkˈsplɔɪt/', N'khai thác / lợi dụng', N'verb', N'INTERMEDIATE', N'Don''t exploit others for gain.', N'Đừng khai thác người khác để thu lợi.'),
(N'expunge', N'/ɪkˈspʌndʒ/', N'xóa bỏ / loại trừ', N'verb', N'ADVANCED', N'Expunge incorrect data from records.', N'Xóa dữ liệu sai khỏi hồ sơ.'),
(N'exquisite', N'/ˈekskwɪzɪt/', N'tuyệt đẹp / tinh tế', N'adjective', N'ADVANCED', N'The craftsmanship is exquisite.', N'Tay nghề thật tinh tế.'),
(N'extravagant', N'/ɪkˈstrævəɡənt/', N'xa xỉ / hoang phí', N'adjective', N'ADVANCED', N'Don''t be extravagant with money.', N'Đừng xa xỉ với tiền bạc.'),
(N'fabricate', N'/ˈfæbrɪkeɪt/', N'bịa đặt / chế tạo', N'verb', N'ADVANCED', N'He fabricated the story.', N'Anh ấy bịa ra câu chuyện.'),
(N'fallacy', N'/ˈfæləsi/', N'sự ngụy biện / sai lầm', N'noun', N'ADVANCED', N'Identify the fallacy in the argument.', N'Xác định sự ngụy biện trong lập luận.'),
(N'fanatical', N'/fəˈnætɪkəl/', N'cuồng tín / cực đoan', N'adjective', N'ADVANCED', N'He was fanatical about fitness.', N'Anh ấy cuồng tín về thể dục.'),
(N'fervent', N'/ˈfɜːrvənt/', N'nhiệt tình / sốt sắng', N'adjective', N'ADVANCED', N'She was a fervent supporter.', N'Cô ấy là người ủng hộ nhiệt tình.'),
(N'formidable', N'/ˈfɔːrmɪdəbəl/', N'đáng gờm', N'adjective', N'ADVANCED', N'She is a formidable opponent.', N'Cô ấy là đối thủ đáng gờm.'),
(N'forthright', N'/ˈfɔːrθraɪt/', N'thẳng thắn / thành thật', N'adjective', N'ADVANCED', N'He was forthright about his opinions.', N'Anh ấy thẳng thắn về ý kiến của mình.'),
(N'futile', N'/ˈfjuːtaɪl/', N'vô ích / không hiệu quả', N'adjective', N'ADVANCED', N'The attempt was futile.', N'Nỗ lực là vô ích.'),
(N'gregarious', N'/ɡrɪˈɡeəriəs/', N'thích giao thiệp / xã hội', N'adjective', N'ADVANCED', N'She is gregarious and outgoing.', N'Cô ấy thích giao thiệp và hướng ngoại.'),
(N'hackneyed', N'/ˈhæknid/', N'sáo rỗng / cũ kỹ', N'adjective', N'ADVANCED', N'The phrase has become hackneyed.', N'Cụm từ đã trở nên sáo rỗng.'),
(N'hamper', N'/ˈhæmpər/', N'cản trở', N'verb', N'ADVANCED', N'Bad weather hampered the rescue.', N'Thời tiết xấu cản trở công tác cứu nạn.'),
(N'haphazard', N'/ˌhæpˈhæzərd/', N'ngẫu nhiên / bừa bãi', N'adjective', N'ADVANCED', N'The plan was haphazard.', N'Kế hoạch bừa bãi.'),
(N'harbinger', N'/ˈhɑːrbɪndʒər/', N'điềm báo', N'noun', N'ADVANCED', N'Spring flowers are harbingers of warmth.', N'Hoa mùa xuân là điềm báo của hơi ấm.'),
(N'impede', N'/ɪmˈpiːd/', N'cản trở', N'verb', N'ADVANCED', N'Don''t impede progress.', N'Đừng cản trở tiến bộ.'),
(N'implicit', N'/ɪmˈplɪsɪt/', N'ngầm hiểu / hàm ý', N'adjective', N'ADVANCED', N'There was an implicit agreement.', N'Có một thỏa thuận ngầm.'),
(N'inadvertent', N'/ˌɪnədˈvɜːrtənt/', N'vô ý / không cố ý', N'adjective', N'ADVANCED', N'It was an inadvertent mistake.', N'Đó là lỗi vô ý.'),
(N'incite', N'/ɪnˈsaɪt/', N'kích động', N'verb', N'ADVANCED', N'Don''t incite violence.', N'Đừng kích động bạo lực.'),
(N'inconsequential', N'/ˌɪnkɒnsɪˈkwenʃəl/', N'không quan trọng', N'adjective', N'ADVANCED', N'The issue was inconsequential.', N'Vấn đề không quan trọng.'),
(N'indignant', N'/ɪnˈdɪɡnənt/', N'phẫn nộ / bất bình', N'adjective', N'ADVANCED', N'She was indignant at the unfair treatment.', N'Cô ấy bất bình vì cách đối xử không công bằng.'),
(N'indispensable', N'/ˌɪndɪˈspensəbəl/', N'không thể thiếu', N'adjective', N'ADVANCED', N'Water is indispensable for life.', N'Nước không thể thiếu cho sự sống.'),
(N'inept', N'/ɪˈnept/', N'thiếu năng lực', N'adjective', N'ADVANCED', N'An inept manager hurts the team.', N'Người quản lý thiếu năng lực gây hại cho nhóm.'),
(N'inexorable', N'/ɪˈneksərəbəl/', N'không thể ngăn chặn', N'adjective', N'ADVANCED', N'Time''s passage is inexorable.', N'Sự trôi qua của thời gian không thể ngăn chặn.'),
(N'infallible', N'/ɪnˈfæləbəl/', N'không thể sai / hoàn hảo', N'adjective', N'ADVANCED', N'No system is infallible.', N'Không có hệ thống nào hoàn hảo.'),
(N'ingenuity', N'/ˌɪndʒɪˈnjuːɪti/', N'sự khéo léo / sáng tạo', N'noun', N'ADVANCED', N'Her ingenuity solved the problem.', N'Sự khéo léo của cô ấy đã giải quyết vấn đề.'),
(N'inherent', N'/ɪnˈhɪərənt/', N'vốn có / bản chất', N'adjective', N'ADVANCED', N'There are inherent risks in business.', N'Có những rủi ro vốn có trong kinh doanh.'),
(N'inordinate', N'/ɪˈnɔːrdɪnɪt/', N'quá mức / thái quá', N'adjective', N'ADVANCED', N'An inordinate amount of time was wasted.', N'Một lượng thời gian quá mức đã bị lãng phí.'),
(N'insatiable', N'/ɪnˈseɪʃəbəl/', N'không thể thỏa mãn', N'adjective', N'ADVANCED', N'She has an insatiable curiosity.', N'Cô ấy có sự tò mò không thể thỏa mãn.'),
(N'intricate', N'/ˈɪntrɪkɪt/', N'phức tạp / tinh vi', N'adjective', N'ADVANCED', N'The design is intricate and beautiful.', N'Thiết kế phức tạp và đẹp.'),
(N'judicious', N'/dʒuːˈdɪʃəs/', N'sáng suốt / khôn ngoan', N'adjective', N'ADVANCED', N'Make judicious use of resources.', N'Sử dụng tài nguyên một cách khôn ngoan.'),
(N'laconic', N'/ləˈkɒnɪk/', N'ngắn gọn / kiệm lời', N'adjective', N'ADVANCED', N'His laconic reply was unexpected.', N'Câu trả lời kiệm lời của anh ấy thật bất ngờ.'),
(N'latent', N'/ˈleɪtənt/', N'tiềm ẩn', N'adjective', N'ADVANCED', N'Discover your latent talents.', N'Khám phá tài năng tiềm ẩn của bạn.'),
(N'lethargic', N'/lɪˈθɑːrdʒɪk/', N'uể oải / mệt mỏi', N'adjective', N'ADVANCED', N'He felt lethargic after the meal.', N'Anh ấy cảm thấy uể oải sau bữa ăn.'),
(N'lucid', N'/ˈluːsɪd/', N'rõ ràng / sáng suốt', N'adjective', N'ADVANCED', N'Give a lucid explanation.', N'Đưa ra giải thích rõ ràng.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('eloquence','eminent','encompass','endeavor','enigmatic','ephemeral','equivocal','erratic','exacerbate','exemplary','exert','exhaustive','expedite','exploit','expunge','exquisite','extravagant','fabricate','fallacy','fanatical','fervent','formidable','forthright','futile','gregarious','hackneyed','hamper','haphazard','harbinger','impede','implicit','inadvertent','incite','inconsequential','indignant','indispensable','inept','inexorable','infallible','ingenuity','inherent','inordinate','insatiable','intricate','judicious','laconic','latent','lethargic','lucid');
