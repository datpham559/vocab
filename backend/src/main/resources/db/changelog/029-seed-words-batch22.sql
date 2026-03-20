--liquibase formatted sql

--changeset vocab:029-seed-words-batch22
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Health & Medicine
(N'ache', N'/eɪk/', N'đau nhức', N'noun', N'BEGINNER', N'I have a headache today.', N'Hôm nay tôi bị đau đầu.'),
(N'allergy', N'/ˈælədʒi/', N'dị ứng', N'noun', N'INTERMEDIATE', N'She has an allergy to peanuts.', N'Cô ấy bị dị ứng với lạc.'),
(N'ambulance', N'/ˈæmbjʊləns/', N'xe cấp cứu', N'noun', N'BEGINNER', N'Call an ambulance immediately.', N'Gọi xe cấp cứu ngay.'),
(N'antibiotic', N'/ˌæntibaɪˈɒtɪk/', N'kháng sinh', N'noun', N'INTERMEDIATE', N'The doctor prescribed antibiotics.', N'Bác sĩ kê đơn kháng sinh.'),
(N'bandage', N'/ˈbændɪdʒ/', N'băng bó', N'noun', N'BEGINNER', N'Wrap the wound with a bandage.', N'Băng bó vết thương.'),
(N'blood pressure', N'/blʌd ˈpreʃər/', N'huyết áp', N'noun', N'INTERMEDIATE', N'Check your blood pressure regularly.', N'Kiểm tra huyết áp thường xuyên.'),
(N'capsule', N'/ˈkæpsjuːl/', N'viên nang', N'noun', N'INTERMEDIATE', N'Take one capsule after meals.', N'Uống một viên nang sau bữa ăn.'),
(N'clinic', N'/ˈklɪnɪk/', N'phòng khám', N'noun', N'BEGINNER', N'Visit the clinic for a checkup.', N'Đến phòng khám để khám tổng quát.'),
(N'contagious', N'/kənˈteɪdʒəs/', N'dễ lây lan', N'adjective', N'INTERMEDIATE', N'The flu is highly contagious.', N'Cúm rất dễ lây lan.'),
(N'diagnose', N'/ˌdaɪəɡˈnoʊz/', N'chẩn đoán', N'verb', N'INTERMEDIATE', N'The doctor diagnosed her with diabetes.', N'Bác sĩ chẩn đoán cô ấy mắc bệnh tiểu đường.'),
(N'disinfect', N'/ˌdɪsɪnˈfekt/', N'khử trùng', N'verb', N'INTERMEDIATE', N'Disinfect the wound before bandaging.', N'Khử trùng vết thương trước khi băng.'),
(N'dizzy', N'/ˈdɪzi/', N'chóng mặt', N'adjective', N'BEGINNER', N'I feel dizzy after spinning.', N'Tôi cảm thấy chóng mặt sau khi quay.'),
(N'dosage', N'/ˈdoʊsɪdʒ/', N'liều lượng', N'noun', N'INTERMEDIATE', N'Follow the correct dosage.', N'Thực hiện đúng liều lượng.'),
(N'exhaust', N'/ɪɡˈzɔːst/', N'kiệt sức', N'verb', N'INTERMEDIATE', N'Don''t exhaust yourself with overwork.', N'Đừng kiệt sức vì làm việc quá sức.'),
(N'fracture', N'/ˈfræktʃər/', N'gãy xương', N'noun', N'INTERMEDIATE', N'She had a fracture in her arm.', N'Cô ấy bị gãy xương tay.'),
(N'hygiene', N'/ˈhaɪdʒiːn/', N'vệ sinh', N'noun', N'INTERMEDIATE', N'Good hygiene prevents disease.', N'Vệ sinh tốt ngăn ngừa bệnh tật.'),
(N'immune', N'/ɪˈmjuːn/', N'miễn dịch', N'adjective', N'INTERMEDIATE', N'Build a strong immune system.', N'Xây dựng hệ miễn dịch mạnh.'),
(N'injection', N'/ɪnˈdʒekʃən/', N'mũi tiêm', N'noun', N'BEGINNER', N'The child cried after the injection.', N'Đứa trẻ khóc sau mũi tiêm.'),
(N'insomnia', N'/ɪnˈsɒmniə/', N'mất ngủ', N'noun', N'INTERMEDIATE', N'Insomnia can affect performance.', N'Mất ngủ có thể ảnh hưởng đến hiệu suất.'),
(N'nausea', N'/ˈnɔːziə/', N'buồn nôn', N'noun', N'INTERMEDIATE', N'She felt nausea on the boat.', N'Cô ấy cảm thấy buồn nôn trên tàu.'),
(N'nutrition', N'/njuːˈtrɪʃən/', N'dinh dưỡng', N'noun', N'INTERMEDIATE', N'Good nutrition is key to health.', N'Dinh dưỡng tốt là chìa khóa cho sức khỏe.'),
(N'obese', N'/oʊˈbiːs/', N'béo phì', N'adjective', N'INTERMEDIATE', N'An obese person faces health risks.', N'Người béo phì đối mặt với nguy cơ sức khỏe.'),
(N'paramedic', N'/ˌpærəˈmedɪk/', N'nhân viên cấp cứu', N'noun', N'INTERMEDIATE', N'The paramedic arrived quickly.', N'Nhân viên cấp cứu đến nhanh.'),
(N'prescription', N'/prɪˈskrɪpʃən/', N'đơn thuốc', N'noun', N'INTERMEDIATE', N'You need a prescription for this.', N'Bạn cần đơn thuốc cho cái này.'),
(N'rash', N'/ræʃ/', N'phát ban', N'noun', N'BEGINNER', N'The rash disappeared after treatment.', N'Phát ban biến mất sau khi điều trị.'),
(N'recovery', N'/rɪˈkʌvəri/', N'sự hồi phục', N'noun', N'INTERMEDIATE', N'His recovery was faster than expected.', N'Sự hồi phục của anh ấy nhanh hơn dự kiến.'),
(N'remedy', N'/ˈremədi/', N'phương thuốc / biện pháp', N'noun', N'INTERMEDIATE', N'Honey is a natural remedy for cough.', N'Mật ong là phương thuốc tự nhiên cho ho.'),
(N'stitch', N'/stɪtʃ/', N'mũi khâu', N'noun', N'INTERMEDIATE', N'The cut needed three stitches.', N'Vết cắt cần ba mũi khâu.'),
(N'symptom', N'/ˈsɪmptəm/', N'triệu chứng', N'noun', N'INTERMEDIATE', N'What are your symptoms?', N'Triệu chứng của bạn là gì?'),
(N'therapy', N'/ˈθerəpi/', N'liệu pháp', N'noun', N'INTERMEDIATE', N'Physical therapy helped her recover.', N'Vật lý trị liệu giúp cô ấy hồi phục.'),
(N'transplant', N'/ˈtrænsplɑːnt/', N'ghép tạng', N'noun', N'ADVANCED', N'He received a heart transplant.', N'Anh ấy được ghép tim.'),
(N'vaccine', N'/ˈvæksiːn/', N'vắc-xin', N'noun', N'INTERMEDIATE', N'Get vaccinated to stay healthy.', N'Tiêm phòng để khỏe mạnh.'),
-- Thematic: Law & Government
(N'attorney', N'/əˈtɜːrni/', N'luật sư', N'noun', N'INTERMEDIATE', N'Hire an attorney for legal advice.', N'Thuê luật sư để tư vấn pháp lý.'),
(N'bail', N'/beɪl/', N'tiền bảo lãnh', N'noun', N'INTERMEDIATE', N'He was released on bail.', N'Anh ấy được tại ngoại.'),
(N'ballot', N'/ˈbælət/', N'phiếu bầu', N'noun', N'INTERMEDIATE', N'Cast your ballot on election day.', N'Bỏ phiếu vào ngày bầu cử.'),
(N'ban', N'/bæn/', N'lệnh cấm', N'noun', N'INTERMEDIATE', N'A ban on plastic bags was introduced.', N'Lệnh cấm túi nhựa được ban hành.'),
(N'candidate', N'/ˈkændɪdeɪt/', N'ứng viên / ứng cử viên', N'noun', N'INTERMEDIATE', N'Each candidate gave a speech.', N'Mỗi ứng cử viên có bài phát biểu.'),
(N'clause', N'/klɔːz/', N'điều khoản', N'noun', N'INTERMEDIATE', N'Read every clause of the contract.', N'Đọc mỗi điều khoản trong hợp đồng.'),
(N'constitution', N'/ˌkɒnstɪˈtjuːʃən/', N'hiến pháp', N'noun', N'INTERMEDIATE', N'The constitution protects civil rights.', N'Hiến pháp bảo vệ quyền công dân.'),
(N'council', N'/ˈkaʊnsəl/', N'hội đồng', N'noun', N'INTERMEDIATE', N'The city council voted on the issue.', N'Hội đồng thành phố bỏ phiếu về vấn đề.'),
(N'court', N'/kɔːrt/', N'tòa án', N'noun', N'INTERMEDIATE', N'The case went to court.', N'Vụ kiện đưa ra tòa.'),
(N'defendant', N'/dɪˈfendənt/', N'bị cáo', N'noun', N'INTERMEDIATE', N'The defendant pleaded not guilty.', N'Bị cáo kêu không có tội.'),
(N'enforce', N'/ɪnˈfɔːrs/', N'thực thi', N'verb', N'INTERMEDIATE', N'Police enforce the law.', N'Cảnh sát thực thi pháp luật.'),
(N'federal', N'/ˈfedərəl/', N'liên bang', N'adjective', N'INTERMEDIATE', N'A federal court handles the case.', N'Tòa án liên bang xử lý vụ án.'),
(N'legislation', N'/ˌledʒɪˈsleɪʃən/', N'pháp luật / lập pháp', N'noun', N'ADVANCED', N'New legislation was passed today.', N'Luật mới được thông qua hôm nay.'),
(N'penalty', N'/ˈpenəlti/', N'hình phạt', N'noun', N'INTERMEDIATE', N'The penalty for speeding is a fine.', N'Hình phạt vượt tốc độ là phạt tiền.'),
(N'plaintiff', N'/ˈpleɪntɪf/', N'nguyên đơn', N'noun', N'ADVANCED', N'The plaintiff won the lawsuit.', N'Nguyên đơn thắng kiện.'),
(N'regulate', N'/ˈreɡjuleɪt/', N'điều chỉnh / kiểm soát', N'verb', N'INTERMEDIATE', N'The government regulates the industry.', N'Chính phủ điều chỉnh ngành công nghiệp.'),
(N'senator', N'/ˈsenətər/', N'thượng nghị sĩ', N'noun', N'INTERMEDIATE', N'The senator proposed a new bill.', N'Thượng nghị sĩ đề xuất dự luật mới.'),
(N'verdict', N'/ˈvɜːrdɪkt/', N'phán quyết', N'noun', N'INTERMEDIATE', N'The jury returned a guilty verdict.', N'Bồi thẩm đoàn đưa ra phán quyết có tội.'),
(N'witness', N'/ˈwɪtnɪs/', N'nhân chứng', N'noun', N'INTERMEDIATE', N'The witness testified in court.', N'Nhân chứng làm chứng tại tòa.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('ache','allergy','ambulance','antibiotic','bandage','blood pressure','capsule','clinic','contagious','diagnose','disinfect','dizzy','dosage','exhaust','fracture','hygiene','immune','injection','insomnia','nausea','nutrition','obese','paramedic','prescription','rash','recovery','remedy','stitch','symptom','therapy','transplant','vaccine','attorney','bail','ballot','ban','candidate','clause','constitution','council','court','defendant','enforce','federal','legislation','penalty','plaintiff','regulate','senator','verdict','witness');
