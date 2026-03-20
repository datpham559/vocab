--liquibase formatted sql

--changeset vocab:039-seed-words-batch32
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Common nouns (everyday life)
(N'alarm', N'/əˈlɑːrm/', N'báo động / chuông báo thức', N'noun', N'BEGINNER', N'Set the alarm for 7 AM.', N'Đặt chuông báo thức lúc 7 giờ sáng.'),
(N'apartment', N'/əˈpɑːrtmənt/', N'căn hộ', N'noun', N'BEGINNER', N'She rents a small apartment.', N'Cô ấy thuê một căn hộ nhỏ.'),
(N'appliance', N'/əˈplaɪəns/', N'thiết bị điện', N'noun', N'INTERMEDIATE', N'All appliances are energy efficient.', N'Tất cả thiết bị điện đều tiết kiệm năng lượng.'),
(N'attic', N'/ˈætɪk/', N'gác mái / tầng áp mái', N'noun', N'BEGINNER', N'Store old items in the attic.', N'Lưu trữ đồ cũ trong gác mái.'),
(N'backyard', N'/ˈbækjɑːrd/', N'sân sau', N'noun', N'BEGINNER', N'The kids play in the backyard.', N'Trẻ em chơi ở sân sau.'),
(N'basement', N'/ˈbeɪsmənt/', N'tầng hầm', N'noun', N'BEGINNER', N'Store tools in the basement.', N'Lưu trữ công cụ trong tầng hầm.'),
(N'bin', N'/bɪn/', N'thùng rác', N'noun', N'BEGINNER', N'Throw it in the recycling bin.', N'Bỏ vào thùng tái chế.'),
(N'blanket', N'/ˈblæŋkɪt/', N'chăn', N'noun', N'BEGINNER', N'Wrap yourself in a warm blanket.', N'Quấn mình trong chăn ấm.'),
(N'blind', N'/blaɪnd/', N'mù / rèm cửa', N'noun', N'BEGINNER', N'Close the blinds to block sunlight.', N'Đóng rèm để chắn ánh sáng mặt trời.'),
(N'bowl', N'/boʊl/', N'bát / tô', N'noun', N'BEGINNER', N'Eat soup from a bowl.', N'Ăn canh từ bát.'),
(N'cabinet', N'/ˈkæbɪnɪt/', N'tủ / nội các', N'noun', N'BEGINNER', N'Store dishes in the cabinet.', N'Để bát đĩa trong tủ.'),
(N'candle', N'/ˈkændəl/', N'cây nến', N'noun', N'BEGINNER', N'Light a candle for ambiance.', N'Thắp nến để tạo không khí.'),
(N'carpet', N'/ˈkɑːrpɪt/', N'thảm', N'noun', N'BEGINNER', N'Vacuum the carpet weekly.', N'Hút bụi thảm hàng tuần.'),
(N'ceiling', N'/ˈsiːlɪŋ/', N'trần nhà', N'noun', N'BEGINNER', N'The ceiling is painted white.', N'Trần nhà được sơn màu trắng.'),
(N'closet', N'/ˈklɒzɪt/', N'tủ quần áo / phòng nhỏ', N'noun', N'BEGINNER', N'Organize your closet.', N'Sắp xếp tủ quần áo của bạn.'),
(N'couch', N'/kaʊtʃ/', N'ghế sofa', N'noun', N'BEGINNER', N'Sit on the couch and relax.', N'Ngồi trên ghế sofa và thư giãn.'),
(N'counter', N'/ˈkaʊntər/', N'quầy / mặt bàn bếp', N'noun', N'BEGINNER', N'Put the groceries on the counter.', N'Để đồ tạp hóa lên mặt bàn bếp.'),
(N'curtain', N'/ˈkɜːrtən/', N'rèm cửa', N'noun', N'BEGINNER', N'Open the curtains to let light in.', N'Mở rèm để ánh sáng vào.'),
(N'cushion', N'/ˈkʊʃən/', N'gối đệm', N'noun', N'BEGINNER', N'Add cushions for comfort.', N'Thêm gối đệm cho thoải mái.'),
(N'drawer', N'/drɔːr/', N'ngăn kéo', N'noun', N'BEGINNER', N'Keep documents in the drawer.', N'Giữ tài liệu trong ngăn kéo.'),
(N'driveway', N'/ˈdraɪvweɪ/', N'lối vào xe', N'noun', N'BEGINNER', N'Park the car in the driveway.', N'Đậu xe trong lối vào.'),
(N'fence', N'/fens/', N'hàng rào', N'noun', N'BEGINNER', N'Build a fence around the yard.', N'Xây hàng rào quanh sân.'),
(N'fireplace', N'/ˈfaɪərpleɪs/', N'lò sưởi', N'noun', N'BEGINNER', N'Sit by the fireplace in winter.', N'Ngồi bên lò sưởi vào mùa đông.'),
(N'floor', N'/flɔːr/', N'sàn nhà / tầng', N'noun', N'BEGINNER', N'Sweep the floor every day.', N'Quét sàn nhà mỗi ngày.'),
(N'faucet', N'/ˈfɔːsɪt/', N'vòi nước', N'noun', N'BEGINNER', N'Turn off the faucet to save water.', N'Tắt vòi nước để tiết kiệm nước.'),
(N'garage', N'/ɡəˈrɑːdʒ/', N'gara / nhà để xe', N'noun', N'BEGINNER', N'Park the car in the garage.', N'Đậu xe trong nhà để xe.'),
(N'hallway', N'/ˈhɔːlweɪ/', N'hành lang', N'noun', N'BEGINNER', N'Hang coats in the hallway.', N'Treo áo khoác trong hành lang.'),
(N'lamp', N'/læmp/', N'đèn bàn', N'noun', N'BEGINNER', N'Turn on the lamp when reading.', N'Bật đèn bàn khi đọc sách.'),
(N'laundry', N'/ˈlɔːndri/', N'giặt đồ / đồ giặt', N'noun', N'BEGINNER', N'Do the laundry on Sunday.', N'Giặt đồ vào chủ nhật.'),
(N'lawn', N'/lɔːn/', N'bãi cỏ', N'noun', N'BEGINNER', N'Mow the lawn every week.', N'Cắt cỏ mỗi tuần.'),
(N'mattress', N'/ˈmætrɪs/', N'đệm nằm', N'noun', N'BEGINNER', N'Replace the mattress every few years.', N'Thay đệm sau vài năm.'),
(N'microwave', N'/ˈmaɪkrəweɪv/', N'lò vi sóng', N'noun', N'BEGINNER', N'Heat the food in the microwave.', N'Hâm nóng thức ăn trong lò vi sóng.'),
(N'mirror', N'/ˈmɪrər/', N'gương', N'noun', N'BEGINNER', N'Look in the mirror before leaving.', N'Nhìn vào gương trước khi ra ngoài.'),
(N'mop', N'/mɒp/', N'cây lau nhà', N'noun', N'BEGINNER', N'Mop the floor after cleaning.', N'Lau sàn nhà sau khi dọn dẹp.'),
(N'nail', N'/neɪl/', N'đinh / móng tay', N'noun', N'BEGINNER', N'Hammer a nail into the wall.', N'Đóng đinh vào tường.'),
(N'outlet', N'/ˈaʊtlet/', N'ổ điện', N'noun', N'BEGINNER', N'Plug the charger into the outlet.', N'Cắm bộ sạc vào ổ điện.'),
(N'pantry', N'/ˈpæntri/', N'kho chứa thực phẩm', N'noun', N'INTERMEDIATE', N'Stock the pantry with essentials.', N'Trữ thực phẩm cần thiết trong kho.'),
(N'pillow', N'/ˈpɪloʊ/', N'gối', N'noun', N'BEGINNER', N'Use a comfortable pillow.', N'Dùng gối thoải mái.'),
(N'plumber', N'/ˈplʌmər/', N'thợ sửa ống nước', N'noun', N'BEGINNER', N'Call the plumber to fix the leak.', N'Gọi thợ sửa ống nước để sửa rò rỉ.'),
(N'porch', N'/pɔːrtʃ/', N'hiên nhà', N'noun', N'BEGINNER', N'Sit on the porch in the evening.', N'Ngồi trên hiên nhà vào buổi tối.'),
(N'railing', N'/ˈreɪlɪŋ/', N'lan can', N'noun', N'BEGINNER', N'Hold the railing on the stairs.', N'Bám lan can trên cầu thang.'),
(N'renovation', N'/ˌrenəˈveɪʃən/', N'cải tạo / sửa chữa', N'noun', N'INTERMEDIATE', N'The kitchen renovation took a month.', N'Cải tạo nhà bếp mất một tháng.'),
(N'rooftop', N'/ˈruːftɒp/', N'mái nhà', N'noun', N'BEGINNER', N'Enjoy the view from the rooftop.', N'Ngắm cảnh từ mái nhà.'),
(N'shelf', N'/ʃelf/', N'kệ', N'noun', N'BEGINNER', N'Put the books on the shelf.', N'Đặt sách lên kệ.'),
(N'shovel', N'/ˈʃʌvəl/', N'cái xẻng', N'noun', N'BEGINNER', N'Use a shovel to dig the garden.', N'Dùng xẻng để đào vườn.'),
(N'sink', N'/sɪŋk/', N'bồn rửa', N'noun', N'BEGINNER', N'Wash dishes in the sink.', N'Rửa bát đĩa trong bồn rửa.'),
(N'socket', N'/ˈsɒkɪt/', N'ổ cắm điện', N'noun', N'BEGINNER', N'The socket needs fixing.', N'Ổ cắm điện cần sửa.'),
(N'sofa', N'/ˈsoʊfə/', N'ghế sofa', N'noun', N'BEGINNER', N'The sofa is very comfortable.', N'Ghế sofa rất thoải mái.'),
(N'stairs', N'/steərz/', N'cầu thang', N'noun', N'BEGINNER', N'Take the stairs for exercise.', N'Đi cầu thang để tập thể dục.'),
(N'wardrobe', N'/ˈwɔːrdroʊb/', N'tủ quần áo lớn', N'noun', N'BEGINNER', N'Organize your wardrobe by season.', N'Sắp xếp tủ quần áo theo mùa.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('alarm','apartment','appliance','attic','backyard','basement','bin','blanket','blind','bowl','cabinet','candle','carpet','ceiling','closet','couch','counter','curtain','cushion','drawer','driveway','fence','fireplace','floor','faucet','garage','hallway','lamp','laundry','lawn','mattress','microwave','mirror','mop','nail','outlet','pantry','pillow','plumber','porch','railing','renovation','rooftop','shelf','shovel','sink','socket','sofa','stairs','wardrobe');
