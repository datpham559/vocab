--liquibase formatted sql

--changeset vocab:033-seed-words-batch26
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Social Issues
(N'activism', N'/ˈæktɪvɪzəm/', N'chủ nghĩa tích cực xã hội', N'noun', N'INTERMEDIATE', N'Activism can bring real change.', N'Chủ nghĩa tích cực có thể mang lại sự thay đổi thực sự.'),
(N'advocate', N'/ˈædvəkeɪt/', N'ủng hộ / người ủng hộ', N'verb', N'INTERMEDIATE', N'She advocates for equal rights.', N'Cô ấy ủng hộ quyền bình đẳng.'),
(N'bias', N'/ˈbaɪəs/', N'thành kiến / sự thiên vị', N'noun', N'INTERMEDIATE', N'Eliminate bias in the workplace.', N'Loại bỏ sự thiên vị tại nơi làm việc.'),
(N'censorship', N'/ˈsensəʃɪp/', N'kiểm duyệt', N'noun', N'INTERMEDIATE', N'Censorship limits free expression.', N'Kiểm duyệt hạn chế sự biểu đạt tự do.'),
(N'charity', N'/ˈtʃærɪti/', N'từ thiện', N'noun', N'BEGINNER', N'Donate to charity every year.', N'Quyên góp từ thiện mỗi năm.'),
(N'class', N'/klɑːs/', N'giai cấp / lớp học', N'noun', N'BEGINNER', N'The class system varies by country.', N'Hệ thống giai cấp khác nhau theo từng quốc gia.'),
(N'community', N'/kəˈmjuːnɪti/', N'cộng đồng', N'noun', N'BEGINNER', N'Help build a strong community.', N'Giúp xây dựng cộng đồng mạnh mẽ.'),
(N'conflict', N'/ˈkɒnflɪkt/', N'xung đột', N'noun', N'INTERMEDIATE', N'Resolve conflict through dialogue.', N'Giải quyết xung đột thông qua đối thoại.'),
(N'corrupt', N'/kəˈrʌpt/', N'tham nhũng / băng hoại', N'adjective', N'INTERMEDIATE', N'A corrupt official was arrested.', N'Một quan chức tham nhũng đã bị bắt.'),
(N'crisis', N'/ˈkraɪsɪs/', N'khủng hoảng', N'noun', N'INTERMEDIATE', N'The country faces a financial crisis.', N'Đất nước đang đối mặt với khủng hoảng tài chính.'),
(N'culture', N'/ˈkʌltʃər/', N'văn hóa', N'noun', N'BEGINNER', N'Learn about different cultures.', N'Tìm hiểu về các nền văn hóa khác nhau.'),
(N'democracy', N'/dɪˈmɒkrəsi/', N'dân chủ', N'noun', N'INTERMEDIATE', N'Democracy depends on participation.', N'Dân chủ phụ thuộc vào sự tham gia.'),
(N'dignity', N'/ˈdɪɡnɪti/', N'phẩm giá', N'noun', N'INTERMEDIATE', N'Treat everyone with dignity.', N'Đối xử với mọi người bằng phẩm giá.'),
(N'diversity', N'/daɪˈvɜːrsɪti/', N'sự đa dạng', N'noun', N'INTERMEDIATE', N'Celebrate diversity in all its forms.', N'Tôn vinh sự đa dạng trong mọi hình thức.'),
(N'equality', N'/ɪˈkwɒlɪti/', N'sự bình đẳng', N'noun', N'INTERMEDIATE', N'Fight for gender equality.', N'Đấu tranh vì bình đẳng giới.'),
(N'exploitation', N'/ˌeksplɔɪˈteɪʃən/', N'sự bóc lột', N'noun', N'ADVANCED', N'Prevent exploitation of workers.', N'Ngăn chặn bóc lột công nhân.'),
(N'freedom', N'/ˈfriːdəm/', N'tự do', N'noun', N'BEGINNER', N'Freedom of speech is a basic right.', N'Tự do ngôn luận là quyền cơ bản.'),
(N'gender', N'/ˈdʒendər/', N'giới tính', N'noun', N'INTERMEDIATE', N'Gender roles are changing.', N'Vai trò giới tính đang thay đổi.'),
(N'homeless', N'/ˈhoʊmlɪs/', N'vô gia cư', N'adjective', N'BEGINNER', N'Help the homeless in your city.', N'Giúp đỡ người vô gia cư trong thành phố.'),
(N'human rights', N'/ˈhjuːmən raɪts/', N'nhân quyền', N'noun', N'INTERMEDIATE', N'Protect human rights worldwide.', N'Bảo vệ nhân quyền trên toàn thế giới.'),
(N'immigrant', N'/ˈɪmɪɡrənt/', N'người nhập cư', N'noun', N'INTERMEDIATE', N'Immigrants contribute to society.', N'Người nhập cư đóng góp cho xã hội.'),
(N'inequality', N'/ˌɪnɪˈkwɒlɪti/', N'sự bất bình đẳng', N'noun', N'INTERMEDIATE', N'Income inequality is a global issue.', N'Bất bình đẳng thu nhập là vấn đề toàn cầu.'),
(N'justice', N'/ˈdʒʌstɪs/', N'công bằng / tư pháp', N'noun', N'INTERMEDIATE', N'The justice system must be fair.', N'Hệ thống tư pháp phải công bằng.'),
(N'migration', N'/maɪˈɡreɪʃən/', N'di cư', N'noun', N'INTERMEDIATE', N'Migration affects local populations.', N'Di cư ảnh hưởng đến dân số địa phương.'),
(N'minority', N'/maɪˈnɒrɪti/', N'thiểu số', N'noun', N'INTERMEDIATE', N'Protect the rights of minorities.', N'Bảo vệ quyền lợi của người thiểu số.'),
(N'nonprofit', N'/ˌnɒnˈprɒfɪt/', N'phi lợi nhuận', N'adjective', N'INTERMEDIATE', N'She works for a nonprofit organization.', N'Cô ấy làm việc cho tổ chức phi lợi nhuận.'),
(N'oppression', N'/əˈpreʃən/', N'sự áp bức', N'noun', N'ADVANCED', N'Stand against oppression.', N'Đứng lên chống lại sự áp bức.'),
(N'poverty', N'/ˈpɒvəti/', N'đói nghèo', N'noun', N'INTERMEDIATE', N'Education helps escape poverty.', N'Giáo dục giúp thoát khỏi nghèo đói.'),
(N'privilege', N'/ˈprɪvɪlɪdʒ/', N'đặc quyền', N'noun', N'INTERMEDIATE', N'Recognize your privilege.', N'Nhận ra đặc quyền của bạn.'),
(N'protest', N'/ˈproʊtest/', N'biểu tình / phản đối', N'noun', N'INTERMEDIATE', N'Join the peaceful protest.', N'Tham gia cuộc biểu tình ôn hòa.'),
(N'racism', N'/ˈreɪsɪzəm/', N'phân biệt chủng tộc', N'noun', N'INTERMEDIATE', N'Fight racism in all its forms.', N'Chống lại phân biệt chủng tộc trong mọi hình thức.'),
(N'reform', N'/rɪˈfɔːrm/', N'cải cách', N'noun', N'INTERMEDIATE', N'Education reform is urgently needed.', N'Cải cách giáo dục là cấp bách.'),
(N'refugee', N'/ˌrefjʊˈdʒiː/', N'người tị nạn', N'noun', N'INTERMEDIATE', N'Provide shelter for refugees.', N'Cung cấp nơi trú ẩn cho người tị nạn.'),
(N'segregation', N'/ˌseɡrɪˈɡeɪʃən/', N'sự phân biệt / tách biệt', N'noun', N'ADVANCED', N'Racial segregation was abolished.', N'Phân biệt chủng tộc đã bị bãi bỏ.'),
(N'tolerance', N'/ˈtɒlərəns/', N'sự khoan dung', N'noun', N'INTERMEDIATE', N'Show tolerance to different views.', N'Thể hiện sự khoan dung với quan điểm khác nhau.'),
(N'volunteer', N'/ˌvɒlənˈtɪər/', N'tình nguyện viên', N'noun', N'BEGINNER', N'Be a volunteer in your community.', N'Làm tình nguyện viên trong cộng đồng.'),
-- Thematic: Workplace
(N'agenda', N'/əˈdʒendə/', N'chương trình nghị sự', N'noun', N'INTERMEDIATE', N'Set the agenda for the meeting.', N'Đặt chương trình nghị sự cho cuộc họp.'),
(N'appraisal', N'/əˈpreɪzəl/', N'đánh giá hiệu suất', N'noun', N'INTERMEDIATE', N'The annual appraisal is next week.', N'Đánh giá hiệu suất hàng năm là tuần sau.'),
(N'bonus', N'/ˈboʊnəs/', N'tiền thưởng', N'noun', N'BEGINNER', N'She received a year-end bonus.', N'Cô ấy nhận được thưởng cuối năm.'),
(N'colleague', N'/ˈkɒliːɡ/', N'đồng nghiệp', N'noun', N'BEGINNER', N'My colleague helped me with the report.', N'Đồng nghiệp của tôi giúp tôi với báo cáo.'),
(N'contractor', N'/ˈkɒntræktər/', N'nhà thầu', N'noun', N'INTERMEDIATE', N'Hire a contractor for the renovation.', N'Thuê nhà thầu để cải tạo.'),
(N'freelance', N'/ˈfriːlɑːns/', N'làm việc tự do', N'adjective', N'INTERMEDIATE', N'He does freelance graphic design.', N'Anh ấy làm thiết kế đồ họa tự do.'),
(N'hierarchy', N'/ˈhaɪərɑːrki/', N'cấu trúc thứ bậc', N'noun', N'ADVANCED', N'The company has a flat hierarchy.', N'Công ty có cơ cấu thứ bậc phẳng.'),
(N'layoff', N'/ˈleɪɒf/', N'sa thải / cắt giảm', N'noun', N'INTERMEDIATE', N'Many employees faced layoffs.', N'Nhiều nhân viên đối mặt với sa thải.'),
(N'overtime', N'/ˈoʊvərtaɪm/', N'làm thêm giờ', N'noun', N'BEGINNER', N'He worked overtime to finish the project.', N'Anh ấy làm thêm giờ để hoàn thành dự án.'),
(N'payroll', N'/ˈpeɪroʊl/', N'bảng lương', N'noun', N'INTERMEDIATE', N'HR manages the company payroll.', N'Nhân sự quản lý bảng lương công ty.'),
(N'probation', N'/proʊˈbeɪʃən/', N'thời gian thử việc', N'noun', N'INTERMEDIATE', N'The new hire is on probation.', N'Nhân viên mới đang trong thời gian thử việc.'),
(N'promotion', N'/prəˈmoʊʃən/', N'thăng chức / quảng bá', N'noun', N'BEGINNER', N'She earned a promotion this year.', N'Cô ấy được thăng chức năm nay.'),
(N'recruitment', N'/rɪˈkruːtmənt/', N'tuyển dụng', N'noun', N'INTERMEDIATE', N'Recruitment takes time and effort.', N'Tuyển dụng mất thời gian và công sức.'),
(N'resignation', N'/ˌrezɪɡˈneɪʃən/', N'sự từ chức', N'noun', N'INTERMEDIATE', N'He submitted his resignation letter.', N'Anh ấy nộp đơn từ chức.'),
(N'retire', N'/rɪˈtaɪər/', N'nghỉ hưu', N'verb', N'BEGINNER', N'She plans to retire at 60.', N'Cô ấy dự định nghỉ hưu ở tuổi 60.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('activism','advocate','bias','censorship','charity','class','community','conflict','corrupt','crisis','culture','democracy','dignity','diversity','equality','exploitation','freedom','gender','homeless','human rights','immigrant','inequality','migration','minority','nonprofit','oppression','poverty','privilege','protest','racism','reform','refugee','segregation','tolerance','volunteer','agenda','appraisal','bonus','colleague','contractor','freelance','hierarchy','layoff','overtime','payroll','probation','promotion','recruitment','resignation','retire');
