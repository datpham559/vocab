--liquibase formatted sql

--changeset vocab:034-seed-words-batch27
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Science & Research
(N'analyze', N'/ˈænəlaɪz/', N'phân tích', N'verb', N'INTERMEDIATE', N'Analyze the data carefully.', N'Phân tích dữ liệu cẩn thận.'),
(N'anomaly', N'/əˈnɒməli/', N'điều bất thường', N'noun', N'ADVANCED', N'The anomaly in the data was flagged.', N'Điều bất thường trong dữ liệu đã được gắn cờ.'),
(N'asteroid', N'/ˈæstərɔɪd/', N'tiểu hành tinh', N'noun', N'INTERMEDIATE', N'An asteroid passed near Earth.', N'Một tiểu hành tinh đã bay qua gần Trái Đất.'),
(N'atom', N'/ˈætəm/', N'nguyên tử', N'noun', N'BEGINNER', N'An atom is the basic unit of matter.', N'Nguyên tử là đơn vị cơ bản của vật chất.'),
(N'bacteria', N'/bækˈtɪəriə/', N'vi khuẩn', N'noun', N'INTERMEDIATE', N'Some bacteria are beneficial.', N'Một số vi khuẩn có lợi.'),
(N'carbon', N'/ˈkɑːrbən/', N'carbon', N'noun', N'INTERMEDIATE', N'Reduce carbon emissions daily.', N'Giảm lượng phát thải carbon hàng ngày.'),
(N'catalyst', N'/ˈkætəlɪst/', N'chất xúc tác', N'noun', N'ADVANCED', N'Innovation is a catalyst for growth.', N'Đổi mới là chất xúc tác cho sự tăng trưởng.'),
(N'cell', N'/sel/', N'tế bào', N'noun', N'BEGINNER', N'Cells are the building blocks of life.', N'Tế bào là khối xây dựng của sự sống.'),
(N'chemical', N'/ˈkemɪkəl/', N'hóa học / chất hóa học', N'noun', N'BEGINNER', N'Handle chemicals with care.', N'Xử lý hóa chất cẩn thận.'),
(N'chromosome', N'/ˈkroʊməsoʊm/', N'nhiễm sắc thể', N'noun', N'ADVANCED', N'Humans have 46 chromosomes.', N'Con người có 46 nhiễm sắc thể.'),
(N'compound', N'/ˈkɒmpaʊnd/', N'hợp chất', N'noun', N'INTERMEDIATE', N'Water is a compound of hydrogen and oxygen.', N'Nước là hợp chất của hydro và oxy.'),
(N'condense', N'/kənˈdens/', N'ngưng tụ / tóm tắt', N'verb', N'INTERMEDIATE', N'Steam condenses into water.', N'Hơi nước ngưng tụ thành nước.'),
(N'density', N'/ˈdensɪti/', N'mật độ / khối lượng riêng', N'noun', N'INTERMEDIATE', N'Iron has a high density.', N'Sắt có khối lượng riêng cao.'),
(N'DNA', N'/ˌdiː en ˈeɪ/', N'ADN', N'noun', N'INTERMEDIATE', N'DNA carries genetic information.', N'ADN mang thông tin di truyền.'),
(N'element', N'/ˈelɪmənt/', N'nguyên tố', N'noun', N'INTERMEDIATE', N'Oxygen is a key element for life.', N'Oxy là nguyên tố thiết yếu cho sự sống.'),
(N'evolution', N'/ˌiːvəˈluːʃən/', N'tiến hóa', N'noun', N'INTERMEDIATE', N'Evolution explains biodiversity.', N'Tiến hóa giải thích sự đa dạng sinh học.'),
(N'fossil', N'/ˈfɒsəl/', N'hóa thạch', N'noun', N'BEGINNER', N'Fossils tell us about ancient life.', N'Hóa thạch cho chúng ta biết về sự sống cổ đại.'),
(N'friction', N'/ˈfrɪkʃən/', N'ma sát', N'noun', N'INTERMEDIATE', N'Friction slows moving objects.', N'Ma sát làm chậm các vật đang chuyển động.'),
(N'gene', N'/dʒiːn/', N'gen', N'noun', N'INTERMEDIATE', N'Genes influence traits and behavior.', N'Gen ảnh hưởng đến đặc điểm và hành vi.'),
(N'gravity', N'/ˈɡrævɪti/', N'trọng lực', N'noun', N'BEGINNER', N'Gravity keeps us on the ground.', N'Trọng lực giữ chúng ta trên mặt đất.'),
(N'hypothesis', N'/haɪˈpɒθɪsɪs/', N'giả thuyết', N'noun', N'INTERMEDIATE', N'Test the hypothesis with experiments.', N'Kiểm tra giả thuyết bằng thí nghiệm.'),
(N'laboratory', N'/ˈlæbrətɔːri/', N'phòng thí nghiệm', N'noun', N'INTERMEDIATE', N'Work safely in the laboratory.', N'Làm việc an toàn trong phòng thí nghiệm.'),
(N'laser', N'/ˈleɪzər/', N'tia laser', N'noun', N'INTERMEDIATE', N'The laser cuts metal precisely.', N'Tia laser cắt kim loại chính xác.'),
(N'magnetic', N'/mæɡˈnetɪk/', N'từ tính', N'adjective', N'INTERMEDIATE', N'A magnetic field surrounds Earth.', N'Từ trường bao quanh Trái Đất.'),
(N'membrane', N'/ˈmembreɪn/', N'màng (sinh học)', N'noun', N'ADVANCED', N'The cell membrane controls entry.', N'Màng tế bào kiểm soát sự ra vào.'),
(N'microscope', N'/ˈmaɪkrəskoʊp/', N'kính hiển vi', N'noun', N'BEGINNER', N'Use a microscope to see cells.', N'Dùng kính hiển vi để nhìn tế bào.'),
(N'molecule', N'/ˈmɒlɪkjuːl/', N'phân tử', N'noun', N'INTERMEDIATE', N'Water molecules contain hydrogen.', N'Phân tử nước chứa hydro.'),
(N'neutron', N'/ˈnjuːtrɒn/', N'nơtron', N'noun', N'ADVANCED', N'Neutrons have no electric charge.', N'Nơtron không có điện tích.'),
(N'nucleus', N'/ˈnjuːkliəs/', N'hạt nhân', N'noun', N'INTERMEDIATE', N'The nucleus contains genetic material.', N'Hạt nhân chứa vật liệu di truyền.'),
(N'orbit', N'/ˈɔːrbɪt/', N'quỹ đạo', N'noun', N'INTERMEDIATE', N'The Earth orbits the sun.', N'Trái Đất quay quanh mặt trời.'),
(N'organism', N'/ˈɔːrɡənɪzəm/', N'sinh vật', N'noun', N'INTERMEDIATE', N'Every organism needs energy.', N'Mọi sinh vật đều cần năng lượng.'),
(N'particle', N'/ˈpɑːrtɪkəl/', N'hạt (vật lý)', N'noun', N'INTERMEDIATE', N'Subatomic particles are very small.', N'Hạt hạ nguyên tử rất nhỏ.'),
(N'photosynthesis', N'/ˌfoʊtəˈsɪnθɪsɪs/', N'quang hợp', N'noun', N'INTERMEDIATE', N'Plants use photosynthesis for energy.', N'Cây cối sử dụng quang hợp để lấy năng lượng.'),
(N'plasma', N'/ˈplæzmə/', N'huyết tương / plasma', N'noun', N'ADVANCED', N'Blood plasma carries nutrients.', N'Huyết tương mang chất dinh dưỡng.'),
(N'polymer', N'/ˈpɒlɪmər/', N'polyme', N'noun', N'ADVANCED', N'Plastic is a common polymer.', N'Nhựa là polyme phổ biến.'),
(N'probe', N'/proʊb/', N'thăm dò / tàu thăm dò', N'noun', N'INTERMEDIATE', N'A space probe explored Mars.', N'Một tàu thăm dò không gian đã khám phá Sao Hỏa.'),
(N'proton', N'/ˈproʊtɒn/', N'proton', N'noun', N'ADVANCED', N'Protons carry a positive charge.', N'Proton mang điện tích dương.'),
(N'radiation', N'/ˌreɪdiˈeɪʃən/', N'bức xạ', N'noun', N'INTERMEDIATE', N'Radiation can be harmful.', N'Bức xạ có thể gây hại.'),
(N'reaction', N'/riˈækʃən/', N'phản ứng (hóa học)', N'noun', N'INTERMEDIATE', N'A chemical reaction creates new substances.', N'Phản ứng hóa học tạo ra chất mới.'),
(N'relativity', N'/ˌrelɪˈtɪvɪti/', N'thuyết tương đối', N'noun', N'ADVANCED', N'Einstein''s relativity changed physics.', N'Thuyết tương đối của Einstein đã thay đổi vật lý.'),
(N'renewable', N'/rɪˈnjuːəbəl/', N'tái tạo được', N'adjective', N'INTERMEDIATE', N'Solar is a renewable energy source.', N'Mặt trời là nguồn năng lượng tái tạo.'),
(N'research', N'/rɪˈsɜːrtʃ/', N'nghiên cứu', N'noun', N'BEGINNER', N'Research leads to new discoveries.', N'Nghiên cứu dẫn đến những khám phá mới.'),
(N'specimen', N'/ˈspesɪmɪn/', N'mẫu vật', N'noun', N'INTERMEDIATE', N'The scientist examined the specimen.', N'Nhà khoa học kiểm tra mẫu vật.'),
(N'telescope', N'/ˈtelɪskoʊp/', N'kính thiên văn', N'noun', N'BEGINNER', N'Use a telescope to see stars.', N'Dùng kính thiên văn để nhìn ngôi sao.'),
(N'thermometer', N'/θəˈmɒmɪtər/', N'nhiệt kế', N'noun', N'BEGINNER', N'The thermometer reads 38 degrees.', N'Nhiệt kế chỉ 38 độ.'),
(N'variable', N'/ˈveəriəbəl/', N'biến số', N'noun', N'INTERMEDIATE', N'Control all variables in the experiment.', N'Kiểm soát tất cả các biến số trong thí nghiệm.'),
(N'velocity', N'/vɪˈlɒsɪti/', N'vận tốc', N'noun', N'INTERMEDIATE', N'The velocity of sound is 340 m/s.', N'Vận tốc âm thanh là 340 m/s.'),
(N'virus', N'/ˈvaɪrəs/', N'virus', N'noun', N'BEGINNER', N'Wash hands to prevent virus spread.', N'Rửa tay để ngăn virus lây lan.'),
(N'wavelength', N'/ˈweɪvleŋθ/', N'bước sóng', N'noun', N'ADVANCED', N'Different colors have different wavelengths.', N'Các màu khác nhau có bước sóng khác nhau.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('analyze','anomaly','asteroid','atom','bacteria','carbon','catalyst','cell','chemical','chromosome','compound','condense','density','DNA','element','evolution','fossil','friction','gene','gravity','hypothesis','laboratory','laser','magnetic','membrane','microscope','molecule','neutron','nucleus','orbit','organism','particle','photosynthesis','plasma','polymer','probe','proton','radiation','reaction','relativity','renewable','research','specimen','telescope','thermometer','variable','velocity','virus','wavelength');
