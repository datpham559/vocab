--liquibase formatted sql

--changeset vocab:061-seed-words-batch53
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, category, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.category, v.example_sentence, v.example_translation
FROM (VALUES
-- Psychology / Mental Health
(N'trauma', N'/ˈtrɔːmə/', N'chấn thương tâm lý', N'noun', N'INTERMEDIATE', N'Health', N'Therapy helps people recover from trauma.', N'Liệu pháp tâm lý giúp người ta hồi phục sau chấn thương.'),
(N'phobia', N'/ˈfoʊbiə/', N'chứng sợ hãi / ám ảnh', N'noun', N'INTERMEDIATE', N'Health', N'She has a phobia of heights.', N'Cô ấy có chứng sợ độ cao.'),
(N'addiction', N'/əˈdɪkʃən/', N'sự nghiện ngập', N'noun', N'INTERMEDIATE', N'Health', N'Addiction to social media is a modern problem.', N'Nghiện mạng xã hội là vấn đề hiện đại.'),
(N'paranoia', N'/ˌpærəˈnɔɪə/', N'chứng hoang tưởng', N'noun', N'ADVANCED', N'Health', N'Stress can sometimes trigger paranoia.', N'Căng thẳng đôi khi có thể gây ra hoang tưởng.'),
(N'mindfulness', N'/ˈmaɪndfʊlnəs/', N'chánh niệm / sự tập trung hiện tại', N'noun', N'INTERMEDIATE', N'Health', N'Mindfulness helps reduce daily stress.', N'Chánh niệm giúp giảm căng thẳng hàng ngày.'),
-- Wildlife / Nature
(N'habitat', N'/ˈhæbɪtæt/', N'môi trường sống', N'noun', N'BEGINNER', N'Nature', N'Forests are the natural habitat of tigers.', N'Rừng là môi trường sống tự nhiên của hổ.'),
(N'species', N'/ˈspiːʃiːz/', N'loài / chủng loài', N'noun', N'BEGINNER', N'Nature', N'Many species are at risk of extinction.', N'Nhiều loài đang có nguy cơ tuyệt chủng.'),
(N'camouflage', N'/ˈkæməflɑːʒ/', N'ngụy trang', N'noun', N'INTERMEDIATE', N'Nature', N'The chameleon uses camouflage to hide.', N'Tắc kè hoa dùng ngụy trang để ẩn nấp.'),
(N'extinct', N'/ɪkˈstɪŋkt/', N'tuyệt chủng', N'adjective', N'INTERMEDIATE', N'Nature', N'Dinosaurs became extinct long ago.', N'Khủng long đã tuyệt chủng từ lâu.'),
(N'endangered', N'/ɪnˈdeɪndʒərd/', N'có nguy cơ tuyệt chủng', N'adjective', N'INTERMEDIATE', N'Nature', N'The panda is an endangered species.', N'Gấu trúc là loài có nguy cơ tuyệt chủng.'),
(N'nocturnal', N'/nɒkˈtɜːrnəl/', N'hoạt động ban đêm', N'adjective', N'ADVANCED', N'Nature', N'Owls are nocturnal birds.', N'Cú mèo là loài chim hoạt động ban đêm.'),
-- Extreme Weather
(N'avalanche', N'/ˈævəlɑːntʃ/', N'trận tuyết lở', N'noun', N'INTERMEDIATE', N'Nature', N'The avalanche buried the mountain road.', N'Trận tuyết lở chôn vùi con đường núi.'),
(N'blizzard', N'/ˈblɪzərd/', N'bão tuyết', N'noun', N'INTERMEDIATE', N'Nature', N'A blizzard shut down the entire city.', N'Cơn bão tuyết làm tê liệt cả thành phố.'),
(N'typhoon', N'/taɪˈfuːn/', N'bão nhiệt đới / cơn bão', N'noun', N'BEGINNER', N'Nature', N'The typhoon caused severe flooding.', N'Cơn bão gây lũ lụt nghiêm trọng.'),
(N'heatwave', N'/ˈhiːtweɪv/', N'đợt nắng nóng', N'noun', N'INTERMEDIATE', N'Nature', N'A heatwave struck the region last summer.', N'Một đợt nắng nóng ập đến khu vực vào mùa hè vừa rồi.'),
(N'forecast', N'/ˈfɔːrkæst/', N'dự báo / dự đoán', N'noun', N'BEGINNER', N'Nature', N'The weather forecast predicts heavy rain.', N'Dự báo thời tiết dự đoán mưa to.'),
-- Clothing / Fashion
(N'accessory', N'/əkˈsesəri/', N'phụ kiện', N'noun', N'BEGINNER', N'Clothing', N'A hat is a popular fashion accessory.', N'Mũ là phụ kiện thời trang phổ biến.'),
(N'texture', N'/ˈtekstʃər/', N'kết cấu / chất liệu', N'noun', N'INTERMEDIATE', N'Clothing', N'This fabric has a smooth texture.', N'Loại vải này có kết cấu mượt mà.'),
(N'velvet', N'/ˈvelvɪt/', N'vải nhung', N'noun', N'INTERMEDIATE', N'Clothing', N'She wore a red velvet dress.', N'Cô ấy mặc chiếc váy nhung đỏ.'),
(N'linen', N'/ˈlɪnɪn/', N'vải lanh', N'noun', N'BEGINNER', N'Clothing', N'Linen shirts are cool in summer.', N'Áo vải lanh mát mẻ vào mùa hè.'),
(N'fashionable', N'/ˈfæʃənəbl/', N'hợp thời trang', N'adjective', N'BEGINNER', N'Clothing', N'She always wears fashionable clothes.', N'Cô ấy luôn mặc quần áo hợp thời trang.'),
(N'stylish', N'/ˈstaɪlɪʃ/', N'thanh lịch / thời thượng', N'adjective', N'BEGINNER', N'Clothing', N'He looks stylish in that suit.', N'Anh ấy trông rất lịch sự trong bộ vest đó.'),
-- Relationships / People
(N'acquaintance', N'/əˈkweɪntəns/', N'người quen / mối quan hệ xã giao', N'noun', N'INTERMEDIATE', N'People', N'He is just an acquaintance not a close friend.', N'Anh ấy chỉ là người quen chứ không phải bạn thân.'),
(N'companion', N'/kəmˈpæniən/', N'người bạn đồng hành', N'noun', N'INTERMEDIATE', N'People', N'A dog is a loyal companion.', N'Chó là người bạn đồng hành trung thành.'),
(N'guardian', N'/ˈɡɑːrdiən/', N'người giám hộ / người bảo vệ', N'noun', N'INTERMEDIATE', N'People', N'The guardian protected the child.', N'Người giám hộ bảo vệ đứa trẻ.'),
(N'spouse', N'/spaʊs/', N'vợ hoặc chồng', N'noun', N'BEGINNER', N'People', N'My spouse supports all my decisions.', N'Vợ/chồng tôi ủng hộ mọi quyết định của tôi.'),
(N'apprentice', N'/əˈprentɪs/', N'người học việc', N'noun', N'INTERMEDIATE', N'Work', N'The apprentice learned quickly.', N'Người học việc học rất nhanh.'),
-- Language / Communication
(N'slang', N'/slæŋ/', N'tiếng lóng', N'noun', N'INTERMEDIATE', N'Language', N'Slang is common among teenagers.', N'Tiếng lóng phổ biến trong giới thanh thiếu niên.'),
(N'idiom', N'/ˈɪdiəm/', N'thành ngữ', N'noun', N'INTERMEDIATE', N'Language', N'It is raining cats and dogs is an idiom.', N'Trời mưa như trút nước là một thành ngữ.'),
(N'proverb', N'/ˈprɒvɜːrb/', N'tục ngữ / châm ngôn', N'noun', N'INTERMEDIATE', N'Language', N'Every proverb contains a lesson.', N'Mỗi câu tục ngữ đều chứa đựng một bài học.'),
(N'syllable', N'/ˈsɪləbl/', N'âm tiết', N'noun', N'INTERMEDIATE', N'Language', N'The word beautiful has three syllables.', N'Từ beautiful có ba âm tiết.'),
(N'fluency', N'/ˈfluːənsi/', N'sự thông thạo / lưu loát', N'noun', N'INTERMEDIATE', N'Language', N'Fluency takes years of practice.', N'Sự lưu loát cần nhiều năm luyện tập.'),
(N'multilingual', N'/ˌmʌltiˈlɪŋɡwəl/', N'thông thạo nhiều ngôn ngữ', N'adjective', N'ADVANCED', N'Language', N'Being multilingual opens many doors.', N'Thông thạo nhiều ngôn ngữ mở ra nhiều cơ hội.'),
-- Character / Personality
(N'clumsy', N'/ˈklʌmzi/', N'vụng về / lóng ngóng', N'adjective', N'BEGINNER', N'Character', N'He is clumsy and often drops things.', N'Anh ấy vụng về và hay đánh rơi đồ vật.'),
(N'frugal', N'/ˈfruːɡəl/', N'tiết kiệm / giản dị', N'adjective', N'INTERMEDIATE', N'Character', N'She is frugal and rarely wastes money.', N'Cô ấy tiết kiệm và hiếm khi lãng phí tiền.'),
(N'witty', N'/ˈwɪti/', N'hóm hỉnh / thông minh dí dỏm', N'adjective', N'INTERMEDIATE', N'Character', N'Her witty remarks made everyone laugh.', N'Những nhận xét hóm hỉnh của cô ấy khiến mọi người cười.'),
(N'gloomy', N'/ˈɡluːmi/', N'ảm đạm / u ám', N'adjective', N'BEGINNER', N'Character', N'He felt gloomy after the bad news.', N'Anh ấy cảm thấy ảm đạm sau tin xấu.'),
(N'naive', N'/naɪˈiːv/', N'ngây thơ / cả tin', N'adjective', N'BEGINNER', N'Character', N'She was naive to trust a stranger.', N'Cô ấy ngây thơ khi tin vào người lạ.'),
(N'sarcastic', N'/sɑːrˈkæstɪk/', N'mỉa mai / châm biếm', N'adjective', N'INTERMEDIATE', N'Character', N'His sarcastic tone annoyed everyone.', N'Giọng mỉa mai của anh ấy khiến mọi người khó chịu.'),
(N'empathetic', N'/ˌempəˈθetɪk/', N'có sự đồng cảm', N'adjective', N'INTERMEDIATE', N'Character', N'A good leader must be empathetic.', N'Một nhà lãnh đạo tốt phải có sự đồng cảm.'),
(N'altruistic', N'/ˌæltruˈɪstɪk/', N'vị tha / không vụ lợi', N'adjective', N'ADVANCED', N'Character', N'Her altruistic actions inspired many people.', N'Những hành động vị tha của cô ấy truyền cảm hứng cho nhiều người.'),
(N'cowardly', N'/ˈkaʊərdli/', N'hèn nhát / nhút nhát', N'adjective', N'INTERMEDIATE', N'Character', N'It was cowardly to walk away from the problem.', N'Né tránh vấn đề là hành động hèn nhát.'),
(N'reckless', N'/ˈrekləs/', N'liều lĩnh / bất cẩn', N'adjective', N'INTERMEDIATE', N'Character', N'Reckless driving causes many accidents.', N'Lái xe liều lĩnh gây ra nhiều tai nạn.'),
(N'proficient', N'/prəˈfɪʃənt/', N'thành thạo / giỏi', N'adjective', N'INTERMEDIATE', N'Work', N'She is proficient in three languages.', N'Cô ấy thành thạo ba ngôn ngữ.'),
(N'adequate', N'/ˈædɪkwɪt/', N'đủ / đáp ứng yêu cầu', N'adjective', N'INTERMEDIATE', N'General', N'Make sure the budget is adequate.', N'Hãy đảm bảo ngân sách là đủ.'),
(N'prosperous', N'/ˈprɒspərəs/', N'thịnh vượng / phát đạt', N'adjective', N'INTERMEDIATE', N'Business', N'The town became prosperous after the factory opened.', N'Thị trấn trở nên thịnh vượng sau khi nhà máy mở cửa.'),
(N'compassionate', N'/kəmˈpæʃənɪt/', N'từ bi / giàu lòng trắc ẩn', N'adjective', N'INTERMEDIATE', N'Character', N'Be compassionate toward those who suffer.', N'Hãy có lòng trắc ẩn với những người đang đau khổ.'),
-- Music / Arts
(N'chord', N'/kɔːrd/', N'hợp âm', N'noun', N'INTERMEDIATE', N'Entertainment', N'He played a beautiful chord on the guitar.', N'Anh ấy chơi một hợp âm đẹp trên cây đàn guitar.'),
(N'acoustic', N'/əˈkuːstɪk/', N'âm thanh học / không dùng điện', N'adjective', N'INTERMEDIATE', N'Entertainment', N'The acoustic version of the song is better.', N'Phiên bản acoustic của bài hát hay hơn.'),
(N'vibration', N'/vaɪˈbreɪʃən/', N'sự rung động / dao động', N'noun', N'INTERMEDIATE', N'Science', N'Sound travels as vibrations through air.', N'Âm thanh truyền đi dưới dạng dao động qua không khí.'),
(N'vocalist', N'/ˈvoʊkəlɪst/', N'ca sĩ / giọng ca', N'noun', N'BEGINNER', N'Entertainment', N'She is the lead vocalist of the band.', N'Cô ấy là giọng ca chính của ban nhạc.'),
(N'instrumental', N'/ˌɪnstrʊˈmentl/', N'nhạc cụ / nhạc không lời', N'adjective', N'INTERMEDIATE', N'Entertainment', N'The instrumental track was calming.', N'Bản nhạc không lời rất thư thái.'),
-- Home / Building
(N'fixture', N'/ˈfɪkstʃər/', N'vật gắn cố định / thiết bị lắp đặt', N'noun', N'INTERMEDIATE', N'Home', N'The bathroom fixtures need replacing.', N'Các thiết bị trong phòng tắm cần được thay thế.'),
(N'terrace', N'/ˈterəs/', N'sân thượng / bậc thềm', N'noun', N'BEGINNER', N'Home', N'They had coffee on the terrace.', N'Họ uống cà phê trên sân thượng.'),
(N'plumbing', N'/ˈplʌmɪŋ/', N'hệ thống ống nước', N'noun', N'INTERMEDIATE', N'Home', N'The plumbing in this house is old.', N'Hệ thống ống nước trong nhà này đã cũ.'),
(N'chimney', N'/ˈtʃɪmni/', N'ống khói', N'noun', N'BEGINNER', N'Home', N'Smoke rose from the chimney.', N'Khói bốc lên từ ống khói.'),
(N'cellar', N'/ˈselər/', N'tầng hầm / hầm rượu', N'noun', N'INTERMEDIATE', N'Home', N'They store wine in the cellar.', N'Họ lưu trữ rượu trong hầm.'),
-- Science / Math
(N'formula', N'/ˈfɔːrmjʊlə/', N'công thức', N'noun', N'BEGINNER', N'Science', N'Use the formula to calculate the area.', N'Dùng công thức để tính diện tích.'),
(N'proportion', N'/prəˈpɔːrʃən/', N'tỉ lệ / sự cân đối', N'noun', N'INTERMEDIATE', N'Science', N'The proportion of water to flour is important.', N'Tỉ lệ nước so với bột là rất quan trọng.'),
(N'diameter', N'/daɪˈæmɪtər/', N'đường kính', N'noun', N'INTERMEDIATE', N'Science', N'Measure the diameter of the circle.', N'Đo đường kính của hình tròn.'),
(N'correlation', N'/ˌkɒrəˈleɪʃən/', N'sự tương quan', N'noun', N'ADVANCED', N'Science', N'There is a correlation between exercise and health.', N'Có sự tương quan giữa tập thể dục và sức khỏe.'),
(N'circulation', N'/ˌsɜːrkjʊˈleɪʃən/', N'sự lưu thông / tuần hoàn', N'noun', N'INTERMEDIATE', N'Health', N'Good circulation keeps your body warm.', N'Tuần hoàn tốt giữ ấm cơ thể bạn.'),
-- Social Issues
(N'inclusion', N'/ɪnˈkluːʒən/', N'sự hòa nhập / bao gồm', N'noun', N'INTERMEDIATE', N'Social', N'Inclusion benefits the whole community.', N'Sự hòa nhập mang lại lợi ích cho toàn cộng đồng.'),
(N'harassment', N'/həˈræsmənt/', N'sự quấy rối', N'noun', N'INTERMEDIATE', N'Social', N'Workplace harassment must be reported.', N'Quấy rối nơi làm việc phải được báo cáo.'),
(N'philanthropy', N'/fɪˈlænθrəpi/', N'hoạt động từ thiện / nhân đạo', N'noun', N'ADVANCED', N'Social', N'His philanthropy helped thousands of children.', N'Hoạt động từ thiện của ông đã giúp đỡ hàng nghìn trẻ em.'),
-- Food / Cooking
(N'garnish', N'/ˈɡɑːrnɪʃ/', N'đồ trang trí món ăn', N'noun', N'INTERMEDIATE', N'Food', N'Add a garnish of parsley before serving.', N'Thêm rau mùi trang trí trước khi phục vụ.'),
(N'broil', N'/brɔɪl/', N'nướng trực tiếp bằng lửa trên', N'verb', N'INTERMEDIATE', N'Food', N'Broil the fish for ten minutes.', N'Nướng cá trong mười phút.'),
(N'ferment', N'/fəˈment/', N'lên men', N'verb', N'INTERMEDIATE', N'Food', N'Kimchi is made by fermenting vegetables.', N'Kim chi được làm bằng cách lên men rau củ.'),
(N'savor', N'/ˈseɪvər/', N'thưởng thức / nếm thử kỹ', N'verb', N'INTERMEDIATE', N'Food', N'Take time to savor every bite.', N'Hãy dành thời gian để thưởng thức từng miếng.'),
(N'aroma', N'/əˈroʊmə/', N'hương thơm', N'noun', N'BEGINNER', N'Food', N'The aroma of fresh coffee filled the room.', N'Hương thơm của cà phê tươi tràn ngập căn phòng.'),
-- Travel
(N'voyage', N'/ˈvɔɪɪdʒ/', N'chuyến hành trình dài / chuyến vượt biển', N'noun', N'INTERMEDIATE', N'Travel', N'Columbus made a historic voyage across the ocean.', N'Columbus thực hiện chuyến vượt đại dương lịch sử.'),
(N'departure', N'/dɪˈpɑːrtʃər/', N'sự khởi hành / cổng xuất phát', N'noun', N'BEGINNER', N'Travel', N'Check the departure time on your ticket.', N'Kiểm tra giờ khởi hành trên vé của bạn.'),
(N'arrival', N'/əˈraɪvəl/', N'sự đến nơi', N'noun', N'BEGINNER', N'Travel', N'What is the expected arrival time?', N'Thời gian đến dự kiến là khi nào?'),
(N'layover', N'/ˈleɪoʊvər/', N'thời gian quá cảnh / dừng chân', N'noun', N'INTERMEDIATE', N'Travel', N'We had a three-hour layover in Singapore.', N'Chúng tôi có ba tiếng quá cảnh ở Singapore.'),
(N'commute', N'/kəˈmjuːt/', N'đi làm hàng ngày / quãng đường đi làm', N'verb', N'BEGINNER', N'Travel', N'She commutes to work by train every day.', N'Cô ấy đi làm bằng tàu mỗi ngày.'),
-- Abstract / General
(N'dilemma', N'/dɪˈlemə/', N'tình huống khó xử / tiến thoái lưỡng nan', N'noun', N'INTERMEDIATE', N'General', N'He faced a dilemma between work and family.', N'Anh ấy đối mặt với tình huống khó xử giữa công việc và gia đình.'),
(N'legacy', N'/ˈleɡəsi/', N'di sản / gia tài để lại', N'noun', N'INTERMEDIATE', N'General', N'Her legacy lives on through her students.', N'Di sản của cô ấy sống mãi qua các học sinh.'),
(N'ambiguity', N'/ˌæmbɪˈɡjuːɪti/', N'sự mơ hồ / không rõ ràng', N'noun', N'ADVANCED', N'General', N'Avoid ambiguity in your writing.', N'Hãy tránh sự mơ hồ trong bài viết của bạn.'),
(N'implication', N'/ˌɪmplɪˈkeɪʃən/', N'hệ quả / ngụ ý', N'noun', N'ADVANCED', N'General', N'Consider the implications before deciding.', N'Hãy xem xét hệ quả trước khi quyết định.'),
(N'deficient', N'/dɪˈfɪʃənt/', N'thiếu hụt / không đủ', N'adjective', N'INTERMEDIATE', N'General', N'A diet deficient in iron causes fatigue.', N'Chế độ ăn thiếu sắt gây mệt mỏi.'),
-- Additional useful words
(N'coordination', N'/koʊˌɔːrdɪˈneɪʃən/', N'sự phối hợp / điều phối', N'noun', N'INTERMEDIATE', N'Work', N'Good coordination between teams is essential.', N'Sự phối hợp tốt giữa các nhóm là thiết yếu.'),
(N'ventilation', N'/ˌventɪˈleɪʃən/', N'sự thông gió / hệ thống thông khí', N'noun', N'INTERMEDIATE', N'Home', N'Good ventilation prevents mold growth.', N'Thông gió tốt ngăn ngừa nấm mốc phát triển.'),
(N'insulation', N'/ˌɪnsjʊˈleɪʃən/', N'sự cách nhiệt / cách điện', N'noun', N'INTERMEDIATE', N'Home', N'Proper insulation keeps the house warm.', N'Cách nhiệt tốt giữ ấm ngôi nhà.'),
(N'debris', N'/dɪˈbriː/', N'mảnh vỡ / đống đổ nát', N'noun', N'INTERMEDIATE', N'General', N'Workers cleared the debris after the storm.', N'Công nhân dọn sạch đống đổ nát sau cơn bão.'),
(N'reservoir', N'/ˈrezəvwɑːr/', N'hồ chứa nước / kho dự trữ', N'noun', N'INTERMEDIATE', N'Nature', N'The reservoir supplies water to the city.', N'Hồ chứa cung cấp nước cho thành phố.'),
(N'crevice', N'/ˈkrevɪs/', N'khe hở / kẽ nứt', N'noun', N'ADVANCED', N'Nature', N'The lizard hid in a crevice in the rock.', N'Con thằn lằn ẩn trong khe đá.'),
(N'momentum', N'/məˈmentəm/', N'đà / động lực', N'noun', N'INTERMEDIATE', N'General', N'The project gained momentum after funding.', N'Dự án có thêm đà sau khi được tài trợ.'),
(N'turbulence', N'/ˈtɜːrbjʊləns/', N'sự hỗn loạn / nhiễu loạn không khí', N'noun', N'ADVANCED', N'Travel', N'The plane hit turbulence over the ocean.', N'Máy bay gặp nhiễu loạn không khí trên đại dương.'),
(N'duration', N'/djʊˈreɪʃən/', N'thời lượng / khoảng thời gian', N'noun', N'BEGINNER', N'Time', N'The duration of the film is two hours.', N'Thời lượng bộ phim là hai tiếng.'),
(N'frequency', N'/ˈfriːkwənsi/', N'tần suất / tần số', N'noun', N'INTERMEDIATE', N'General', N'Increase the frequency of your exercise.', N'Tăng tần suất tập thể dục của bạn.'),
(N'intensity', N'/ɪnˈtensɪti/', N'cường độ / mức độ mãnh liệt', N'noun', N'INTERMEDIATE', N'General', N'Train at high intensity for better results.', N'Tập luyện ở cường độ cao để có kết quả tốt hơn.'),
(N'consistency', N'/kənˈsɪstənsi/', N'sự nhất quán / đều đặn', N'noun', N'INTERMEDIATE', N'Work', N'Consistency is the key to long-term success.', N'Sự nhất quán là chìa khóa cho thành công lâu dài.'),
(N'potential', N'/pəˈtenʃəl/', N'tiềm năng', N'noun', N'BEGINNER', N'General', N'Every child has great potential.', N'Mỗi đứa trẻ đều có tiềm năng lớn.'),
(N'obstacle', N'/ˈɒbstəkl/', N'trở ngại / vật cản', N'noun', N'BEGINNER', N'General', N'Every obstacle is a chance to grow.', N'Mỗi trở ngại là cơ hội để phát triển.'),
(N'breakthrough', N'/ˈbreɪkθruː/', N'bước đột phá', N'noun', N'INTERMEDIATE', N'General', N'Scientists made a breakthrough in cancer research.', N'Các nhà khoa học đạt được đột phá trong nghiên cứu ung thư.'),
(N'privilege', N'/ˈprɪvɪlɪdʒ/', N'đặc quyền / ưu đãi', N'noun', N'INTERMEDIATE', N'Social', N'Education is a privilege not everyone has.', N'Giáo dục là đặc quyền không phải ai cũng có.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, category, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('trauma','phobia','addiction','paranoia','mindfulness','habitat','species','camouflage','extinct','endangered','nocturnal','avalanche','blizzard','typhoon','heatwave','forecast','accessory','texture','velvet','linen','fashionable','stylish','acquaintance','companion','guardian','spouse','apprentice','slang','idiom','proverb','syllable','fluency','multilingual','clumsy','frugal','witty','gloomy','naive','sarcastic','empathetic','altruistic','cowardly','reckless','proficient','adequate','prosperous','compassionate','chord','acoustic','vibration','vocalist','instrumental','fixture','terrace','plumbing','chimney','cellar','formula','proportion','diameter','correlation','circulation','inclusion','harassment','philanthropy','garnish','broil','ferment','savor','aroma','voyage','departure','arrival','layover','commute','dilemma','legacy','ambiguity','implication','deficient','coordination','ventilation','insulation','debris','reservoir','crevice','momentum','turbulence','duration','frequency','intensity','consistency','potential','obstacle','breakthrough','privilege');
