--liquibase formatted sql

--changeset vocab:035-seed-words-batch28
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Common Verbs (high frequency)
(N'accomplish', N'/əˈkɒmplɪʃ/', N'hoàn thành / đạt được', N'verb', N'INTERMEDIATE', N'Accomplish your goals step by step.', N'Đạt được mục tiêu từng bước một.'),
(N'acknowledge', N'/əkˈnɒlɪdʒ/', N'thừa nhận / công nhận', N'verb', N'INTERMEDIATE', N'Acknowledge your mistakes.', N'Thừa nhận lỗi lầm của bạn.'),
(N'acquire', N'/əˈkwaɪər/', N'thu thập / đạt được', N'verb', N'INTERMEDIATE', N'Acquire new skills every year.', N'Thu thập kỹ năng mới mỗi năm.'),
(N'adapt', N'/əˈdæpt/', N'thích nghi', N'verb', N'INTERMEDIATE', N'Adapt to new environments quickly.', N'Thích nghi với môi trường mới nhanh chóng.'),
(N'adopt', N'/əˈdɒpt/', N'nhận nuôi / áp dụng', N'verb', N'INTERMEDIATE', N'Adopt a new approach to the problem.', N'Áp dụng cách tiếp cận mới cho vấn đề.'),
(N'affect', N'/əˈfekt/', N'ảnh hưởng đến', N'verb', N'BEGINNER', N'Stress can affect your health.', N'Căng thẳng có thể ảnh hưởng đến sức khỏe.'),
(N'allocate', N'/ˈæləkeɪt/', N'phân bổ', N'verb', N'ADVANCED', N'Allocate resources efficiently.', N'Phân bổ tài nguyên hiệu quả.'),
(N'alter', N'/ˈɔːltər/', N'thay đổi / sửa đổi', N'verb', N'INTERMEDIATE', N'Alter your plans if needed.', N'Thay đổi kế hoạch nếu cần.'),
(N'anticipate', N'/ænˈtɪsɪpeɪt/', N'dự đoán / mong đợi', N'verb', N'INTERMEDIATE', N'Anticipate problems before they occur.', N'Dự đoán vấn đề trước khi chúng xảy ra.'),
(N'assess', N'/əˈses/', N'đánh giá / nhận xét', N'verb', N'INTERMEDIATE', N'Assess your strengths and weaknesses.', N'Đánh giá điểm mạnh và điểm yếu của bạn.'),
(N'assume', N'/əˈsjuːm/', N'cho rằng / đảm nhận', N'verb', N'INTERMEDIATE', N'Don''t assume without checking.', N'Đừng cho rằng mà không kiểm tra.'),
(N'clarify', N'/ˈklærɪfaɪ/', N'làm rõ', N'verb', N'INTERMEDIATE', N'Clarify your instructions.', N'Làm rõ hướng dẫn của bạn.'),
(N'collaborate', N'/kəˈlæbəreɪt/', N'hợp tác', N'verb', N'INTERMEDIATE', N'Collaborate with your team.', N'Hợp tác với nhóm của bạn.'),
(N'communicate', N'/kəˈmjuːnɪkeɪt/', N'giao tiếp', N'verb', N'BEGINNER', N'Communicate clearly and often.', N'Giao tiếp rõ ràng và thường xuyên.'),
(N'compensate', N'/ˈkɒmpenseɪt/', N'bồi thường / đền bù', N'verb', N'INTERMEDIATE', N'The company compensated for the delay.', N'Công ty bồi thường vì sự chậm trễ.'),
(N'concentrate', N'/ˈkɒnsəntreɪt/', N'tập trung', N'verb', N'BEGINNER', N'Concentrate on one task at a time.', N'Tập trung vào một nhiệm vụ mỗi lần.'),
(N'confirm', N'/kənˈfɜːrm/', N'xác nhận', N'verb', N'INTERMEDIATE', N'Confirm your reservation.', N'Xác nhận đặt chỗ của bạn.'),
(N'consent', N'/kənˈsent/', N'đồng ý / cho phép', N'verb', N'INTERMEDIATE', N'Get consent before proceeding.', N'Xin sự đồng ý trước khi tiến hành.'),
(N'coordinate', N'/koʊˈɔːrdɪneɪt/', N'phối hợp', N'verb', N'INTERMEDIATE', N'Coordinate with all departments.', N'Phối hợp với tất cả các phòng ban.'),
(N'criticize', N'/ˈkrɪtɪsaɪz/', N'chỉ trích', N'verb', N'INTERMEDIATE', N'Criticize constructively.', N'Chỉ trích mang tính xây dựng.'),
(N'dedicate', N'/ˈdedɪkeɪt/', N'cống hiến / dành tặng', N'verb', N'INTERMEDIATE', N'Dedicate time to your goals.', N'Dành thời gian cho mục tiêu của bạn.'),
(N'demonstrate', N'/ˈdemənstreɪt/', N'trình bày / biểu tình', N'verb', N'INTERMEDIATE', N'Demonstrate your skills clearly.', N'Trình bày kỹ năng của bạn rõ ràng.'),
(N'differentiate', N'/ˌdɪfəˈrenʃieɪt/', N'phân biệt', N'verb', N'INTERMEDIATE', N'Differentiate between the two options.', N'Phân biệt giữa hai lựa chọn.'),
(N'distribute', N'/dɪˈstrɪbjuːt/', N'phân phối', N'verb', N'INTERMEDIATE', N'Distribute the tasks equally.', N'Phân phối nhiệm vụ đều nhau.'),
(N'emphasize', N'/ˈemfəsaɪz/', N'nhấn mạnh', N'verb', N'INTERMEDIATE', N'Emphasize the main points.', N'Nhấn mạnh các điểm chính.'),
(N'evaluate', N'/ɪˈvæljueɪt/', N'đánh giá', N'verb', N'INTERMEDIATE', N'Evaluate the results after testing.', N'Đánh giá kết quả sau khi kiểm tra.'),
(N'exceed', N'/ɪkˈsiːd/', N'vượt quá', N'verb', N'INTERMEDIATE', N'Don''t exceed the speed limit.', N'Đừng vượt quá giới hạn tốc độ.'),
(N'execute', N'/ˈeksɪkjuːt/', N'thực thi', N'verb', N'INTERMEDIATE', N'Execute the plan efficiently.', N'Thực thi kế hoạch hiệu quả.'),
(N'facilitate', N'/fəˈsɪlɪteɪt/', N'tạo điều kiện', N'verb', N'ADVANCED', N'Facilitate the discussion.', N'Tạo điều kiện cho cuộc thảo luận.'),
(N'generate', N'/ˈdʒenəreɪt/', N'tạo ra', N'verb', N'INTERMEDIATE', N'Generate new ideas regularly.', N'Tạo ra ý tưởng mới thường xuyên.'),
(N'implement', N'/ˈɪmplɪment/', N'thực hiện', N'verb', N'INTERMEDIATE', N'Implement the strategy immediately.', N'Thực hiện chiến lược ngay lập tức.'),
(N'improve', N'/ɪmˈpruːv/', N'cải thiện', N'verb', N'BEGINNER', N'Always look to improve yourself.', N'Luôn tìm cách cải thiện bản thân.'),
(N'integrate', N'/ˈɪntɪɡreɪt/', N'tích hợp / hội nhập', N'verb', N'INTERMEDIATE', N'Integrate technology into learning.', N'Tích hợp công nghệ vào học tập.'),
(N'interpret', N'/ɪnˈtɜːrprɪt/', N'diễn giải / phiên dịch', N'verb', N'INTERMEDIATE', N'Interpret the data correctly.', N'Diễn giải dữ liệu chính xác.'),
(N'justify', N'/ˈdʒʌstɪfaɪ/', N'biện hộ / giải thích', N'verb', N'INTERMEDIATE', N'Justify your decision.', N'Giải thích quyết định của bạn.'),
(N'manage', N'/ˈmænɪdʒ/', N'quản lý', N'verb', N'BEGINNER', N'Manage your time wisely.', N'Quản lý thời gian một cách khôn ngoan.'),
(N'maximize', N'/ˈmæksɪmaɪz/', N'tối đa hóa', N'verb', N'INTERMEDIATE', N'Maximize your productivity.', N'Tối đa hóa năng suất của bạn.'),
(N'minimize', N'/ˈmɪnɪmaɪz/', N'giảm thiểu tối đa', N'verb', N'INTERMEDIATE', N'Minimize waste in production.', N'Giảm thiểu lãng phí trong sản xuất.'),
(N'motivate', N'/ˈmoʊtɪveɪt/', N'thúc đẩy / tạo động lực', N'verb', N'INTERMEDIATE', N'Motivate your team every day.', N'Tạo động lực cho đội của bạn mỗi ngày.'),
(N'negotiate', N'/nɪˈɡoʊʃieɪt/', N'đàm phán', N'verb', N'INTERMEDIATE', N'Negotiate for a better price.', N'Đàm phán để có giá tốt hơn.'),
(N'optimize', N'/ˈɒptɪmaɪz/', N'tối ưu hóa', N'verb', N'INTERMEDIATE', N'Optimize your workflow.', N'Tối ưu hóa quy trình làm việc.'),
(N'organize', N'/ˈɔːrɡənaɪz/', N'tổ chức / sắp xếp', N'verb', N'BEGINNER', N'Organize your desk before working.', N'Dọn dẹp bàn làm việc trước khi làm.'),
(N'overcome', N'/ˌoʊvərˈkʌm/', N'chinh phục / vượt qua', N'verb', N'INTERMEDIATE', N'Overcome your fears bravely.', N'Dũng cảm vượt qua nỗi sợ của bạn.'),
(N'prioritize', N'/praɪˈɒrɪtaɪz/', N'ưu tiên', N'verb', N'INTERMEDIATE', N'Prioritize tasks by importance.', N'Ưu tiên nhiệm vụ theo tầm quan trọng.'),
(N'quantify', N'/ˈkwɒntɪfaɪ/', N'định lượng', N'verb', N'ADVANCED', N'Quantify the benefits of the change.', N'Định lượng lợi ích của sự thay đổi.'),
(N'reinforce', N'/ˌriːɪnˈfɔːrs/', N'củng cố', N'verb', N'INTERMEDIATE', N'Reinforce good habits daily.', N'Củng cố thói quen tốt mỗi ngày.'),
(N'simplify', N'/ˈsɪmplɪfaɪ/', N'đơn giản hóa', N'verb', N'INTERMEDIATE', N'Simplify your message.', N'Đơn giản hóa thông điệp của bạn.'),
(N'summarize', N'/ˈsʌməraɪz/', N'tóm tắt', N'verb', N'INTERMEDIATE', N'Summarize the key points.', N'Tóm tắt các điểm chính.'),
(N'transform', N'/trænsˈfɔːrm/', N'biến đổi', N'verb', N'INTERMEDIATE', N'Transform your habits for the better.', N'Biến đổi thói quen của bạn theo hướng tốt hơn.'),
(N'validate', N'/ˈvælɪdeɪt/', N'xác nhận / kiểm định', N'verb', N'INTERMEDIATE', N'Validate your assumptions with data.', N'Xác nhận giả định bằng dữ liệu.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('accomplish','acknowledge','acquire','adapt','adopt','affect','allocate','alter','anticipate','assess','assume','clarify','collaborate','communicate','compensate','concentrate','confirm','consent','coordinate','criticize','dedicate','demonstrate','differentiate','distribute','emphasize','evaluate','exceed','execute','facilitate','generate','implement','improve','integrate','interpret','justify','manage','maximize','minimize','motivate','negotiate','optimize','organize','prioritize','quantify','reinforce','simplify','summarize','transform','validate');
