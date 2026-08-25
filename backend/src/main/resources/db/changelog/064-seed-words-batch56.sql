--liquibase formatted sql

--changeset vocab:064-seed-words-batch56
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, category, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.category, v.example_sentence, v.example_translation
FROM (VALUES
-- Technology
(N'processor', N'/ˈprɑːsesər/', N'bộ vi xử lý', N'noun', N'INTERMEDIATE', N'Technology', N'This laptop has a fast processor.', N'Chiếc laptop này có bộ vi xử lý nhanh.'),
(N'bandwidth', N'/ˈbændwɪdθ/', N'băng thông', N'noun', N'ADVANCED', N'Technology', N'The video buffers due to low bandwidth.', N'Video bị giật do băng thông thấp.'),
(N'router', N'/ˈruːtər/', N'bộ định tuyến (router)', N'noun', N'INTERMEDIATE', N'Technology', N'Restart the router if the wifi is slow.', N'Khởi động lại router nếu wifi chậm.'),
(N'interface', N'/ˈɪntərfeɪs/', N'giao diện', N'noun', N'INTERMEDIATE', N'Technology', N'The app has a simple user interface.', N'Ứng dụng có giao diện người dùng đơn giản.'),
(N'compatible', N'/kəmˈpætəbl/', N'tương thích', N'adjective', N'INTERMEDIATE', N'Technology', N'This charger is compatible with most phones.', N'Bộ sạc này tương thích với hầu hết điện thoại.'),
(N'algorithm', N'/ˈælɡərɪðəm/', N'thuật toán', N'noun', N'ADVANCED', N'Technology', N'The algorithm sorts the data quickly.', N'Thuật toán sắp xếp dữ liệu nhanh chóng.'),
(N'notification', N'/ˌnoʊtɪfɪˈkeɪʃən/', N'thông báo', N'noun', N'BEGINNER', N'Technology', N'I got a notification about the update.', N'Tôi nhận được thông báo về bản cập nhật.'),
(N'gadget', N'/ˈɡædʒɪt/', N'thiết bị nhỏ, đồ công nghệ', N'noun', N'BEGINNER', N'Technology', N'He loves buying the latest gadgets.', N'Anh ấy thích mua những thiết bị công nghệ mới nhất.'),
(N'touchscreen', N'/ˈtʌtʃskriːn/', N'màn hình cảm ứng', N'noun', N'BEGINNER', N'Technology', N'The touchscreen responds to light taps.', N'Màn hình cảm ứng phản hồi với chạm nhẹ.'),
(N'keystroke', N'/ˈkiːstroʊk/', N'lần nhấn phím', N'noun', N'ADVANCED', N'Technology', N'Every keystroke is recorded by the app.', N'Mỗi lần nhấn phím đều được ứng dụng ghi lại.'),
(N'firewall', N'/ˈfaɪərwɔːl/', N'tường lửa', N'noun', N'ADVANCED', N'Technology', N'The firewall blocks suspicious traffic.', N'Tường lửa chặn lưu lượng truy cập đáng ngờ.'),
(N'username', N'/ˈjuːzərneɪm/', N'tên đăng nhập', N'noun', N'BEGINNER', N'Technology', N'Enter your username and password.', N'Nhập tên đăng nhập và mật khẩu của bạn.'),
(N'shortcut', N'/ˈʃɔːrtkʌt/', N'phím tắt / đường tắt', N'noun', N'INTERMEDIATE', N'Technology', N'Use a keyboard shortcut to save time.', N'Dùng phím tắt để tiết kiệm thời gian.'),
(N'offline', N'/ˌɒfˈlaɪn/', N'ngoại tuyến', N'adjective', N'BEGINNER', N'Technology', N'You can read the article offline.', N'Bạn có thể đọc bài viết khi ngoại tuyến.'),
(N'malfunction', N'/ˌmælˈfʌŋkʃən/', N'trục trặc, hoạt động sai', N'noun', N'ADVANCED', N'Technology', N'A malfunction caused the machine to stop.', N'Một trục trặc khiến máy dừng hoạt động.'),
-- Science
(N'friction', N'/ˈfrɪkʃən/', N'ma sát', N'noun', N'INTERMEDIATE', N'Science', N'Friction slows down the moving object.', N'Ma sát làm chậm vật đang di chuyển.'),
(N'gravity', N'/ˈɡrævəti/', N'trọng lực', N'noun', N'BEGINNER', N'Science', N'Gravity pulls objects toward the earth.', N'Trọng lực kéo các vật thể về phía trái đất.'),
(N'molecule', N'/ˈmɑːlɪkjuːl/', N'phân tử', N'noun', N'INTERMEDIATE', N'Science', N'Water is made of two hydrogen molecules and one oxygen.', N'Nước được tạo thành từ phân tử hydro và oxy.'),
(N'catalyst', N'/ˈkætəlɪst/', N'chất xúc tác', N'noun', N'ADVANCED', N'Science', N'The catalyst speeds up the reaction.', N'Chất xúc tác làm tăng tốc phản ứng.'),
(N'organism', N'/ˈɔːrɡənɪzəm/', N'sinh vật, cơ thể sống', N'noun', N'INTERMEDIATE', N'Science', N'Every organism needs energy to survive.', N'Mọi sinh vật cần năng lượng để sinh tồn.'),
(N'radiation', N'/ˌreɪdiˈeɪʃən/', N'phóng xạ, tia bức xạ', N'noun', N'ADVANCED', N'Science', N'The sun emits harmful radiation.', N'Mặt trời phát ra tia bức xạ có hại.'),
(N'velocity', N'/vəˈlɑːsəti/', N'vận tốc', N'noun', N'ADVANCED', N'Science', N'The car increased its velocity on the highway.', N'Chiếc xe tăng vận tốc trên đường cao tốc.'),
(N'chromosome', N'/ˈkroʊməsoʊm/', N'nhiễm sắc thể', N'noun', N'ADVANCED', N'Science', N'Humans have 23 pairs of chromosomes.', N'Con người có 23 cặp nhiễm sắc thể.'),
(N'oxidize', N'/ˈɑːksɪdaɪz/', N'oxy hóa', N'verb', N'ADVANCED', N'Science', N'Iron oxidizes and forms rust.', N'Sắt bị oxy hóa và tạo thành gỉ sét.'),
(N'membrane', N'/ˈmembreɪn/', N'màng (tế bào)', N'noun', N'ADVANCED', N'Science', N'The cell membrane protects the cell.', N'Màng tế bào bảo vệ tế bào.'),
-- Health
(N'posture', N'/ˈpɑːstʃər/', N'tư thế (ngồi, đứng)', N'noun', N'INTERMEDIATE', N'Health', N'Good posture prevents back pain.', N'Tư thế tốt giúp ngăn ngừa đau lưng.'),
(N'stamina', N'/ˈstæmɪnə/', N'sức chịu đựng, sức bền', N'noun', N'INTERMEDIATE', N'Health', N'Running builds stamina over time.', N'Chạy bộ giúp xây dựng sức bền theo thời gian.'),
(N'metabolism', N'/məˈtæbəlɪzəm/', N'sự trao đổi chất', N'noun', N'ADVANCED', N'Health', N'Exercise boosts your metabolism.', N'Tập thể dục thúc đẩy quá trình trao đổi chất.'),
(N'nutrient', N'/ˈnuːtriənt/', N'chất dinh dưỡng', N'noun', N'INTERMEDIATE', N'Health', N'Vegetables are full of nutrients.', N'Rau củ chứa nhiều chất dinh dưỡng.'),
(N'sedentary', N'/ˈsedənteri/', N'ít vận động, tĩnh tại', N'adjective', N'ADVANCED', N'Health', N'A sedentary lifestyle can cause health problems.', N'Cuộc sống ít vận động có thể gây ra vấn đề sức khỏe.'),
(N'obesity', N'/oʊˈbiːsəti/', N'bệnh béo phì', N'noun', N'ADVANCED', N'Health', N'Obesity increases the risk of heart disease.', N'Béo phì làm tăng nguy cơ bệnh tim.'),
(N'ailment', N'/ˈeɪlmənt/', N'bệnh tật, bệnh nhẹ', N'noun', N'ADVANCED', N'Health', N'He suffers from a minor ailment.', N'Anh ấy mắc một bệnh nhẹ.'),
(N'diagnosis', N'/ˌdaɪəɡˈnoʊsɪs/', N'sự chẩn đoán', N'noun', N'ADVANCED', N'Health', N'The doctor confirmed the diagnosis.', N'Bác sĩ đã xác nhận chẩn đoán.'),
(N'physiotherapy', N'/ˌfɪzioʊˈθerəpi/', N'vật lý trị liệu', N'noun', N'ADVANCED', N'Health', N'She attends physiotherapy twice a week.', N'Cô ấy đi vật lý trị liệu hai lần một tuần.'),
(N'wound', N'/wuːnd/', N'vết thương', N'noun', N'BEGINNER', N'Health', N'The nurse cleaned the wound carefully.', N'Y tá làm sạch vết thương cẩn thận.'),
-- Environment
(N'landfill', N'/ˈlændfɪl/', N'bãi chôn lấp rác', N'noun', N'INTERMEDIATE', N'Nature', N'Most waste ends up in a landfill.', N'Hầu hết rác thải cuối cùng đến bãi chôn lấp.'),
(N'pesticide', N'/ˈpestɪsaɪd/', N'thuốc trừ sâu', N'noun', N'INTERMEDIATE', N'Nature', N'Farmers use pesticide to protect crops.', N'Nông dân dùng thuốc trừ sâu để bảo vệ cây trồng.'),
(N'toxic', N'/ˈtɑːksɪk/', N'độc hại', N'adjective', N'INTERMEDIATE', N'Nature', N'The factory released toxic waste.', N'Nhà máy thải ra chất thải độc hại.'),
(N'deplete', N'/dɪˈpliːt/', N'làm suy giảm, cạn kiệt', N'verb', N'ADVANCED', N'Nature', N'Overfishing depletes the fish population.', N'Đánh bắt quá mức làm suy giảm số lượng cá.'),
(N'preserve', N'/prɪˈzɜːrv/', N'bảo tồn, giữ nguyên', N'verb', N'INTERMEDIATE', N'Nature', N'We must preserve the rainforest.', N'Chúng ta phải bảo tồn rừng nhiệt đới.'),
(N'habitat loss', N'/ˈhæbɪtæt lɔːs/', N'sự mất môi trường sống', N'noun', N'ADVANCED', N'Nature', N'Habitat loss threatens many species.', N'Mất môi trường sống đe dọa nhiều loài.'),
(N'greenhouse effect', N'/ˈɡriːnhaʊs ɪˈfekt/', N'hiệu ứng nhà kính', N'noun', N'ADVANCED', N'Nature', N'The greenhouse effect warms the planet.', N'Hiệu ứng nhà kính làm nóng hành tinh.'),
(N'renewable energy', N'/rɪˈnuːəbl ˈenərdʒi/', N'năng lượng tái tạo', N'noun', N'INTERMEDIATE', N'Nature', N'Solar power is a renewable energy source.', N'Năng lượng mặt trời là nguồn năng lượng tái tạo.'),
(N'overfishing', N'/ˌoʊvərˈfɪʃɪŋ/', N'đánh bắt cá quá mức', N'noun', N'ADVANCED', N'Nature', N'Overfishing harms ocean ecosystems.', N'Đánh bắt cá quá mức gây hại cho hệ sinh thái đại dương.'),
(N'carbon emission', N'/ˈkɑːrbən ɪˈmɪʃən/', N'khí thải carbon', N'noun', N'ADVANCED', N'Nature', N'Cars are a major source of carbon emissions.', N'Xe hơi là nguồn khí thải carbon lớn.'),
-- Travel
(N'itinerary', N'/aɪˈtɪnəreri/', N'lịch trình chuyến đi', N'noun', N'ADVANCED', N'Travel', N'She planned a detailed itinerary.', N'Cô ấy đã lên một lịch trình chi tiết.'),
(N'excursion', N'/ɪkˈskɜːrʒən/', N'chuyến đi ngắn, dã ngoại', N'noun', N'INTERMEDIATE', N'Travel', N'We went on a day excursion to the island.', N'Chúng tôi đi dã ngoại một ngày ra đảo.'),
(N'passenger', N'/ˈpæsəndʒər/', N'hành khách', N'noun', N'BEGINNER', N'Travel', N'The passenger checked in at the counter.', N'Hành khách làm thủ tục ở quầy.'),
(N'aisle', N'/aɪl/', N'hàng ghế, lối đi', N'noun', N'INTERMEDIATE', N'Travel', N'I prefer an aisle seat on flights.', N'Tôi thích ghế cạnh lối đi khi bay.'),
(N'terminal', N'/ˈtɜːrmɪnl/', N'nhà ga, sân bay', N'noun', N'INTERMEDIATE', N'Travel', N'Our flight departs from terminal two.', N'Chuyến bay của chúng tôi khởi hành từ nhà ga hai.'),
(N'overbooked', N'/ˌoʊvərˈbʊkt/', N'quá tải chỗ đặt', N'adjective', N'ADVANCED', N'Travel', N'The flight was overbooked by ten seats.', N'Chuyến bay quá tải mười chỗ đặt.'),
(N'wanderlust', N'/ˈwɑːndərlʌst/', N'niềm khao khát đi du lịch, xê dịch', N'noun', N'ADVANCED', N'Travel', N'She has a deep wanderlust for new places.', N'Cô ấy có niềm khao khát xê dịch sâu sắc.'),
(N'landmark', N'/ˈlændmɑːrk/', N'địa danh nổi tiếng', N'noun', N'INTERMEDIATE', N'Travel', N'The Eiffel Tower is a famous landmark.', N'Tháp Eiffel là một địa danh nổi tiếng.'),
(N'expedition', N'/ˌekspəˈdɪʃən/', N'cuộc thám hiểm', N'noun', N'ADVANCED', N'Travel', N'They joined an expedition to Antarctica.', N'Họ tham gia một cuộc thám hiểm đến Nam Cực.'),
(N'off the beaten path', N'/ɒf ðə ˈbiːtn pæθ/', N'nơi ít người biết đến, xa lối mòn', N'phrase', N'ADVANCED', N'Travel', N'They love traveling off the beaten path.', N'Họ thích du lịch đến những nơi ít người biết.'),
-- Idioms / Phrasal Verbs
(N'get the ball rolling', N'/ɡet ðə bɔːl ˈroʊlɪŋ/', N'bắt đầu công việc', N'phrase', N'ADVANCED', N'Language', N'Let us get the ball rolling on this project.', N'Hãy bắt đầu triển khai dự án này.'),
(N'a blessing in disguise', N'/ə ˈblesɪŋ ɪn dɪsˈɡaɪz/', N'điều may mắn ẩn dưới hình thức xấu', N'phrase', N'ADVANCED', N'Language', N'Losing that job was a blessing in disguise.', N'Mất công việc đó thực ra lại là một may mắn ẩn giấu.'),
(N'burn the midnight oil', N'/bɜːrn ðə ˈmɪdnaɪt ɔɪl/', N'làm việc/học tập đến khuya', N'phrase', N'ADVANCED', N'Language', N'She burned the midnight oil before the exam.', N'Cô ấy học đến khuya trước kỳ thi.'),
(N'let the cat out of the bag', N'/let ðə kæt aʊt əv ðə bæɡ/', N'vô tình để lộ bí mật', N'phrase', N'ADVANCED', N'Language', N'He let the cat out of the bag about the surprise party.', N'Anh ấy đã lỡ để lộ bí mật về buổi tiệc bất ngờ.'),
(N'on the same page', N'/ɒn ðə seɪm peɪdʒ/', N'cùng quan điểm, hiểu nhau', N'phrase', N'INTERMEDIATE', N'Language', N'Let us make sure we are on the same page.', N'Hãy đảm bảo chúng ta hiểu nhau và cùng quan điểm.'),
(N'give someone the benefit of the doubt', N'/ɡɪv ˈsʌmwʌn ðə ˈbenɪfɪt əv ðə daʊt/', N'tin tưởng ai đó khi chưa có chứng cứ ngược lại', N'phrase', N'ADVANCED', N'Language', N'I will give him the benefit of the doubt this time.', N'Lần này tôi sẽ tin tưởng anh ấy khi chưa có chứng cứ ngược lại.'),
(N'jump on the bandwagon', N'/dʒʌmp ɒn ðə ˈbændwæɡən/', N'chạy theo xu hướng, làm theo số đông', N'phrase', N'ADVANCED', N'Language', N'Many brands jumped on the bandwagon.', N'Nhiều thương hiệu đã chạy theo xu hướng này.'),
(N'the last straw', N'/ðə læst strɔː/', N'giọt nước làm tràn ly, điều cuối cùng khiến không chịu được nữa', N'phrase', N'ADVANCED', N'Language', N'His late arrival was the last straw.', N'Việc anh ấy đến muộn là giọt nước làm tràn ly.'),
(N'turn a blind eye', N'/tɜːrn ə blaɪnd aɪ/', N'cố tình không để ý, làm ngơ', N'phrase', N'ADVANCED', N'Language', N'The manager turned a blind eye to the mistake.', N'Người quản lý đã cố tình làm ngơ trước lỗi sai.'),
(N'go the extra mile', N'/ɡoʊ ðə ˈekstrə maɪl/', N'nỗ lực hơn mức cần thiết', N'phrase', N'INTERMEDIATE', N'Language', N'She always goes the extra mile for customers.', N'Cô ấy luôn nỗ lực hơn mức cần thiết cho khách hàng.'),
(N'hit the nail on the head', N'/hɪt ðə neɪl ɒn ðə hed/', N'nói đúng trọng tâm', N'phrase', N'ADVANCED', N'Language', N'You hit the nail on the head with that comment.', N'Bạn đã nói đúng trọng tâm với bình luận đó.'),
(N'back to square one', N'/bæk tuː skwer wʌn/', N'trở lại điểm bắt đầu', N'phrase', N'ADVANCED', N'Language', N'The plan failed, so we are back to square one.', N'Kế hoạch thất bại nên chúng ta phải bắt đầu lại từ đầu.'),
(N'kill two birds with one stone', N'/kɪl tuː bɜːrdz wɪð wʌn stoʊn/', N'một công đôi việc', N'phrase', N'ADVANCED', N'Language', N'We can kill two birds with one stone by combining the trips.', N'Chúng ta có thể một công đôi việc bằng cách kết hợp các chuyến đi.'),
(N'put all your eggs in one basket', N'/pʊt ɔːl jʊr eɡz ɪn wʌn ˈbæskɪt/', N'đặt cược tất cả vào một lựa chọn duy nhất', N'phrase', N'ADVANCED', N'Language', N'Do not put all your eggs in one basket.', N'Đừng đặt cược tất cả vào một lựa chọn duy nhất.'),
(N'beat around the bush', N'/biːt əˈraʊnd ðə bʊʃ/', N'nói vòng vo, tránh nói thẳng', N'phrase', N'ADVANCED', N'Language', N'Stop beating around the bush and tell me the truth.', N'Đừng nói vòng vo nữa, hãy nói cho tôi sự thật.'),
(N'add fuel to the fire', N'/æd fjuːəl tuː ðə ˈfaɪər/', N'làm tình hình tệ hơn', N'phrase', N'ADVANCED', N'Language', N'His comment only added fuel to the fire.', N'Bình luận của anh ấy chỉ làm tình hình tệ hơn.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, category, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('processor','bandwidth','router','interface','compatible','algorithm','notification','gadget','touchscreen','keystroke','firewall','username','shortcut','offline','malfunction','friction','gravity','molecule','catalyst','organism','radiation','velocity','chromosome','oxidize','membrane','posture','stamina','metabolism','nutrient','sedentary','obesity','ailment','diagnosis','physiotherapy','wound','landfill','pesticide','toxic','deplete','preserve','habitat loss','greenhouse effect','renewable energy','overfishing','carbon emission','itinerary','excursion','passenger','aisle','terminal','overbooked','wanderlust','landmark','expedition','off the beaten path','get the ball rolling','a blessing in disguise','burn the midnight oil','let the cat out of the bag','on the same page','give someone the benefit of the doubt','jump on the bandwagon','the last straw','turn a blind eye','go the extra mile','hit the nail on the head','back to square one','kill two birds with one stone','put all your eggs in one basket','beat around the bush','add fuel to the fire');
