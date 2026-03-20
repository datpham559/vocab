--liquibase formatted sql

--changeset vocab:023-seed-words-batch16
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- BEGINNER: Days & Months
(N'Monday', N'/ˈmʌndeɪ/', N'thứ Hai', N'noun', N'BEGINNER', N'We start the week on Monday.', N'Chúng ta bắt đầu tuần vào thứ Hai.'),
(N'Tuesday', N'/ˈtjuːzdeɪ/', N'thứ Ba', N'noun', N'BEGINNER', N'The meeting is on Tuesday.', N'Cuộc họp là vào thứ Ba.'),
(N'Wednesday', N'/ˈwenzdeɪ/', N'thứ Tư', N'noun', N'BEGINNER', N'She teaches on Wednesdays.', N'Cô ấy dạy vào thứ Tư.'),
(N'Thursday', N'/ˈθɜːrzdeɪ/', N'thứ Năm', N'noun', N'BEGINNER', N'Let''s meet on Thursday.', N'Hãy gặp nhau vào thứ Năm.'),
(N'Friday', N'/ˈfraɪdeɪ/', N'thứ Sáu', N'noun', N'BEGINNER', N'Friday is the end of the work week.', N'Thứ Sáu là cuối tuần làm việc.'),
(N'Saturday', N'/ˈsætərdeɪ/', N'thứ Bảy', N'noun', N'BEGINNER', N'We relax on Saturdays.', N'Chúng tôi nghỉ ngơi vào thứ Bảy.'),
(N'Sunday', N'/ˈsʌndeɪ/', N'chủ Nhật', N'noun', N'BEGINNER', N'Sunday is a day of rest.', N'Chủ Nhật là ngày nghỉ ngơi.'),
(N'January', N'/ˈdʒænjueri/', N'tháng Một', N'noun', N'BEGINNER', N'January is the first month.', N'Tháng Một là tháng đầu tiên.'),
(N'February', N'/ˈfebrueri/', N'tháng Hai', N'noun', N'BEGINNER', N'February has 28 or 29 days.', N'Tháng Hai có 28 hoặc 29 ngày.'),
(N'March', N'/mɑːrtʃ/', N'tháng Ba', N'noun', N'BEGINNER', N'Spring begins in March.', N'Mùa xuân bắt đầu vào tháng Ba.'),
(N'April', N'/ˈeɪprɪl/', N'tháng Tư', N'noun', N'BEGINNER', N'April showers bring May flowers.', N'Mưa tháng Tư mang lại hoa tháng Năm.'),
(N'May', N'/meɪ/', N'tháng Năm', N'noun', N'BEGINNER', N'The weather is nice in May.', N'Thời tiết đẹp vào tháng Năm.'),
(N'June', N'/dʒuːn/', N'tháng Sáu', N'noun', N'BEGINNER', N'June is the start of summer.', N'Tháng Sáu là đầu hè.'),
(N'July', N'/dʒuˈlaɪ/', N'tháng Bảy', N'noun', N'BEGINNER', N'July is very hot this year.', N'Tháng Bảy năm nay rất nóng.'),
(N'August', N'/ˈɔːɡəst/', N'tháng Tám', N'noun', N'BEGINNER', N'School starts in August.', N'Trường học bắt đầu vào tháng Tám.'),
(N'September', N'/sepˈtembər/', N'tháng Chín', N'noun', N'BEGINNER', N'Autumn begins in September.', N'Mùa thu bắt đầu vào tháng Chín.'),
(N'October', N'/ɒkˈtoʊbər/', N'tháng Mười', N'noun', N'BEGINNER', N'October is a beautiful month.', N'Tháng Mười là tháng đẹp.'),
(N'November', N'/noʊˈvembər/', N'tháng Mười Một', N'noun', N'BEGINNER', N'It gets cold in November.', N'Trời lạnh vào tháng Mười Một.'),
(N'December', N'/dɪˈsembər/', N'tháng Mười Hai', N'noun', N'BEGINNER', N'Christmas is in December.', N'Giáng Sinh vào tháng Mười Hai.'),
-- BEGINNER: Sports Vocabulary (more)
(N'volleyball', N'/ˈvɒlibɔːl/', N'bóng chuyền', N'noun', N'BEGINNER', N'She plays volleyball on the beach.', N'Cô ấy chơi bóng chuyền trên bãi biển.'),
(N'badminton', N'/ˈbædmɪntən/', N'cầu lông', N'noun', N'BEGINNER', N'Badminton is popular in Asia.', N'Cầu lông rất phổ biến ở Châu Á.'),
(N'boxing', N'/ˈbɒksɪŋ/', N'quyền anh', N'noun', N'BEGINNER', N'Boxing builds strength and discipline.', N'Quyền anh xây dựng sức mạnh và kỷ luật.'),
(N'cycling', N'/ˈsaɪklɪŋ/', N'đua xe đạp', N'noun', N'BEGINNER', N'Cycling is eco-friendly transport.', N'Đạp xe là phương tiện thân thiện môi trường.'),
(N'marathon', N'/ˈmærəθɒn/', N'cuộc chạy marathon', N'noun', N'BEGINNER', N'Running a marathon is challenging.', N'Chạy marathon rất thử thách.'),
(N'goalkeeper', N'/ˈɡoʊlkiːpər/', N'thủ môn', N'noun', N'BEGINNER', N'The goalkeeper saved the penalty.', N'Thủ môn cứu quả phạt đền.'),
(N'championship', N'/ˈtʃæmpiənʃɪp/', N'giải vô địch', N'noun', N'BEGINNER', N'Our team won the championship.', N'Đội chúng tôi vô địch.'),
(N'tournament', N'/ˈtʊrnəmənt/', N'giải đấu', N'noun', N'BEGINNER', N'Join the tennis tournament.', N'Tham gia giải đấu quần vợt.'),
(N'athlete', N'/ˈæθliːt/', N'vận động viên', N'noun', N'BEGINNER', N'She is a professional athlete.', N'Cô ấy là vận động viên chuyên nghiệp.'),
(N'coach', N'/koʊtʃ/', N'huấn luyện viên', N'noun', N'BEGINNER', N'The coach trains the team.', N'Huấn luyện viên tập luyện cho đội.'),
-- INTERMEDIATE: Office & Administration
(N'document', N'/ˈdɒkjʊmənt/', N'tài liệu', N'noun', N'INTERMEDIATE', N'Print the document for the meeting.', N'In tài liệu cho cuộc họp.'),
(N'spreadsheet', N'/ˈspredʃiːt/', N'bảng tính', N'noun', N'INTERMEDIATE', N'Update the spreadsheet daily.', N'Cập nhật bảng tính hàng ngày.'),
(N'invoice', N'/ˈɪnvɔɪs/', N'hóa đơn', N'noun', N'INTERMEDIATE', N'Send the invoice to the client.', N'Gửi hóa đơn cho khách hàng.'),
(N'receipt', N'/rɪˈsiːt/', N'biên lai', N'noun', N'INTERMEDIATE', N'Keep the receipt for your records.', N'Giữ biên lai để lưu hồ sơ.'),
(N'deadline', N'/ˈdedlaɪn/', N'thời hạn', N'noun', N'INTERMEDIATE', N'The deadline is Friday at 5 PM.', N'Thời hạn là thứ Sáu lúc 5 giờ chiều.'),
(N'minutes', N'/ˈmɪnɪts/', N'biên bản cuộc họp', N'noun', N'INTERMEDIATE', N'Take minutes during the meeting.', N'Ghi biên bản trong cuộc họp.'),
(N'signature', N'/ˈsɪɡnətʃər/', N'chữ ký', N'noun', N'INTERMEDIATE', N'Your signature is required.', N'Cần có chữ ký của bạn.'),
(N'confidential', N'/ˌkɒnfɪˈdenʃəl/', N'bảo mật', N'adjective', N'INTERMEDIATE', N'This information is confidential.', N'Thông tin này là bảo mật.'),
(N'protocol', N'/ˈproʊtəkɒl/', N'quy trình / giao thức', N'noun', N'INTERMEDIATE', N'Follow the safety protocol.', N'Tuân thủ quy trình an toàn.'),
(N'delegate', N'/ˈdelɪɡeɪt/', N'ủy quyền / đại biểu', N'noun', N'INTERMEDIATE', N'Send a delegate to the conference.', N'Cử đại biểu đến hội nghị.'),
-- INTERMEDIATE: Environmental Actions
(N'reduce', N'/rɪˈdjuːs/', N'giảm thiểu', N'verb', N'INTERMEDIATE', N'Reduce plastic waste.', N'Giảm thiểu rác thải nhựa.'),
(N'reuse', N'/ˌriːˈjuːz/', N'tái sử dụng', N'verb', N'INTERMEDIATE', N'Reuse bags instead of buying new ones.', N'Tái sử dụng túi thay vì mua mới.'),
(N'recycle', N'/ˌriːˈsaɪkəl/', N'tái chế', N'verb', N'INTERMEDIATE', N'Recycle paper, glass and plastic.', N'Tái chế giấy, thủy tinh và nhựa.'),
(N'conserve', N'/kənˈsɜːrv/', N'bảo tồn', N'verb', N'INTERMEDIATE', N'Conserve water every day.', N'Tiết kiệm nước mỗi ngày.'),
(N'sustain', N'/səˈsteɪn/', N'duy trì bền vững', N'verb', N'INTERMEDIATE', N'Sustain the natural resources.', N'Duy trì nguồn tài nguyên thiên nhiên.'),
(N'compost', N'/ˈkɒmpɒst/', N'phân compost / ủ phân', N'noun', N'INTERMEDIATE', N'Make compost from food scraps.', N'Làm phân compost từ thức ăn thừa.'),
(N'solar energy', N'/ˈsoʊlər ˈenədʒi/', N'năng lượng mặt trời', N'noun', N'INTERMEDIATE', N'Solar energy is clean and renewable.', N'Năng lượng mặt trời sạch và tái tạo.'),
(N'wind turbine', N'/wɪnd ˈtɜːrbaɪn/', N'tua bin gió', N'noun', N'INTERMEDIATE', N'Wind turbines generate electricity.', N'Tua bin gió tạo ra điện.'),
(N'emission', N'/ɪˈmɪʃən/', N'khí thải', N'noun', N'INTERMEDIATE', N'Reduce carbon emissions.', N'Giảm lượng khí thải carbon.'),
(N'degrade', N'/dɪˈɡreɪd/', N'phân hủy / xuống cấp', N'verb', N'INTERMEDIATE', N'Plastic takes hundreds of years to degrade.', N'Nhựa mất hàng trăm năm để phân hủy.'),
-- ADVANCED: AI & Machine Learning
(N'neural network', N'/ˈnjʊərəl ˈnetwɜːrk/', N'mạng nơ-ron', N'noun', N'ADVANCED', N'Neural networks mimic the brain.', N'Mạng nơ-ron mô phỏng não bộ.'),
(N'deep learning', N'/diːp ˈlɜːrnɪŋ/', N'học sâu', N'noun', N'ADVANCED', N'Deep learning powers image recognition.', N'Học sâu thúc đẩy nhận dạng hình ảnh.'),
(N'natural language processing', N'/ˈnætʃrəl ˈlæŋɡwɪdʒ ˈprɒsesɪŋ/', N'xử lý ngôn ngữ tự nhiên', N'noun', N'ADVANCED', N'NLP allows computers to understand language.', N'NLP cho phép máy tính hiểu ngôn ngữ.'),
(N'reinforcement learning', N'/ˌriːɪnˈfɔːrsmənt ˈlɜːrnɪŋ/', N'học tăng cường', N'noun', N'ADVANCED', N'Reinforcement learning trains AI through rewards.', N'Học tăng cường huấn luyện AI qua phần thưởng.'),
(N'overfitting', N'/ˌoʊvərˈfɪtɪŋ/', N'học quá khớp', N'noun', N'ADVANCED', N'Overfitting reduces model generalization.', N'Học quá khớp giảm khả năng tổng quát hóa của mô hình.'),
(N'bias-variance tradeoff', N'/baɪəs ˈveəriəns ˈtreɪdɒf/', N'đánh đổi giữa thiên lệch và phương sai', N'noun', N'ADVANCED', N'Understand the bias-variance tradeoff.', N'Hiểu đánh đổi giữa thiên lệch và phương sai.'),
(N'hyperparameter', N'/ˌhaɪpərˈpærəmɪtər/', N'siêu tham số', N'noun', N'ADVANCED', N'Tune the model''s hyperparameters.', N'Điều chỉnh siêu tham số của mô hình.'),
(N'gradient descent', N'/ˈɡreɪdiənt dɪˈsent/', N'giảm dần gradient', N'noun', N'ADVANCED', N'Gradient descent optimizes the model.', N'Giảm dần gradient tối ưu hóa mô hình.'),
(N'epoch', N'/ˈiːpɒk/', N'vòng lặp huấn luyện', N'noun', N'ADVANCED', N'Train for 100 epochs.', N'Huấn luyện cho 100 vòng.'),
(N'inference', N'/ˈɪnfərəns/', N'suy luận / dự đoán (AI)', N'noun', N'ADVANCED', N'Run inference on the test data.', N'Chạy dự đoán trên dữ liệu kiểm thử.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday','January','February','March','April','May','June','July','August','September','October','November','December','volleyball','badminton','boxing','cycling','marathon','goalkeeper','championship','tournament','athlete','coach','document','spreadsheet','invoice','receipt','deadline','minutes','signature','confidential','protocol','delegate','reduce','reuse','recycle','conserve','sustain','compost','solar energy','wind turbine','emission','degrade','neural network','deep learning','natural language processing','reinforcement learning','overfitting','bias-variance tradeoff','hyperparameter','gradient descent','epoch','inference');
