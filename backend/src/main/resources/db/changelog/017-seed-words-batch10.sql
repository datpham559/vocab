--liquibase formatted sql

--changeset vocab:017-seed-words-batch10
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- BEGINNER: Common Adjectives
(N'new', N'/njuː/', N'mới', N'adjective', N'BEGINNER', N'I bought a new phone.', N'Tôi mua điện thoại mới.'),
(N'old', N'/oʊld/', N'cũ / già', N'adjective', N'BEGINNER', N'This is an old building.', N'Đây là tòa nhà cũ.'),
(N'good', N'/ɡʊd/', N'tốt', N'adjective', N'BEGINNER', N'She is a good student.', N'Cô ấy là học sinh giỏi.'),
(N'bad', N'/bæd/', N'xấu / tệ', N'adjective', N'BEGINNER', N'The weather is bad today.', N'Thời tiết hôm nay xấu.'),
(N'great', N'/ɡreɪt/', N'tuyệt vời', N'adjective', N'BEGINNER', N'You did a great job!', N'Bạn đã làm rất tốt!'),
(N'beautiful', N'/ˈbjuːtɪfəl/', N'đẹp', N'adjective', N'BEGINNER', N'She looks beautiful today.', N'Hôm nay cô ấy trông đẹp.'),
(N'ugly', N'/ˈʌɡli/', N'xấu xí', N'adjective', N'BEGINNER', N'Don''t judge by appearance.', N'Đừng đánh giá qua vẻ bề ngoài.'),
(N'strong', N'/strɒŋ/', N'mạnh mẽ', N'adjective', N'BEGINNER', N'He is very strong.', N'Anh ấy rất mạnh.'),
(N'weak', N'/wiːk/', N'yếu', N'adjective', N'BEGINNER', N'She felt weak after the illness.', N'Cô ấy cảm thấy yếu sau khi bệnh.'),
(N'young', N'/jʌŋ/', N'trẻ', N'adjective', N'BEGINNER', N'She is young and energetic.', N'Cô ấy trẻ và năng động.'),
(N'rich', N'/rɪtʃ/', N'giàu có', N'adjective', N'BEGINNER', N'He became rich from his business.', N'Anh ấy giàu lên nhờ kinh doanh.'),
(N'poor', N'/pʊr/', N'nghèo', N'adjective', N'BEGINNER', N'Help the poor in your community.', N'Giúp đỡ người nghèo trong cộng đồng.'),
(N'safe', N'/seɪf/', N'an toàn', N'adjective', N'BEGINNER', N'Stay safe on the road.', N'Hãy an toàn trên đường.'),
(N'dangerous', N'/ˈdeɪndʒərəs/', N'nguy hiểm', N'adjective', N'BEGINNER', N'This road is dangerous at night.', N'Con đường này nguy hiểm vào ban đêm.'),
(N'easy', N'/ˈiːzi/', N'dễ dàng', N'adjective', N'BEGINNER', N'The test was easy.', N'Bài kiểm tra dễ.'),
(N'difficult', N'/ˈdɪfɪkəlt/', N'khó', N'adjective', N'BEGINNER', N'This lesson is difficult.', N'Bài học này khó.'),
(N'important', N'/ɪmˈpɔːrtənt/', N'quan trọng', N'adjective', N'BEGINNER', N'Health is the most important thing.', N'Sức khỏe là điều quan trọng nhất.'),
(N'interesting', N'/ˈɪntrɪstɪŋ/', N'thú vị', N'adjective', N'BEGINNER', N'This book is interesting.', N'Cuốn sách này thú vị.'),
(N'boring', N'/ˈbɔːrɪŋ/', N'chán', N'adjective', N'BEGINNER', N'The class was boring.', N'Lớp học thật chán.'),
(N'funny', N'/ˈfʌni/', N'hài hước', N'adjective', N'BEGINNER', N'He is very funny.', N'Anh ấy rất hài hước.'),
-- INTERMEDIATE: Abstract Nouns
(N'success', N'/səkˈses/', N'sự thành công', N'noun', N'INTERMEDIATE', N'Success comes with hard work.', N'Thành công đến cùng với sự chăm chỉ.'),
(N'failure', N'/ˈfeɪljər/', N'thất bại', N'noun', N'INTERMEDIATE', N'Learn from failure and move on.', N'Học từ thất bại và tiến lên.'),
(N'progress', N'/ˈprɒɡres/', N'tiến bộ', N'noun', N'INTERMEDIATE', N'Track your progress regularly.', N'Theo dõi tiến độ thường xuyên.'),
(N'solution', N'/səˈluːʃən/', N'giải pháp', N'noun', N'INTERMEDIATE', N'Find a solution to every problem.', N'Tìm giải pháp cho mọi vấn đề.'),
(N'problem', N'/ˈprɒbləm/', N'vấn đề', N'noun', N'INTERMEDIATE', N'Every problem has a solution.', N'Mọi vấn đề đều có giải pháp.'),
(N'decision', N'/dɪˈsɪʒən/', N'quyết định', N'noun', N'INTERMEDIATE', N'Make wise decisions in life.', N'Hãy đưa ra những quyết định khôn ngoan.'),
(N'effort', N'/ˈefərt/', N'nỗ lực', N'noun', N'INTERMEDIATE', N'Put in your best effort.', N'Hãy nỗ lực hết sức.'),
(N'attitude', N'/ˈætɪtjuːd/', N'thái độ', N'noun', N'INTERMEDIATE', N'A positive attitude helps.', N'Thái độ tích cực giúp ích.'),
(N'behavior', N'/bɪˈheɪvjər/', N'hành vi', N'noun', N'INTERMEDIATE', N'Good behavior is rewarded.', N'Hành vi tốt sẽ được khen thưởng.'),
(N'habit', N'/ˈhæbɪt/', N'thói quen', N'noun', N'INTERMEDIATE', N'Good habits lead to success.', N'Thói quen tốt dẫn đến thành công.'),
(N'principle', N'/ˈprɪnsɪpəl/', N'nguyên tắc', N'noun', N'INTERMEDIATE', N'Stand by your principles.', N'Hãy giữ vững nguyên tắc.'),
(N'value', N'/ˈvæljuː/', N'giá trị', N'noun', N'INTERMEDIATE', N'Family values are important.', N'Giá trị gia đình rất quan trọng.'),
(N'goal', N'/ɡoʊl/', N'mục tiêu', N'noun', N'INTERMEDIATE', N'Set clear goals for yourself.', N'Đặt mục tiêu rõ ràng cho bản thân.'),
(N'dream', N'/driːm/', N'giấc mơ', N'noun', N'INTERMEDIATE', N'Chase your dreams fearlessly.', N'Hãy theo đuổi giấc mơ không sợ hãi.'),
(N'hope', N'/hoʊp/', N'hy vọng', N'noun', N'INTERMEDIATE', N'Never lose hope.', N'Đừng bao giờ mất hy vọng.'),
(N'trust', N'/trʌst/', N'tin tưởng', N'noun', N'INTERMEDIATE', N'Trust is the foundation of relationships.', N'Tin tưởng là nền tảng của các mối quan hệ.'),
(N'respect', N'/rɪˈspekt/', N'sự tôn trọng', N'noun', N'INTERMEDIATE', N'Show respect to everyone.', N'Hãy tôn trọng mọi người.'),
(N'responsibility', N'/rɪˌspɒnsɪˈbɪlɪti/', N'trách nhiệm', N'noun', N'INTERMEDIATE', N'Take responsibility for your actions.', N'Hãy chịu trách nhiệm về hành động của bạn.'),
(N'patience', N'/ˈpeɪʃəns/', N'sự kiên nhẫn', N'noun', N'INTERMEDIATE', N'Patience is a virtue.', N'Kiên nhẫn là đức hạnh.'),
(N'courage', N'/ˈkɜːrɪdʒ/', N'lòng dũng cảm', N'noun', N'INTERMEDIATE', N'Have courage to face your fears.', N'Hãy dũng cảm đối mặt với nỗi sợ.'),
-- ADVANCED: Political & Social
(N'geopolitics', N'/ˌdʒiːoʊˈpɒlɪtɪks/', N'địa chính trị', N'noun', N'ADVANCED', N'Geopolitics shapes global affairs.', N'Địa chính trị định hình các vấn đề toàn cầu.'),
(N'oligarchy', N'/ˈɒlɪɡɑːrki/', N'chính quyền đầu sỏ', N'noun', N'ADVANCED', N'The oligarchy controls the economy.', N'Chính quyền đầu sỏ kiểm soát nền kinh tế.'),
(N'totalitarian', N'/toʊˌtæliˈteriən/', N'độc tài toàn trị', N'adjective', N'ADVANCED', N'A totalitarian regime controls everything.', N'Chế độ toàn trị kiểm soát mọi thứ.'),
(N'propaganda', N'/ˌprɒpəˈɡændə/', N'tuyên truyền', N'noun', N'ADVANCED', N'Propaganda manipulates public opinion.', N'Tuyên truyền thao túng dư luận.'),
(N'censorship', N'/ˈsensərʃɪp/', N'kiểm duyệt', N'noun', N'ADVANCED', N'Censorship limits free expression.', N'Kiểm duyệt hạn chế tự do biểu đạt.'),
(N'imperialism', N'/ɪmˈpɪəriəlɪzəm/', N'chủ nghĩa đế quốc', N'noun', N'ADVANCED', N'Imperialism exploits other nations.', N'Chủ nghĩa đế quốc bóc lột các quốc gia khác.'),
(N'nationalism', N'/ˈnæʃənəlɪzəm/', N'chủ nghĩa dân tộc', N'noun', N'ADVANCED', N'Nationalism unites people around identity.', N'Chủ nghĩa dân tộc đoàn kết người dân quanh bản sắc.'),
(N'capitalism', N'/ˈkæpɪtəlɪzəm/', N'chủ nghĩa tư bản', N'noun', N'ADVANCED', N'Capitalism drives economic competition.', N'Chủ nghĩa tư bản thúc đẩy cạnh tranh kinh tế.'),
(N'bureaucracy', N'/bjʊˈrɒkrəsi/', N'bộ máy quan liêu', N'noun', N'ADVANCED', N'The bureaucracy slows decisions.', N'Bộ máy quan liêu làm chậm các quyết định.'),
(N'coalition', N'/ˌkoʊəˈlɪʃən/', N'liên minh', N'noun', N'ADVANCED', N'A coalition government was formed.', N'Một chính phủ liên minh đã được thành lập.'),
-- ADVANCED: Finance & Economics
(N'hedge fund', N'/hedʒ fʌnd/', N'quỹ đầu cơ', N'noun', N'ADVANCED', N'Hedge funds seek high returns.', N'Quỹ đầu cơ tìm kiếm lợi nhuận cao.'),
(N'derivatives', N'/dɪˈrɪvətɪvz/', N'công cụ phái sinh', N'noun', N'ADVANCED', N'Derivatives can reduce financial risk.', N'Công cụ phái sinh có thể giảm rủi ro tài chính.'),
(N'portfolio', N'/pɔːrtˈfoʊlioʊ/', N'danh mục đầu tư', N'noun', N'ADVANCED', N'Diversify your investment portfolio.', N'Đa dạng hóa danh mục đầu tư của bạn.'),
(N'liquidity', N'/lɪˈkwɪdɪti/', N'tính thanh khoản', N'noun', N'ADVANCED', N'Maintain sufficient liquidity.', N'Duy trì thanh khoản đủ.'),
(N'volatility', N'/ˌvɒləˈtɪlɪti/', N'biến động', N'noun', N'ADVANCED', N'Market volatility creates opportunity.', N'Biến động thị trường tạo ra cơ hội.'),
(N'collateral', N'/kəˈlætərəl/', N'tài sản thế chấp', N'noun', N'ADVANCED', N'Use collateral to secure the loan.', N'Dùng tài sản thế chấp để đảm bảo khoản vay.'),
(N'speculation', N'/ˌspekjʊˈleɪʃən/', N'đầu cơ', N'noun', N'ADVANCED', N'Speculation can cause market bubbles.', N'Đầu cơ có thể tạo bong bóng thị trường.'),
(N'dividend', N'/ˈdɪvɪdend/', N'cổ tức', N'noun', N'ADVANCED', N'The company paid a dividend.', N'Công ty đã trả cổ tức.'),
(N'equity', N'/ˈekwɪti/', N'vốn chủ sở hữu', N'noun', N'ADVANCED', N'Build equity in your home.', N'Xây dựng vốn chủ sở hữu trong ngôi nhà của bạn.'),
(N'amortize', N'/ˈæmərtaɪz/', N'khấu trừ dần / trả dần', N'verb', N'ADVANCED', N'Amortize the loan over 20 years.', N'Trả dần khoản vay trong 20 năm.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('new','old','good','bad','great','beautiful','ugly','strong','weak','young','rich','poor','safe','dangerous','easy','difficult','important','interesting','boring','funny','success','failure','progress','solution','problem','decision','effort','attitude','behavior','habit','principle','value','goal','dream','hope','trust','respect','responsibility','patience','courage','geopolitics','oligarchy','totalitarian','propaganda','censorship','imperialism','nationalism','capitalism','bureaucracy','coalition','hedge fund','derivatives','portfolio','liquidity','volatility','collateral','speculation','dividend','equity','amortize');
