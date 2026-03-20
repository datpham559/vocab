--liquibase formatted sql

--changeset vocab:015-seed-words-batch8
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- BEGINNER: Sports & Activities
(N'sport', N'/spɔːrt/', N'thể thao', N'noun', N'BEGINNER', N'Do you play any sport?', N'Bạn có chơi thể thao nào không?'),
(N'football', N'/ˈfʊtbɔːl/', N'bóng đá', N'noun', N'BEGINNER', N'Football is popular worldwide.', N'Bóng đá phổ biến trên toàn thế giới.'),
(N'basketball', N'/ˈbæskɪtbɔːl/', N'bóng rổ', N'noun', N'BEGINNER', N'He plays basketball every weekend.', N'Anh ấy chơi bóng rổ mỗi cuối tuần.'),
(N'swimming', N'/ˈswɪmɪŋ/', N'bơi lội', N'noun', N'BEGINNER', N'Swimming is good exercise.', N'Bơi lội là bài tập tốt.'),
(N'tennis', N'/ˈtenɪs/', N'quần vợt', N'noun', N'BEGINNER', N'She plays tennis every morning.', N'Cô ấy chơi quần vợt mỗi sáng.'),
(N'team', N'/tiːm/', N'đội nhóm', N'noun', N'BEGINNER', N'Our team won the match.', N'Đội chúng tôi đã thắng trận.'),
(N'game', N'/ɡeɪm/', N'trò chơi / trận đấu', N'noun', N'BEGINNER', N'The game was exciting.', N'Trận đấu rất hấp dẫn.'),
(N'win', N'/wɪn/', N'thắng', N'verb', N'BEGINNER', N'We won the championship.', N'Chúng tôi đã vô địch.'),
(N'lose', N'/luːz/', N'thua', N'verb', N'BEGINNER', N'It''s okay to lose sometimes.', N'Thua đôi khi cũng không sao.'),
(N'score', N'/skɔːr/', N'ghi điểm / tỷ số', N'noun', N'BEGINNER', N'What is the score?', N'Tỷ số là bao nhiêu?'),
(N'practice', N'/ˈpræktɪs/', N'luyện tập', N'verb', N'BEGINNER', N'Practice every day to improve.', N'Luyện tập mỗi ngày để tiến bộ.'),
(N'exercise', N'/ˈeksərsaɪz/', N'tập thể dục', N'verb', N'BEGINNER', N'Exercise at least 30 minutes daily.', N'Tập thể dục ít nhất 30 phút mỗi ngày.'),
(N'gym', N'/dʒɪm/', N'phòng tập gym', N'noun', N'BEGINNER', N'I go to the gym three times a week.', N'Tôi đến gym ba lần một tuần.'),
(N'race', N'/reɪs/', N'cuộc đua', N'noun', N'BEGINNER', N'She won the race.', N'Cô ấy đã thắng cuộc đua.'),
(N'match', N'/mætʃ/', N'trận đấu', N'noun', N'BEGINNER', N'Watch the football match tonight.', N'Xem trận bóng đá tối nay.'),
-- BEGINNER: Weather & Seasons
(N'weather', N'/ˈweðər/', N'thời tiết', N'noun', N'BEGINNER', N'The weather is nice today.', N'Thời tiết hôm nay đẹp.'),
(N'temperature', N'/ˈtempərətʃər/', N'nhiệt độ', N'noun', N'BEGINNER', N'The temperature dropped today.', N'Nhiệt độ giảm hôm nay.'),
(N'hot', N'/hɒt/', N'nóng', N'adjective', N'BEGINNER', N'It is very hot in summer.', N'Mùa hè rất nóng.'),
(N'cold', N'/koʊld/', N'lạnh', N'adjective', N'BEGINNER', N'Wear a coat in cold weather.', N'Mặc áo khoác khi trời lạnh.'),
(N'warm', N'/wɔːrm/', N'ấm áp', N'adjective', N'BEGINNER', N'Spring is warm and sunny.', N'Mùa xuân ấm áp và nắng.'),
(N'cool', N'/kuːl/', N'mát mẻ', N'adjective', N'BEGINNER', N'The evening is cool.', N'Buổi tối mát mẻ.'),
(N'spring', N'/sprɪŋ/', N'mùa xuân', N'noun', N'BEGINNER', N'Flowers bloom in spring.', N'Hoa nở vào mùa xuân.'),
(N'summer', N'/ˈsʌmər/', N'mùa hè', N'noun', N'BEGINNER', N'We go to the beach in summer.', N'Chúng tôi đi biển vào mùa hè.'),
(N'autumn', N'/ˈɔːtəm/', N'mùa thu', N'noun', N'BEGINNER', N'Leaves fall in autumn.', N'Lá rụng vào mùa thu.'),
(N'winter', N'/ˈwɪntər/', N'mùa đông', N'noun', N'BEGINNER', N'It snows in winter.', N'Mùa đông có tuyết.'),
(N'storm', N'/stɔːrm/', N'cơn bão', N'noun', N'BEGINNER', N'A big storm is coming.', N'Một cơn bão lớn đang đến.'),
(N'thunder', N'/ˈθʌndər/', N'tiếng sấm', N'noun', N'BEGINNER', N'I hear thunder outside.', N'Tôi nghe tiếng sấm ở ngoài.'),
(N'lightning', N'/ˈlaɪtnɪŋ/', N'tia sét', N'noun', N'BEGINNER', N'Stay indoors during lightning.', N'Ở trong nhà khi có sét.'),
(N'foggy', N'/ˈfɒɡi/', N'có sương mù', N'adjective', N'BEGINNER', N'Drive carefully when it is foggy.', N'Lái xe cẩn thận khi có sương mù.'),
(N'sunny', N'/ˈsʌni/', N'nắng', N'adjective', N'BEGINNER', N'It''s a sunny day today.', N'Hôm nay trời nắng đẹp.'),
(N'cloudy', N'/ˈklaʊdi/', N'nhiều mây', N'adjective', N'BEGINNER', N'The sky is cloudy today.', N'Bầu trời hôm nay nhiều mây.'),
-- INTERMEDIATE: Food & Cooking
(N'ingredient', N'/ɪnˈɡriːdiənt/', N'nguyên liệu', N'noun', N'INTERMEDIATE', N'List all the ingredients.', N'Liệt kê tất cả nguyên liệu.'),
(N'recipe', N'/ˈresɪpi/', N'công thức nấu ăn', N'noun', N'INTERMEDIATE', N'Follow the recipe carefully.', N'Làm theo công thức cẩn thận.'),
(N'cuisine', N'/kwɪˈziːn/', N'ẩm thực', N'noun', N'INTERMEDIATE', N'Italian cuisine is delicious.', N'Ẩm thực Ý rất ngon.'),
(N'roast', N'/roʊst/', N'nướng (lò)', N'verb', N'INTERMEDIATE', N'Roast the chicken for an hour.', N'Nướng gà trong một giờ.'),
(N'marinate', N'/ˈmærɪneɪt/', N'ướp', N'verb', N'INTERMEDIATE', N'Marinate the meat overnight.', N'Ướp thịt qua đêm.'),
(N'simmer', N'/ˈsɪmər/', N'đun lửa nhỏ / sôi liu riu', N'verb', N'INTERMEDIATE', N'Simmer the sauce for 20 minutes.', N'Đun nước sốt với lửa nhỏ 20 phút.'),
(N'bake', N'/beɪk/', N'nướng (bánh)', N'verb', N'INTERMEDIATE', N'Bake at 180°C for 30 minutes.', N'Nướng ở 180°C trong 30 phút.'),
(N'grill', N'/ɡrɪl/', N'nướng vỉ', N'verb', N'INTERMEDIATE', N'Grill the steak on high heat.', N'Nướng bít tết ở lửa cao.'),
(N'seasoning', N'/ˈsiːzənɪŋ/', N'gia vị', N'noun', N'INTERMEDIATE', N'Add seasoning to taste.', N'Thêm gia vị theo khẩu vị.'),
(N'portion', N'/ˈpɔːrʃən/', N'khẩu phần', N'noun', N'INTERMEDIATE', N'The portion was too big.', N'Khẩu phần quá lớn.'),
(N'vegetarian', N'/ˌvedʒɪˈteriən/', N'người ăn chay', N'noun', N'INTERMEDIATE', N'She is a vegetarian.', N'Cô ấy là người ăn chay.'),
(N'organic', N'/ɔːrˈɡænɪk/', N'hữu cơ', N'adjective', N'INTERMEDIATE', N'Buy organic fruits and vegetables.', N'Mua rau củ hữu cơ.'),
(N'nutritious', N'/njuːˈtrɪʃəs/', N'có dinh dưỡng', N'adjective', N'INTERMEDIATE', N'Eat nutritious food to stay healthy.', N'Ăn thực phẩm dinh dưỡng để khỏe mạnh.'),
(N'calorie', N'/ˈkæləri/', N'calo', N'noun', N'INTERMEDIATE', N'Count the calories in your food.', N'Tính lượng calo trong thức ăn.'),
(N'protein', N'/ˈproʊtiːn/', N'protein / chất đạm', N'noun', N'INTERMEDIATE', N'Meat and fish are high in protein.', N'Thịt và cá giàu protein.'),
-- ADVANCED: Environmental Science
(N'deforestation', N'/ˌdiːˌfɒrɪˈsteɪʃən/', N'nạn phá rừng', N'noun', N'ADVANCED', N'Deforestation destroys biodiversity.', N'Nạn phá rừng phá hủy đa dạng sinh học.'),
(N'biodiversity', N'/ˌbaɪoʊdaɪˈvɜːrsɪti/', N'đa dạng sinh học', N'noun', N'ADVANCED', N'Protect biodiversity at all costs.', N'Bảo vệ đa dạng sinh học bằng mọi giá.'),
(N'greenhouse gas', N'/ˈɡriːnhaʊs ɡæs/', N'khí nhà kính', N'noun', N'ADVANCED', N'Reduce greenhouse gas emissions.', N'Giảm phát thải khí nhà kính.'),
(N'ozone', N'/ˈoʊzoʊn/', N'tầng ozone', N'noun', N'ADVANCED', N'Protect the ozone layer.', N'Bảo vệ tầng ozone.'),
(N'fossil fuel', N'/ˈfɒsəl fjuːəl/', N'nhiên liệu hóa thạch', N'noun', N'ADVANCED', N'Fossil fuels cause pollution.', N'Nhiên liệu hóa thạch gây ô nhiễm.'),
(N'carbon footprint', N'/ˈkɑːrbən ˈfʊtprɪnt/', N'dấu chân carbon', N'noun', N'ADVANCED', N'Reduce your carbon footprint.', N'Giảm dấu chân carbon của bạn.'),
(N'reforestation', N'/ˌriːˌfɒrɪˈsteɪʃən/', N'tái trồng rừng', N'noun', N'ADVANCED', N'Reforestation helps restore ecosystems.', N'Tái trồng rừng giúp phục hồi hệ sinh thái.'),
(N'erosion', N'/ɪˈroʊʒən/', N'xói mòn', N'noun', N'ADVANCED', N'Soil erosion is a major problem.', N'Xói mòn đất là vấn đề lớn.'),
(N'conservation', N'/ˌkɒnsərˈveɪʃən/', N'bảo tồn', N'noun', N'ADVANCED', N'Wildlife conservation is crucial.', N'Bảo tồn động vật hoang dã rất quan trọng.'),
(N'emission', N'/ɪˈmɪʃən/', N'sự phát thải', N'noun', N'ADVANCED', N'Cut carbon emissions by 50%.', N'Cắt giảm phát thải carbon 50%.'),
-- ADVANCED: Technology & Future
(N'artificial intelligence', N'/ˌɑːrtɪˈfɪʃəl ɪnˈtelɪdʒəns/', N'trí tuệ nhân tạo', N'noun', N'ADVANCED', N'AI is changing the world.', N'Trí tuệ nhân tạo đang thay đổi thế giới.'),
(N'machine learning', N'/məˈʃiːn ˈlɜːrnɪŋ/', N'học máy', N'noun', N'ADVANCED', N'Machine learning powers recommendation systems.', N'Học máy vận hành các hệ thống gợi ý.'),
(N'automation', N'/ˌɔːtəˈmeɪʃən/', N'tự động hóa', N'noun', N'ADVANCED', N'Automation replaces manual work.', N'Tự động hóa thay thế công việc thủ công.'),
(N'blockchain', N'/ˈblɒktʃeɪn/', N'chuỗi khối / blockchain', N'noun', N'ADVANCED', N'Blockchain ensures data security.', N'Blockchain đảm bảo bảo mật dữ liệu.'),
(N'cybersecurity', N'/ˌsaɪbərsɪˈkjʊərɪti/', N'an ninh mạng', N'noun', N'ADVANCED', N'Cybersecurity protects our data.', N'An ninh mạng bảo vệ dữ liệu của chúng ta.'),
(N'augmented reality', N'/ˌɔːɡmentɪd riˈæləti/', N'thực tế tăng cường', N'noun', N'ADVANCED', N'Augmented reality enhances experiences.', N'Thực tế tăng cường nâng cao trải nghiệm.'),
(N'nanotechnology', N'/ˌnænoʊtekˈnɒlədʒi/', N'công nghệ nano', N'noun', N'ADVANCED', N'Nanotechnology has medical uses.', N'Công nghệ nano có ứng dụng y tế.'),
(N'innovation', N'/ˌɪnəˈveɪʃən/', N'sự đổi mới / cải tiến', N'noun', N'ADVANCED', N'Innovation drives economic growth.', N'Đổi mới thúc đẩy tăng trưởng kinh tế.'),
(N'disruptive', N'/dɪsˈrʌptɪv/', N'mang tính phá vỡ', N'adjective', N'ADVANCED', N'Disruptive technology changes industries.', N'Công nghệ mang tính phá vỡ thay đổi ngành công nghiệp.'),
(N'prototype', N'/ˈproʊtətaɪp/', N'bản thử nghiệm / nguyên mẫu', N'noun', N'ADVANCED', N'Build a prototype before production.', N'Xây dựng nguyên mẫu trước khi sản xuất.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('sport','football','basketball','swimming','tennis','team','game','win','lose','score','practice','exercise','gym','race','match','weather','temperature','hot','cold','warm','cool','spring','summer','autumn','winter','storm','thunder','lightning','foggy','sunny','cloudy','ingredient','recipe','cuisine','roast','marinate','simmer','bake','grill','seasoning','portion','vegetarian','organic','nutritious','calorie','protein','deforestation','biodiversity','greenhouse gas','ozone','fossil fuel','carbon footprint','reforestation','erosion','conservation','emission','artificial intelligence','machine learning','automation','blockchain','cybersecurity','augmented reality','nanotechnology','innovation','disruptive','prototype');
