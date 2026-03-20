--liquibase formatted sql

--changeset vocab:032-seed-words-batch25
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Emotions & Psychology
(N'anxiety', N'/æŋˈzaɪəti/', N'lo lắng / lo âu', N'noun', N'INTERMEDIATE', N'Reduce anxiety through exercise.', N'Giảm lo âu thông qua tập thể dục.'),
(N'compassion', N'/kəmˈpæʃən/', N'lòng trắc ẩn', N'noun', N'INTERMEDIATE', N'Show compassion to those in need.', N'Thể hiện lòng trắc ẩn với người cần.'),
(N'confidence', N'/ˈkɒnfɪdəns/', N'sự tự tin', N'noun', N'BEGINNER', N'Build your confidence over time.', N'Xây dựng sự tự tin theo thời gian.'),
(N'contempt', N'/kənˈtempt/', N'sự khinh bỉ', N'noun', N'ADVANCED', N'She treated them with contempt.', N'Cô ấy đối xử với họ bằng sự khinh bỉ.'),
(N'crave', N'/kreɪv/', N'thèm muốn', N'verb', N'INTERMEDIATE', N'I crave chocolate when I''m stressed.', N'Tôi thèm socola khi căng thẳng.'),
(N'curiosity', N'/ˌkjʊəriˈɒsɪti/', N'sự tò mò', N'noun', N'INTERMEDIATE', N'Curiosity drives learning.', N'Sự tò mò thúc đẩy việc học.'),
(N'depression', N'/dɪˈpreʃən/', N'trầm cảm', N'noun', N'INTERMEDIATE', N'Seek help if you experience depression.', N'Tìm sự giúp đỡ nếu bạn bị trầm cảm.'),
(N'despair', N'/dɪˈspeər/', N'tuyệt vọng', N'noun', N'INTERMEDIATE', N'Don''t give in to despair.', N'Đừng đầu hàng trước sự tuyệt vọng.'),
(N'determination', N'/dɪˌtɜːrmɪˈneɪʃən/', N'sự quyết tâm', N'noun', N'INTERMEDIATE', N'Her determination led to success.', N'Sự quyết tâm của cô ấy dẫn đến thành công.'),
(N'disgust', N'/dɪsˈɡʌst/', N'sự ghê tởm', N'noun', N'INTERMEDIATE', N'He felt disgust at the sight.', N'Anh ấy cảm thấy ghê tởm khi nhìn thấy.'),
(N'empathy', N'/ˈempəθi/', N'sự đồng cảm', N'noun', N'INTERMEDIATE', N'Empathy helps us understand others.', N'Sự đồng cảm giúp chúng ta hiểu người khác.'),
(N'envy', N'/ˈenvi/', N'sự ghen tị', N'noun', N'INTERMEDIATE', N'Envy is a destructive emotion.', N'Ghen tị là cảm xúc phá hoại.'),
(N'euphoria', N'/juːˈfɔːriə/', N'cảm giác phấn khích / hưng phấn', N'noun', N'ADVANCED', N'She felt euphoria after winning.', N'Cô ấy cảm thấy hưng phấn sau khi chiến thắng.'),
(N'frustration', N'/frʌˈstreɪʃən/', N'sự bực bội', N'noun', N'INTERMEDIATE', N'Express frustration in healthy ways.', N'Bày tỏ sự bực bội theo cách lành mạnh.'),
(N'gratitude', N'/ˈɡrætɪtjuːd/', N'lòng biết ơn', N'noun', N'INTERMEDIATE', N'Express gratitude for small things.', N'Bày tỏ lòng biết ơn vì những điều nhỏ.'),
(N'grief', N'/ɡriːf/', N'nỗi đau buồn', N'noun', N'INTERMEDIATE', N'Give yourself time to grieve.', N'Hãy cho mình thời gian để đau buồn.'),
(N'guilt', N'/ɡɪlt/', N'cảm giác tội lỗi', N'noun', N'INTERMEDIATE', N'Guilt can motivate change.', N'Cảm giác tội lỗi có thể thúc đẩy thay đổi.'),
(N'humility', N'/hjuːˈmɪlɪti/', N'sự khiêm tốn', N'noun', N'INTERMEDIATE', N'Humility is a great virtue.', N'Khiêm tốn là đức tính tốt.'),
(N'jealousy', N'/ˈdʒeləsi/', N'sự ghen tuông', N'noun', N'INTERMEDIATE', N'Jealousy can damage relationships.', N'Ghen tuông có thể phá vỡ mối quan hệ.'),
(N'loneliness', N'/ˈloʊnlinɪs/', N'sự cô đơn', N'noun', N'INTERMEDIATE', N'Reach out if you feel loneliness.', N'Hãy liên hệ nếu bạn cảm thấy cô đơn.'),
(N'melancholy', N'/ˈmelənkɒli/', N'u sầu / buồn bã', N'noun', N'ADVANCED', N'A sense of melancholy filled the room.', N'Cảm giác u buồn lan tràn căn phòng.'),
(N'nostalgia', N'/nɒˈstældʒə/', N'nỗi nhớ quê hương / hoài niệm', N'noun', N'ADVANCED', N'Old photos evoke nostalgia.', N'Ảnh cũ gợi lên hoài niệm.'),
(N'optimism', N'/ˈɒptɪmɪzəm/', N'sự lạc quan', N'noun', N'INTERMEDIATE', N'Optimism helps overcome challenges.', N'Lạc quan giúp vượt qua thử thách.'),
(N'patience', N'/ˈpeɪʃəns/', N'sự kiên nhẫn', N'noun', N'BEGINNER', N'Patience is a virtue.', N'Kiên nhẫn là đức tính tốt.'),
(N'pessimism', N'/ˈpesɪmɪzəm/', N'sự bi quan', N'noun', N'INTERMEDIATE', N'Avoid pessimism and think positive.', N'Tránh bi quan và suy nghĩ tích cực.'),
(N'pride', N'/praɪd/', N'niềm tự hào', N'noun', N'BEGINNER', N'She felt great pride in her work.', N'Cô ấy cảm thấy rất tự hào về công việc của mình.'),
(N'regret', N'/rɪˈɡret/', N'hối tiếc', N'noun', N'INTERMEDIATE', N'Live without regret.', N'Sống không hối tiếc.'),
(N'resentment', N'/rɪˈzentmənt/', N'sự oán giận', N'noun', N'ADVANCED', N'Let go of resentment for inner peace.', N'Buông bỏ oán giận để tìm sự bình yên bên trong.'),
(N'shame', N'/ʃeɪm/', N'xấu hổ', N'noun', N'INTERMEDIATE', N'There is no shame in asking for help.', N'Không có gì xấu hổ khi nhờ giúp đỡ.'),
(N'sympathy', N'/ˈsɪmpəθi/', N'sự thông cảm', N'noun', N'INTERMEDIATE', N'He expressed sympathy for her loss.', N'Anh ấy bày tỏ sự thông cảm với mất mát của cô ấy.'),
-- Thematic: Sports & Fitness
(N'cardio', N'/ˈkɑːrdioʊ/', N'bài tập tim mạch', N'noun', N'INTERMEDIATE', N'Do cardio every morning.', N'Làm bài tập tim mạch mỗi buổi sáng.'),
(N'endurance', N'/ɪnˈdjʊərəns/', N'sức bền', N'noun', N'INTERMEDIATE', N'Build endurance through running.', N'Xây dựng sức bền qua chạy bộ.'),
(N'flexibility', N'/ˌfleksɪˈbɪlɪti/', N'độ linh hoạt', N'noun', N'INTERMEDIATE', N'Yoga improves flexibility.', N'Yoga cải thiện độ linh hoạt.'),
(N'gym', N'/dʒɪm/', N'phòng gym', N'noun', N'BEGINNER', N'Go to the gym three times a week.', N'Đến phòng gym ba lần một tuần.'),
(N'interval', N'/ˈɪntərvəl/', N'khoảng thời gian', N'noun', N'INTERMEDIATE', N'Rest at regular intervals.', N'Nghỉ ngơi theo khoảng thời gian đều đặn.'),
(N'jogging', N'/ˈdʒɒɡɪŋ/', N'chạy bộ nhẹ', N'noun', N'BEGINNER', N'Jogging in the morning feels great.', N'Chạy bộ nhẹ buổi sáng cảm thấy tuyệt vời.'),
(N'meditation', N'/ˌmedɪˈteɪʃən/', N'thiền định', N'noun', N'INTERMEDIATE', N'Meditation reduces stress.', N'Thiền định giảm căng thẳng.'),
(N'muscle', N'/ˈmʌsəl/', N'cơ bắp', N'noun', N'BEGINNER', N'Build muscle with weight training.', N'Tăng cơ bắp bằng tập tạ.'),
(N'referee', N'/ˌrefəˈriː/', N'trọng tài', N'noun', N'BEGINNER', N'The referee blew the whistle.', N'Trọng tài thổi còi.'),
(N'stamina', N'/ˈstæmɪnə/', N'sức chịu đựng', N'noun', N'INTERMEDIATE', N'Increase your stamina with training.', N'Tăng sức chịu đựng bằng cách luyện tập.'),
(N'trophy', N'/ˈtroʊfi/', N'cúp / chiến lợi phẩm', N'noun', N'BEGINNER', N'He won a gold trophy.', N'Anh ấy giành được cúp vàng.'),
(N'warm-up', N'/wɔːrm ʌp/', N'khởi động', N'noun', N'BEGINNER', N'Always do a warm-up before exercise.', N'Luôn khởi động trước khi tập thể dục.'),
(N'workout', N'/ˈwɜːrkaʊt/', N'buổi tập luyện', N'noun', N'INTERMEDIATE', N'A 30-minute workout is enough.', N'Buổi tập 30 phút là đủ.'),
(N'yoga', N'/ˈjoʊɡə/', N'yoga', N'noun', N'BEGINNER', N'Yoga is good for mind and body.', N'Yoga tốt cho tâm trí và cơ thể.'),
(N'agility', N'/əˈdʒɪlɪti/', N'sự nhanh nhẹn', N'noun', N'INTERMEDIATE', N'Athletes need agility and speed.', N'Vận động viên cần sự nhanh nhẹn và tốc độ.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('anxiety','compassion','confidence','contempt','crave','curiosity','depression','despair','determination','disgust','empathy','envy','euphoria','frustration','gratitude','grief','guilt','humility','jealousy','loneliness','melancholy','nostalgia','optimism','patience','pessimism','pride','regret','resentment','shame','sympathy','cardio','endurance','flexibility','gym','interval','jogging','meditation','muscle','referee','stamina','trophy','warm-up','workout','yoga','agility');
