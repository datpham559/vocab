--liquibase formatted sql

--changeset vocab:047-seed-words-batch40
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: More everyday common words
(N'accomplish', N'/əˈkɒmplɪʃ/', N'hoàn thành', N'verb', N'BEGINNER', N'You can accomplish great things.', N'Bạn có thể hoàn thành những điều vĩ đại.'),
(N'afternoon', N'/ˌɑːftərˈnuːn/', N'buổi chiều', N'noun', N'BEGINNER', N'See you this afternoon.', N'Hẹn gặp chiều nay.'),
(N'airport', N'/ˈeərpɔːrt/', N'sân bay', N'noun', N'BEGINNER', N'Arrive at the airport early.', N'Đến sân bay sớm.'),
(N'apartment', N'/əˈpɑːrtmənt/', N'căn hộ chung cư', N'noun', N'BEGINNER', N'They live in a high-rise apartment.', N'Họ sống trong chung cư cao tầng.'),
(N'autumn', N'/ˈɔːtəm/', N'mùa thu', N'noun', N'BEGINNER', N'Autumn leaves are colorful.', N'Lá mùa thu nhiều màu sắc.'),
(N'bakery', N'/ˈbeɪkəri/', N'tiệm bánh', N'noun', N'BEGINNER', N'Buy fresh bread at the bakery.', N'Mua bánh mì tươi ở tiệm bánh.'),
(N'balcony', N'/ˈbælkəni/', N'ban công', N'noun', N'BEGINNER', N'Sit on the balcony to relax.', N'Ngồi trên ban công để thư giãn.'),
(N'bank', N'/bæŋk/', N'ngân hàng / bờ sông', N'noun', N'BEGINNER', N'Open a bank account today.', N'Mở tài khoản ngân hàng hôm nay.'),
(N'bedroom', N'/ˈbedrʊm/', N'phòng ngủ', N'noun', N'BEGINNER', N'The bedroom is clean and tidy.', N'Phòng ngủ sạch sẽ và gọn gàng.'),
(N'bicycle', N'/ˈbaɪsɪkəl/', N'xe đạp', N'noun', N'BEGINNER', N'Ride your bicycle to school.', N'Đạp xe đến trường.'),
(N'birthday', N'/ˈbɜːrθdeɪ/', N'sinh nhật', N'noun', N'BEGINNER', N'Happy birthday to you!', N'Chúc mừng sinh nhật bạn!'),
(N'borrow', N'/ˈbɒroʊ/', N'mượn', N'verb', N'BEGINNER', N'Can I borrow your pen?', N'Tôi có thể mượn bút của bạn không?'),
(N'bottle', N'/ˈbɒtəl/', N'chai', N'noun', N'BEGINNER', N'Drink a bottle of water daily.', N'Uống một chai nước mỗi ngày.'),
(N'breakfast', N'/ˈbrekfəst/', N'bữa sáng', N'noun', N'BEGINNER', N'Never skip breakfast.', N'Đừng bỏ bữa sáng.'),
(N'bridge', N'/brɪdʒ/', N'cây cầu', N'noun', N'BEGINNER', N'Cross the bridge carefully.', N'Qua cầu cẩn thận.'),
(N'building', N'/ˈbɪldɪŋ/', N'tòa nhà', N'noun', N'BEGINNER', N'The new building is impressive.', N'Tòa nhà mới thật ấn tượng.'),
(N'bus', N'/bʌs/', N'xe buýt', N'noun', N'BEGINNER', N'Take the bus to the station.', N'Đi xe buýt đến ga.'),
(N'button', N'/ˈbʌtən/', N'nút / cúc áo', N'noun', N'BEGINNER', N'Press the button to start.', N'Nhấn nút để bắt đầu.'),
(N'calendar', N'/ˈkælɪndər/', N'lịch', N'noun', N'BEGINNER', N'Check the calendar for the date.', N'Kiểm tra lịch để xem ngày.'),
(N'camera', N'/ˈkæmərə/', N'máy ảnh', N'noun', N'BEGINNER', N'Take a photo with your camera.', N'Chụp ảnh bằng máy ảnh.'),
(N'canteen', N'/kænˈtiːn/', N'căng-tin / nhà ăn', N'noun', N'BEGINNER', N'Eat lunch in the canteen.', N'Ăn trưa ở căng-tin.'),
(N'card', N'/kɑːrd/', N'thẻ / thiếp', N'noun', N'BEGINNER', N'Send a birthday card.', N'Gửi thiếp sinh nhật.'),
(N'careful', N'/ˈkeərfəl/', N'cẩn thận', N'adjective', N'BEGINNER', N'Be careful when crossing the road.', N'Cẩn thận khi qua đường.'),
(N'carry', N'/ˈkæri/', N'mang / xách', N'verb', N'BEGINNER', N'Carry your bag on your back.', N'Mang túi trên lưng.'),
(N'cash', N'/kæʃ/', N'tiền mặt', N'noun', N'BEGINNER', N'Pay with cash or card.', N'Thanh toán bằng tiền mặt hay thẻ.'),
(N'catch', N'/kætʃ/', N'bắt / nắm bắt', N'verb', N'BEGINNER', N'Catch the ball!', N'Bắt bóng!'),
(N'change', N'/tʃeɪndʒ/', N'thay đổi / tiền lẻ', N'verb', N'BEGINNER', N'Change your habits for the better.', N'Thay đổi thói quen cho tốt hơn.'),
(N'chat', N'/tʃæt/', N'trò chuyện', N'verb', N'BEGINNER', N'Let''s chat over coffee.', N'Hãy trò chuyện bên ly cà phê.'),
(N'child', N'/tʃaɪld/', N'đứa trẻ', N'noun', N'BEGINNER', N'Every child deserves education.', N'Mọi đứa trẻ đều xứng đáng được học.'),
(N'choose', N'/tʃuːz/', N'chọn lựa', N'verb', N'BEGINNER', N'Choose wisely.', N'Lựa chọn một cách khôn ngoan.'),
(N'cinema', N'/ˈsɪnɪmə/', N'rạp chiếu phim', N'noun', N'BEGINNER', N'Let''s go to the cinema tonight.', N'Hãy đi rạp chiếu phim tối nay.'),
(N'city', N'/ˈsɪti/', N'thành phố', N'noun', N'BEGINNER', N'I love living in the city.', N'Tôi thích sống ở thành phố.'),
(N'clean', N'/kliːn/', N'sạch / dọn dẹp', N'adjective', N'BEGINNER', N'Keep your room clean.', N'Giữ phòng của bạn sạch sẽ.'),
(N'clever', N'/ˈklevər/', N'thông minh / khéo léo', N'adjective', N'BEGINNER', N'She is a clever student.', N'Cô ấy là học sinh thông minh.'),
(N'close', N'/kloʊs/', N'gần / đóng lại', N'adjective', N'BEGINNER', N'Stand close to the wall.', N'Đứng gần tường.'),
(N'clothes', N'/kloʊðz/', N'quần áo', N'noun', N'BEGINNER', N'Fold your clothes neatly.', N'Gấp quần áo gọn gàng.'),
(N'cloud', N'/klaʊd/', N'đám mây', N'noun', N'BEGINNER', N'Clouds are forming in the sky.', N'Mây đang hình thành trên bầu trời.'),
(N'cold', N'/koʊld/', N'lạnh / cảm lạnh', N'adjective', N'BEGINNER', N'Wear a coat when it''s cold.', N'Mặc áo khoác khi trời lạnh.'),
(N'color', N'/ˈkʌlər/', N'màu sắc', N'noun', N'BEGINNER', N'What is your favorite color?', N'Màu yêu thích của bạn là gì?'),
(N'come', N'/kʌm/', N'đến / tới', N'verb', N'BEGINNER', N'Come here right now.', N'Đến đây ngay bây giờ.'),
(N'company', N'/ˈkʌmpəni/', N'công ty / bạn đồng hành', N'noun', N'BEGINNER', N'She started her own company.', N'Cô ấy thành lập công ty riêng.'),
(N'cook', N'/kʊk/', N'nấu ăn / đầu bếp', N'verb', N'BEGINNER', N'She loves to cook Italian food.', N'Cô ấy thích nấu đồ ăn Ý.'),
(N'corner', N'/ˈkɔːrnər/', N'góc / góc phố', N'noun', N'BEGINNER', N'Turn left at the corner.', N'Rẽ trái ở góc phố.'),
(N'cost', N'/kɒst/', N'chi phí / giá tiền', N'noun', N'BEGINNER', N'What is the total cost?', N'Tổng chi phí là bao nhiêu?'),
(N'country', N'/ˈkʌntri/', N'đất nước / vùng nông thôn', N'noun', N'BEGINNER', N'Which country do you come from?', N'Bạn đến từ đất nước nào?'),
(N'cup', N'/kʌp/', N'cốc / ly', N'noun', N'BEGINNER', N'I need a cup of coffee.', N'Tôi cần một ly cà phê.'),
(N'customer', N'/ˈkʌstəmər/', N'khách hàng', N'noun', N'BEGINNER', N'The customer is always right.', N'Khách hàng luôn luôn đúng.'),
(N'dark', N'/dɑːrk/', N'tối', N'adjective', N'BEGINNER', N'Turn on the light, it''s dark.', N'Bật đèn lên, trời tối.'),
(N'daughter', N'/ˈdɔːtər/', N'con gái', N'noun', N'BEGINNER', N'She is a loving daughter.', N'Cô ấy là một người con gái hiếu thảo.'),
(N'decide', N'/dɪˈsaɪd/', N'quyết định', N'verb', N'BEGINNER', N'Decide what you want to do.', N'Quyết định bạn muốn làm gì.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('afternoon','airport','autumn','bakery','balcony','bank','bedroom','bicycle','birthday','borrow','bottle','breakfast','bridge','building','bus','button','calendar','camera','canteen','card','careful','carry','cash','catch','change','chat','child','choose','cinema','city','clean','clever','close','clothes','cloud','cold','color','come','company','cook','corner','cost','country','cup','customer','dark','daughter','decide');
