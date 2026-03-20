--liquibase formatted sql

--changeset vocab:040-seed-words-batch33
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Animals (extended)
(N'amphibian', N'/æmˈfɪbiən/', N'động vật lưỡng cư', N'noun', N'INTERMEDIATE', N'Frogs are amphibians.', N'Ếch là động vật lưỡng cư.'),
(N'antelope', N'/ˈæntɪloʊp/', N'linh dương', N'noun', N'INTERMEDIATE', N'Antelopes run very fast.', N'Linh dương chạy rất nhanh.'),
(N'bison', N'/ˈbaɪsən/', N'trâu rừng bison', N'noun', N'INTERMEDIATE', N'Bisons once roamed North America.', N'Trâu rừng bison từng lang thang ở Bắc Mỹ.'),
(N'cheetah', N'/ˈtʃiːtə/', N'báo cheetah', N'noun', N'BEGINNER', N'The cheetah is the fastest animal.', N'Báo cheetah là loài vật nhanh nhất.'),
(N'chimpanzee', N'/ˌtʃɪmpænˈziː/', N'tinh tinh', N'noun', N'INTERMEDIATE', N'Chimpanzees are very intelligent.', N'Tinh tinh rất thông minh.'),
(N'crab', N'/kræb/', N'cua', N'noun', N'BEGINNER', N'We caught crabs at the beach.', N'Chúng tôi bắt cua ở bãi biển.'),
(N'crane', N'/kreɪn/', N'con sếu', N'noun', N'INTERMEDIATE', N'Cranes are elegant birds.', N'Sếu là loài chim duyên dáng.'),
(N'crocodile', N'/ˈkrɒkədaɪl/', N'cá sấu', N'noun', N'BEGINNER', N'Crocodiles live in rivers.', N'Cá sấu sống ở sông.'),
(N'deer', N'/dɪər/', N'hươu', N'noun', N'BEGINNER', N'A deer ran across the road.', N'Một con hươu chạy qua đường.'),
(N'dolphin', N'/ˈdɒlfɪn/', N'cá heo', N'noun', N'BEGINNER', N'Dolphins are highly intelligent.', N'Cá heo rất thông minh.'),
(N'donkey', N'/ˈdɒŋki/', N'con lừa', N'noun', N'BEGINNER', N'The donkey carried heavy loads.', N'Con lừa mang nặng.'),
(N'dragonfly', N'/ˈdræɡənflaɪ/', N'chuồn chuồn', N'noun', N'BEGINNER', N'Dragonflies hover over the pond.', N'Chuồn chuồn lượn trên ao.'),
(N'duck', N'/dʌk/', N'vịt', N'noun', N'BEGINNER', N'Ducks swim in the pond.', N'Vịt bơi trên ao.'),
(N'eagle', N'/ˈiːɡəl/', N'đại bàng', N'noun', N'BEGINNER', N'The eagle soared high in the sky.', N'Đại bàng bay cao trên bầu trời.'),
(N'flamingo', N'/fləˈmɪŋɡoʊ/', N'chim hồng hạc', N'noun', N'BEGINNER', N'Flamingos are pink birds.', N'Hồng hạc là loài chim màu hồng.'),
(N'fox', N'/fɒks/', N'con cáo', N'noun', N'BEGINNER', N'The fox is cunning.', N'Con cáo rất ranh mãnh.'),
(N'giraffe', N'/dʒɪˈrɑːf/', N'hươu cao cổ', N'noun', N'BEGINNER', N'The giraffe has a very long neck.', N'Hươu cao cổ có cổ rất dài.'),
(N'gorilla', N'/ɡəˈrɪlə/', N'khỉ đột', N'noun', N'BEGINNER', N'Gorillas live in African forests.', N'Khỉ đột sống ở rừng châu Phi.'),
(N'hippopotamus', N'/ˌhɪpəˈpɒtəməs/', N'hà mã', N'noun', N'INTERMEDIATE', N'Hippos spend time in water.', N'Hà mã dành thời gian dưới nước.'),
(N'jellyfish', N'/ˈdʒeliˌfɪʃ/', N'sứa', N'noun', N'BEGINNER', N'Jellyfish can sting.', N'Sứa có thể châm.'),
(N'kangaroo', N'/ˌkæŋɡəˈruː/', N'chuột túi', N'noun', N'BEGINNER', N'Kangaroos are native to Australia.', N'Chuột túi là loài bản địa của Úc.'),
(N'leopard', N'/ˈlepərd/', N'báo đốm', N'noun', N'INTERMEDIATE', N'The leopard hid in the tree.', N'Báo đốm ẩn trên cây.'),
(N'lobster', N'/ˈlɒbstər/', N'tôm hùm', N'noun', N'BEGINNER', N'Lobster is a luxury seafood.', N'Tôm hùm là hải sản cao cấp.'),
(N'lynx', N'/lɪŋks/', N'mèo rừng lynx', N'noun', N'ADVANCED', N'The lynx is a wild cat.', N'Mèo rừng lynx là loài mèo hoang.'),
(N'moose', N'/muːs/', N'nai sừng tấm', N'noun', N'INTERMEDIATE', N'A moose was spotted near the lake.', N'Một con nai sừng tấm được phát hiện gần hồ.'),
(N'mosquito', N'/məˈskiːtoʊ/', N'muỗi', N'noun', N'BEGINNER', N'Mosquitoes spread malaria.', N'Muỗi lây truyền sốt rét.'),
(N'octopus', N'/ˈɒktəpəs/', N'bạch tuộc', N'noun', N'BEGINNER', N'Octopuses have eight arms.', N'Bạch tuộc có tám xúc tu.'),
(N'ostrich', N'/ˈɒstrɪtʃ/', N'đà điểu', N'noun', N'BEGINNER', N'The ostrich cannot fly.', N'Đà điểu không thể bay.'),
(N'otter', N'/ˈɒtər/', N'rái cá', N'noun', N'INTERMEDIATE', N'Otters are playful animals.', N'Rái cá là loài vật tinh nghịch.'),
(N'owl', N'/aʊl/', N'con cú', N'noun', N'BEGINNER', N'Owls hunt at night.', N'Cú săn mồi vào ban đêm.'),
(N'panda', N'/ˈpændə/', N'gấu trúc', N'noun', N'BEGINNER', N'The panda eats bamboo all day.', N'Gấu trúc ăn tre suốt ngày.'),
(N'parrot', N'/ˈpærət/', N'con vẹt', N'noun', N'BEGINNER', N'The parrot can imitate voices.', N'Con vẹt có thể bắt chước giọng nói.'),
(N'penguin', N'/ˈpeŋɡwɪn/', N'chim cánh cụt', N'noun', N'BEGINNER', N'Penguins live in Antarctica.', N'Chim cánh cụt sống ở Nam Cực.'),
(N'python', N'/ˈpaɪθən/', N'trăn', N'noun', N'INTERMEDIATE', N'A python can swallow prey whole.', N'Trăn có thể nuốt chửng con mồi.'),
(N'rhinoceros', N'/raɪˈnɒsərəs/', N'tê giác', N'noun', N'INTERMEDIATE', N'Rhinoceroses are endangered.', N'Tê giác đang bị đe dọa.'),
(N'salmon', N'/ˈsæmən/', N'cá hồi', N'noun', N'BEGINNER', N'Salmon swim upstream to spawn.', N'Cá hồi bơi ngược dòng để đẻ trứng.'),
(N'scorpion', N'/ˈskɔːrpiən/', N'bọ cạp', N'noun', N'INTERMEDIATE', N'Scorpions sting with their tails.', N'Bọ cạp đốt bằng đuôi.'),
(N'seal', N'/siːl/', N'hải cẩu', N'noun', N'BEGINNER', N'Seals live near the ocean.', N'Hải cẩu sống gần đại dương.'),
(N'shark', N'/ʃɑːrk/', N'cá mập', N'noun', N'BEGINNER', N'Sharks are apex predators.', N'Cá mập là kẻ săn mồi đỉnh cao.'),
(N'sparrow', N'/ˈspæroʊ/', N'chim sẻ', N'noun', N'BEGINNER', N'Sparrows sing in the morning.', N'Chim sẻ hót vào buổi sáng.'),
(N'squirrel', N'/ˈskwɪrəl/', N'sóc', N'noun', N'BEGINNER', N'Squirrels collect nuts for winter.', N'Sóc thu thập hạt cho mùa đông.'),
(N'stingray', N'/ˈstɪŋreɪ/', N'cá đuối điện', N'noun', N'INTERMEDIATE', N'Stingrays hide in the sand.', N'Cá đuối điện ẩn trong cát.'),
(N'tortoise', N'/ˈtɔːrtəs/', N'rùa đất', N'noun', N'BEGINNER', N'Tortoises live very long lives.', N'Rùa đất sống rất lâu.'),
(N'vulture', N'/ˈvʌltʃər/', N'kền kền', N'noun', N'INTERMEDIATE', N'Vultures feed on dead animals.', N'Kền kền ăn xác động vật chết.'),
(N'walrus', N'/ˈwɔːlrəs/', N'hải mã', N'noun', N'INTERMEDIATE', N'Walruses have long tusks.', N'Hải mã có ngà dài.'),
(N'wasp', N'/wɒsp/', N'con ong bắp cày', N'noun', N'BEGINNER', N'A wasp stung him on the arm.', N'Ong bắp cày đốt anh ấy vào tay.'),
(N'whale', N'/weɪl/', N'cá voi', N'noun', N'BEGINNER', N'Blue whales are the largest animals.', N'Cá voi xanh là loài lớn nhất.'),
(N'wolf', N'/wʊlf/', N'sói', N'noun', N'BEGINNER', N'Wolves hunt in packs.', N'Sói săn mồi theo bầy.'),
(N'worm', N'/wɜːrm/', N'con giun', N'noun', N'BEGINNER', N'Birds eat worms in the morning.', N'Chim ăn giun vào buổi sáng.'),
(N'zebra', N'/ˈziːbrə/', N'ngựa vằn', N'noun', N'BEGINNER', N'Zebras have black and white stripes.', N'Ngựa vằn có sọc đen trắng.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('amphibian','antelope','bison','cheetah','chimpanzee','crab','crane','crocodile','deer','dolphin','donkey','dragonfly','duck','eagle','flamingo','fox','giraffe','gorilla','hippopotamus','jellyfish','kangaroo','leopard','lobster','lynx','moose','mosquito','octopus','ostrich','otter','owl','panda','parrot','penguin','python','rhinoceros','salmon','scorpion','seal','shark','sparrow','squirrel','stingray','tortoise','vulture','walrus','wasp','whale','wolf','worm','zebra');
