--liquibase formatted sql

--changeset vocab:028-seed-words-batch21
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Food & Cooking
(N'bake', N'/beɪk/', N'nướng (lò)', N'verb', N'BEGINNER', N'Bake the cake for 30 minutes.', N'Nướng bánh trong 30 phút.'),
(N'boil', N'/bɔɪl/', N'đun sôi', N'verb', N'BEGINNER', N'Boil the water before drinking.', N'Đun sôi nước trước khi uống.'),
(N'chop', N'/tʃɒp/', N'thái / chặt', N'verb', N'BEGINNER', N'Chop the vegetables finely.', N'Thái nhỏ rau củ.'),
(N'fry', N'/fraɪ/', N'chiên / rán', N'verb', N'BEGINNER', N'Fry the egg in butter.', N'Rán trứng với bơ.'),
(N'grill', N'/ɡrɪl/', N'nướng (vỉ)', N'verb', N'BEGINNER', N'Grill the meat on the barbecue.', N'Nướng thịt trên vỉ barbecue.'),
(N'ingredient', N'/ɪnˈɡriːdiənt/', N'nguyên liệu', N'noun', N'INTERMEDIATE', N'Mix all the ingredients together.', N'Trộn tất cả nguyên liệu lại.'),
(N'leftover', N'/ˈleftoʊvər/', N'thức ăn thừa', N'noun', N'BEGINNER', N'Put the leftovers in the fridge.', N'Để thức ăn thừa vào tủ lạnh.'),
(N'marinade', N'/ˌmærɪˈneɪd/', N'nước ướp', N'noun', N'INTERMEDIATE', N'Soak the meat in marinade overnight.', N'Ngâm thịt trong nước ướp qua đêm.'),
(N'pastry', N'/ˈpeɪstri/', N'bánh ngọt / bột mì', N'noun', N'INTERMEDIATE', N'She loves making pastry.', N'Cô ấy thích làm bánh ngọt.'),
(N'recipe', N'/ˈresɪpi/', N'công thức nấu ăn', N'noun', N'BEGINNER', N'Follow the recipe step by step.', N'Làm theo công thức từng bước.'),
(N'roast', N'/roʊst/', N'quay / nướng', N'verb', N'BEGINNER', N'Roast the chicken in the oven.', N'Quay gà trong lò.'),
(N'seasoning', N'/ˈsiːzənɪŋ/', N'gia vị', N'noun', N'INTERMEDIATE', N'Add seasoning to taste.', N'Thêm gia vị theo khẩu vị.'),
(N'simmer', N'/ˈsɪmər/', N'đun liu riu', N'verb', N'INTERMEDIATE', N'Simmer the soup for 20 minutes.', N'Đun liu riu súp trong 20 phút.'),
(N'steam', N'/stiːm/', N'hấp / hơi nước', N'verb', N'BEGINNER', N'Steam the fish to keep it healthy.', N'Hấp cá để giữ lành mạnh.'),
(N'topping', N'/ˈtɒpɪŋ/', N'lớp phủ / topping', N'noun', N'BEGINNER', N'Choose your pizza topping.', N'Chọn topping cho pizza của bạn.'),
-- Thematic: Nature & Weather
(N'breeze', N'/briːz/', N'gió nhẹ', N'noun', N'BEGINNER', N'A cool breeze refreshed us.', N'Gió mát làm chúng tôi sảng khoái.'),
(N'cliff', N'/klɪf/', N'vách đá', N'noun', N'INTERMEDIATE', N'The cliff overlooks the ocean.', N'Vách đá nhìn ra đại dương.'),
(N'dew', N'/djuː/', N'sương mai', N'noun', N'INTERMEDIATE', N'Dew covered the grass in the morning.', N'Sương mai phủ lên cỏ vào buổi sáng.'),
(N'drought', N'/draʊt/', N'hạn hán', N'noun', N'INTERMEDIATE', N'The drought destroyed many crops.', N'Hạn hán phá hủy nhiều vụ mùa.'),
(N'earthquake', N'/ˈɜːrθkweɪk/', N'động đất', N'noun', N'INTERMEDIATE', N'The earthquake shook the city.', N'Động đất làm rung chuyển thành phố.'),
(N'fog', N'/fɒɡ/', N'sương mù', N'noun', N'BEGINNER', N'Drive carefully in thick fog.', N'Lái xe cẩn thận khi sương mù dày đặc.'),
(N'frost', N'/frɒst/', N'sương giá', N'noun', N'INTERMEDIATE', N'Frost covered the windows overnight.', N'Sương giá phủ lên cửa sổ qua đêm.'),
(N'glacier', N'/ˈɡleɪsiər/', N'sông băng', N'noun', N'ADVANCED', N'Glaciers are melting due to warming.', N'Sông băng đang tan chảy do ấm lên.'),
(N'harvest', N'/ˈhɑːrvɪst/', N'thu hoạch', N'noun', N'INTERMEDIATE', N'The harvest was excellent this year.', N'Thu hoạch rất tốt năm nay.'),
(N'hurricane', N'/ˈhʌrɪkeɪn/', N'bão lớn', N'noun', N'INTERMEDIATE', N'A hurricane hit the coast.', N'Một cơn bão lớn đổ vào bờ biển.'),
(N'landscape', N'/ˈlændskeɪp/', N'cảnh quan', N'noun', N'INTERMEDIATE', N'The landscape is breathtaking.', N'Cảnh quan thật ngoạn mục.'),
(N'meadow', N'/ˈmedoʊ/', N'đồng cỏ', N'noun', N'INTERMEDIATE', N'Cows graze in the meadow.', N'Bò gặm cỏ trên đồng.'),
(N'pebble', N'/ˈpebəl/', N'viên đá cuội', N'noun', N'BEGINNER', N'Children threw pebbles into the lake.', N'Trẻ em ném đá cuội xuống hồ.'),
(N'tide', N'/taɪd/', N'thủy triều', N'noun', N'INTERMEDIATE', N'The tide is coming in.', N'Thủy triều đang lên.'),
(N'tornado', N'/tɔːrˈneɪdoʊ/', N'lốc xoáy', N'noun', N'INTERMEDIATE', N'A tornado destroyed the town.', N'Lốc xoáy phá hủy thị trấn.'),
(N'valley', N'/ˈvæli/', N'thung lũng', N'noun', N'BEGINNER', N'The valley was green and peaceful.', N'Thung lũng xanh tươi và yên bình.'),
(N'volcano', N'/vɒlˈkeɪnoʊ/', N'núi lửa', N'noun', N'INTERMEDIATE', N'The volcano erupted yesterday.', N'Núi lửa phun trào hôm qua.'),
(N'waterfall', N'/ˈwɔːtərfɔːl/', N'thác nước', N'noun', N'BEGINNER', N'The waterfall is very beautiful.', N'Thác nước rất đẹp.'),
-- Thematic: Travel & Tourism
(N'abroad', N'/əˈbrɔːd/', N'ở nước ngoài', N'adverb', N'BEGINNER', N'She studied abroad for two years.', N'Cô ấy học ở nước ngoài hai năm.'),
(N'accommodation', N'/əˌkɒməˈdeɪʃən/', N'chỗ ở / chỗ lưu trú', N'noun', N'INTERMEDIATE', N'Book accommodation in advance.', N'Đặt chỗ ở trước.'),
(N'airline', N'/ˈeərlaɪn/', N'hãng hàng không', N'noun', N'BEGINNER', N'Which airline do you prefer?', N'Bạn thích hãng hàng không nào?'),
(N'backpack', N'/ˈbækpæk/', N'ba lô', N'noun', N'BEGINNER', N'Pack light in your backpack.', N'Đóng gói nhẹ trong ba lô.'),
(N'cruise', N'/kruːz/', N'du thuyền', N'noun', N'INTERMEDIATE', N'They went on a Caribbean cruise.', N'Họ đi du thuyền Caribbean.'),
(N'destination', N'/ˌdestɪˈneɪʃən/', N'điểm đến', N'noun', N'INTERMEDIATE', N'Paris is a dream destination.', N'Paris là điểm đến trong mơ.'),
(N'excursion', N'/ɪkˈskɜːrʒən/', N'chuyến tham quan ngắn', N'noun', N'INTERMEDIATE', N'We took a day excursion to the mountains.', N'Chúng tôi đi tham quan một ngày lên núi.'),
(N'guidebook', N'/ˈɡaɪdbʊk/', N'sách hướng dẫn du lịch', N'noun', N'BEGINNER', N'Buy a guidebook before you travel.', N'Mua sách hướng dẫn trước khi du lịch.'),
(N'itinerary', N'/aɪˈtɪnəreri/', N'lịch trình', N'noun', N'INTERMEDIATE', N'Plan your itinerary carefully.', N'Lên kế hoạch lịch trình cẩn thận.'),
(N'landmark', N'/ˈlændmɑːrk/', N'địa danh nổi tiếng', N'noun', N'INTERMEDIATE', N'The Eiffel Tower is a famous landmark.', N'Tháp Eiffel là địa danh nổi tiếng.'),
(N'luggage', N'/ˈlʌɡɪdʒ/', N'hành lý', N'noun', N'BEGINNER', N'Check your luggage at the counter.', N'Ký gửi hành lý tại quầy.'),
(N'passport', N'/ˈpɑːspɔːrt/', N'hộ chiếu', N'noun', N'BEGINNER', N'Don''t forget your passport.', N'Đừng quên hộ chiếu.'),
(N'souvenir', N'/ˌsuːvəˈnɪər/', N'quà lưu niệm', N'noun', N'BEGINNER', N'I bought souvenirs for my family.', N'Tôi mua quà lưu niệm cho gia đình.'),
(N'terminal', N'/ˈtɜːrmɪnəl/', N'nhà ga / bến cuối', N'noun', N'INTERMEDIATE', N'Meet me at terminal 2.', N'Gặp tôi ở nhà ga số 2.'),
(N'visa', N'/ˈviːzə/', N'thị thực / visa', N'noun', N'BEGINNER', N'Apply for a visa online.', N'Đăng ký visa trực tuyến.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('bake','boil','chop','fry','grill','ingredient','leftover','marinade','pastry','recipe','roast','seasoning','simmer','steam','topping','breeze','cliff','dew','drought','earthquake','fog','frost','glacier','harvest','hurricane','landscape','meadow','pebble','tide','tornado','valley','volcano','waterfall','abroad','accommodation','airline','backpack','cruise','destination','excursion','guidebook','itinerary','landmark','luggage','passport','souvenir','terminal','visa');
