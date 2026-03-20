--liquibase formatted sql

--changeset vocab:042-seed-words-batch35
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Food items (specific)
(N'asparagus', N'/əˈspærəɡəs/', N'măng tây', N'noun', N'INTERMEDIATE', N'Asparagus is a healthy vegetable.', N'Măng tây là rau tốt cho sức khỏe.'),
(N'avocado', N'/ˌævəˈkɑːdoʊ/', N'quả bơ', N'noun', N'BEGINNER', N'Avocado is rich in healthy fats.', N'Quả bơ giàu chất béo lành mạnh.'),
(N'broccoli', N'/ˈbrɒkəli/', N'bông cải xanh', N'noun', N'BEGINNER', N'Broccoli is full of vitamins.', N'Bông cải xanh giàu vitamin.'),
(N'bruschetta', N'/bruːˈskɛtə/', N'bánh mì nướng với cà chua', N'noun', N'INTERMEDIATE', N'We ordered bruschetta as a starter.', N'Chúng tôi gọi bruschetta làm món khai vị.'),
(N'cabbage', N'/ˈkæbɪdʒ/', N'bắp cải', N'noun', N'BEGINNER', N'Cabbage is used in many salads.', N'Bắp cải được dùng trong nhiều món salad.'),
(N'cauliflower', N'/ˈkɒliˌflaʊər/', N'súp lơ trắng', N'noun', N'BEGINNER', N'Cauliflower is a nutritious vegetable.', N'Súp lơ là loại rau bổ dưỡng.'),
(N'celery', N'/ˈseləri/', N'cần tây', N'noun', N'BEGINNER', N'Add celery to the salad.', N'Thêm cần tây vào salad.'),
(N'cinnamon', N'/ˈsɪnəmən/', N'quế', N'noun', N'INTERMEDIATE', N'Add cinnamon to the hot chocolate.', N'Thêm quế vào sôcôla nóng.'),
(N'clove', N'/kloʊv/', N'đinh hương', N'noun', N'INTERMEDIATE', N'Cloves are used as a spice.', N'Đinh hương được dùng làm gia vị.'),
(N'coconut', N'/ˈkoʊkənʌt/', N'dừa', N'noun', N'BEGINNER', N'Coconut water is refreshing.', N'Nước dừa rất sảng khoái.'),
(N'croissant', N'/ˈkrwæsɒŋ/', N'bánh sừng bò', N'noun', N'INTERMEDIATE', N'Have a croissant with your coffee.', N'Ăn bánh sừng bò với cà phê.'),
(N'cucumber', N'/ˈkjuːkʌmbər/', N'dưa chuột', N'noun', N'BEGINNER', N'Cucumber is refreshing in summer.', N'Dưa chuột rất mát mẻ vào mùa hè.'),
(N'cumin', N'/ˈkjuːmɪn/', N'hạt thì là', N'noun', N'INTERMEDIATE', N'Add cumin to the curry.', N'Thêm thì là vào cà ri.'),
(N'eggplant', N'/ˈeɡplɑːnt/', N'cà tím', N'noun', N'BEGINNER', N'Eggplant is delicious when grilled.', N'Cà tím ngon khi nướng.'),
(N'ginger', N'/ˈdʒɪndʒər/', N'gừng', N'noun', N'BEGINNER', N'Ginger tea soothes the throat.', N'Trà gừng xoa dịu cổ họng.'),
(N'lemon', N'/ˈlemən/', N'chanh vàng', N'noun', N'BEGINNER', N'Squeeze lemon into your water.', N'Vắt chanh vào nước.'),
(N'lettuce', N'/ˈletɪs/', N'rau diếp', N'noun', N'BEGINNER', N'Add lettuce to your burger.', N'Thêm rau diếp vào bánh burger.'),
(N'lime', N'/laɪm/', N'chanh xanh', N'noun', N'BEGINNER', N'Lime juice makes drinks refreshing.', N'Nước cốt chanh làm đồ uống sảng khoái.'),
(N'mango', N'/ˈmæŋɡoʊ/', N'xoài', N'noun', N'BEGINNER', N'Mangoes are sweet and juicy.', N'Xoài ngọt và nhiều nước.'),
(N'mushroom', N'/ˈmʌʃruːm/', N'nấm', N'noun', N'BEGINNER', N'Add mushrooms to the pasta.', N'Thêm nấm vào mì pasta.'),
(N'noodle', N'/ˈnuːdəl/', N'mì sợi', N'noun', N'BEGINNER', N'Noodles are popular in Asia.', N'Mì sợi phổ biến ở châu Á.'),
(N'oat', N'/oʊt/', N'yến mạch', N'noun', N'BEGINNER', N'Eat oats for a healthy breakfast.', N'Ăn yến mạch cho bữa sáng lành mạnh.'),
(N'olive', N'/ˈɒlɪv/', N'ô liu', N'noun', N'BEGINNER', N'Olives are used in Mediterranean food.', N'Ô liu được dùng trong ẩm thực Địa Trung Hải.'),
(N'onion', N'/ˈʌnjən/', N'hành tây', N'noun', N'BEGINNER', N'Chop the onion for the soup.', N'Thái hành tây cho canh.'),
(N'papaya', N'/pəˈpaɪə/', N'đu đủ', N'noun', N'BEGINNER', N'Papaya is good for digestion.', N'Đu đủ tốt cho tiêu hóa.'),
(N'parsley', N'/ˈpɑːrsli/', N'rau mùi tây', N'noun', N'INTERMEDIATE', N'Garnish the dish with parsley.', N'Trang trí món ăn với rau mùi tây.'),
(N'peach', N'/piːtʃ/', N'đào', N'noun', N'BEGINNER', N'Peaches are sweet in summer.', N'Đào ngọt vào mùa hè.'),
(N'pear', N'/peər/', N'lê', N'noun', N'BEGINNER', N'I bought fresh pears at the market.', N'Tôi mua lê tươi ở chợ.'),
(N'pineapple', N'/ˈpaɪnæpəl/', N'dứa / thơm', N'noun', N'BEGINNER', N'Pineapple juice is refreshing.', N'Nước dứa rất sảng khoái.'),
(N'plum', N'/plʌm/', N'mận', N'noun', N'BEGINNER', N'She picked plums from the tree.', N'Cô ấy hái mận trên cây.'),
(N'pomegranate', N'/ˈpɒmɪɡrænɪt/', N'lựu', N'noun', N'INTERMEDIATE', N'Pomegranate is rich in antioxidants.', N'Lựu giàu chất chống oxy hóa.'),
(N'pumpkin', N'/ˈpʌmpkɪn/', N'bí ngô', N'noun', N'BEGINNER', N'Make pumpkin soup in autumn.', N'Nấu canh bí ngô vào mùa thu.'),
(N'raspberry', N'/ˈrɑːzbəri/', N'mâm xôi', N'noun', N'INTERMEDIATE', N'Raspberries are tangy and sweet.', N'Mâm xôi chua ngọt.'),
(N'rosemary', N'/ˈroʊzməri/', N'hương thảo', N'noun', N'INTERMEDIATE', N'Add rosemary to roasted potatoes.', N'Thêm hương thảo vào khoai tây nướng.'),
(N'sage', N'/seɪdʒ/', N'cây xô thơm', N'noun', N'INTERMEDIATE', N'Sage is used in Mediterranean cooking.', N'Cây xô thơm dùng trong nấu ăn Địa Trung Hải.'),
(N'shrimp', N'/ʃrɪmp/', N'tôm (nhỏ)', N'noun', N'BEGINNER', N'Stir-fry shrimp with garlic.', N'Xào tôm với tỏi.'),
(N'spinach', N'/ˈspɪnɪdʒ/', N'rau bina', N'noun', N'BEGINNER', N'Spinach is rich in iron.', N'Rau bina giàu sắt.'),
(N'squash', N'/skwɒʃ/', N'bí / bí đao', N'noun', N'BEGINNER', N'Squash soup is comforting.', N'Canh bí rất ấm bụng.'),
(N'strawberry', N'/ˈstrɔːbəri/', N'dâu tây', N'noun', N'BEGINNER', N'Strawberries are my favorite fruit.', N'Dâu tây là trái cây yêu thích của tôi.'),
(N'thyme', N'/taɪm/', N'xạ hương', N'noun', N'INTERMEDIATE', N'Thyme adds flavor to the dish.', N'Xạ hương thêm hương vị cho món ăn.'),
(N'tofu', N'/ˈtoʊfuː/', N'đậu phụ', N'noun', N'BEGINNER', N'Tofu is a great protein source.', N'Đậu phụ là nguồn protein tuyệt vời.'),
(N'tuna', N'/ˈtjuːnə/', N'cá ngừ', N'noun', N'BEGINNER', N'Tuna is rich in omega-3.', N'Cá ngừ giàu omega-3.'),
(N'turnip', N'/ˈtɜːrnɪp/', N'củ cải trắng', N'noun', N'INTERMEDIATE', N'Turnips are root vegetables.', N'Củ cải trắng là rau củ.'),
(N'walnut', N'/ˈwɔːlnʌt/', N'quả óc chó', N'noun', N'INTERMEDIATE', N'Walnuts are good for the brain.', N'Quả óc chó tốt cho não.'),
(N'watermelon', N'/ˈwɔːtərmelən/', N'dưa hấu', N'noun', N'BEGINNER', N'Watermelon is perfect in summer.', N'Dưa hấu rất hợp vào mùa hè.'),
(N'wheat', N'/wiːt/', N'lúa mì', N'noun', N'BEGINNER', N'Bread is made from wheat flour.', N'Bánh mì làm từ bột mì.'),
(N'yogurt', N'/ˈjoʊɡərt/', N'sữa chua', N'noun', N'BEGINNER', N'Yogurt is good for gut health.', N'Sữa chua tốt cho sức khỏe đường ruột.'),
(N'zucchini', N'/zuːˈkiːni/', N'bí xanh', N'noun', N'INTERMEDIATE', N'Zucchini is delicious grilled.', N'Bí xanh ngon khi nướng.'),
-- Drinks
(N'espresso', N'/eˈspresəʊ/', N'cà phê espresso', N'noun', N'INTERMEDIATE', N'She drinks espresso every morning.', N'Cô ấy uống espresso mỗi sáng.'),
(N'herbal tea', N'/ˈhɜːrbəl tiː/', N'trà thảo mộc', N'noun', N'BEGINNER', N'Herbal tea helps you relax.', N'Trà thảo mộc giúp bạn thư giãn.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('asparagus','avocado','broccoli','bruschetta','cabbage','cauliflower','celery','cinnamon','clove','coconut','croissant','cucumber','cumin','eggplant','ginger','lemon','lettuce','lime','mango','mushroom','noodle','oat','olive','onion','papaya','parsley','peach','pear','pineapple','plum','pomegranate','pumpkin','raspberry','rosemary','sage','shrimp','spinach','squash','strawberry','thyme','tofu','tuna','turnip','walnut','watermelon','wheat','yogurt','zucchini','espresso','herbal tea');
