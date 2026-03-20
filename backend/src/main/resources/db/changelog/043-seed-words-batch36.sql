--liquibase formatted sql

--changeset vocab:043-seed-words-batch36
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Colors & Visual Description
(N'amber', N'/ˈæmbər/', N'màu hổ phách', N'noun', N'INTERMEDIATE', N'The sky turned amber at sunset.', N'Bầu trời chuyển màu hổ phách khi hoàng hôn.'),
(N'azure', N'/ˈæʒər/', N'màu xanh da trời', N'adjective', N'ADVANCED', N'The azure sea sparkled in sunlight.', N'Biển xanh da trời lấp lánh trong nắng.'),
(N'beige', N'/beɪʒ/', N'màu be', N'noun', N'INTERMEDIATE', N'She painted the walls beige.', N'Cô ấy sơn tường màu be.'),
(N'bronze', N'/brɒnz/', N'đồng thau / màu đồng', N'noun', N'INTERMEDIATE', N'He won a bronze medal.', N'Anh ấy giành huy chương đồng.'),
(N'charcoal', N'/ˈtʃɑːrkoʊl/', N'màu xám than', N'noun', N'INTERMEDIATE', N'The charcoal suit looks elegant.', N'Bộ vest màu xám than trông thanh lịch.'),
(N'crimson', N'/ˈkrɪmzən/', N'màu đỏ thẫm', N'adjective', N'ADVANCED', N'Crimson roses lined the path.', N'Hoa hồng đỏ thẫm viền theo con đường.'),
(N'ebony', N'/ˈebəni/', N'màu đen tuyền', N'adjective', N'ADVANCED', N'Her hair was ebony black.', N'Tóc cô ấy đen tuyền.'),
(N'emerald', N'/ˈemərəld/', N'màu xanh ngọc lục bảo', N'adjective', N'INTERMEDIATE', N'The valley was emerald green.', N'Thung lũng xanh ngọc lục bảo.'),
(N'fuchsia', N'/ˈfjuːʃə/', N'màu hồng đậm', N'noun', N'ADVANCED', N'She wore a fuchsia dress.', N'Cô ấy mặc váy màu hồng đậm.'),
(N'ivory', N'/ˈaɪvəri/', N'màu ngà voi', N'adjective', N'INTERMEDIATE', N'The wedding dress was ivory white.', N'Váy cưới màu trắng ngà.'),
(N'lavender', N'/ˈlævəndər/', N'màu tím nhạt / hoa oải hương', N'noun', N'INTERMEDIATE', N'She loves lavender perfume.', N'Cô ấy thích nước hoa hoa oải hương.'),
(N'maroon', N'/məˈruːn/', N'màu đỏ tía', N'noun', N'INTERMEDIATE', N'He chose a maroon tie.', N'Anh ấy chọn cà vạt màu đỏ tía.'),
(N'mustard', N'/ˈmʌstərd/', N'màu vàng mù tạt', N'noun', N'INTERMEDIATE', N'The mustard coat stands out.', N'Áo khoác màu vàng mù tạt nổi bật.'),
(N'navy', N'/ˈneɪvi/', N'màu xanh đậm', N'adjective', N'BEGINNER', N'Wear a navy blue jacket.', N'Mặc áo khoác màu xanh đậm.'),
(N'nude', N'/njuːd/', N'màu da / trần', N'adjective', N'INTERMEDIATE', N'Nude heels go with any outfit.', N'Giày cao gót màu da hợp với bất kỳ trang phục nào.'),
(N'olive', N'/ˈɒlɪv/', N'màu xanh ô liu', N'adjective', N'INTERMEDIATE', N'He wore olive green pants.', N'Anh ấy mặc quần màu xanh ô liu.'),
(N'peach', N'/piːtʃ/', N'màu đào', N'adjective', N'BEGINNER', N'The walls are painted peach.', N'Tường được sơn màu đào.'),
(N'scarlet', N'/ˈskɑːrlɪt/', N'màu đỏ tươi', N'adjective', N'INTERMEDIATE', N'She blushed scarlet with embarrassment.', N'Cô ấy đỏ mặt vì xấu hổ.'),
(N'silver', N'/ˈsɪlvər/', N'màu bạc', N'adjective', N'BEGINNER', N'The moon cast a silver light.', N'Mặt trăng tỏa ánh sáng bạc.'),
(N'teal', N'/tiːl/', N'màu xanh lam pha lục', N'noun', N'INTERMEDIATE', N'The ocean looks teal today.', N'Đại dương trông màu xanh lam pha lục hôm nay.'),
(N'turquoise', N'/ˈtɜːrkwɔɪz/', N'màu xanh ngọc / ngọc lam', N'noun', N'INTERMEDIATE', N'The turquoise water is stunning.', N'Nước màu ngọc lam thật tuyệt vời.'),
(N'violet', N'/ˈvaɪəlɪt/', N'màu tím / hoa violet', N'noun', N'BEGINNER', N'Violet is between blue and purple.', N'Màu tím nằm giữa xanh và tím đậm.'),
-- Thematic: Shapes & Space
(N'circular', N'/ˈsɜːrkjʊlər/', N'hình tròn', N'adjective', N'BEGINNER', N'The table has a circular shape.', N'Cái bàn có hình tròn.'),
(N'cubic', N'/ˈkjuːbɪk/', N'hình lập phương', N'adjective', N'INTERMEDIATE', N'The cubic meter is a unit of volume.', N'Mét khối là đơn vị đo thể tích.'),
(N'cylindrical', N'/sɪˈlɪndrɪkəl/', N'hình trụ', N'adjective', N'INTERMEDIATE', N'The container is cylindrical.', N'Hộp đựng có hình trụ.'),
(N'diagonal', N'/daɪˈæɡənəl/', N'đường chéo', N'noun', N'INTERMEDIATE', N'Draw a diagonal line.', N'Vẽ một đường chéo.'),
(N'dimension', N'/daɪˈmenʃən/', N'kích thước / chiều', N'noun', N'INTERMEDIATE', N'What are the dimensions of the room?', N'Kích thước của căn phòng là bao nhiêu?'),
(N'geometric', N'/ˌdʒiːəˈmetrɪk/', N'hình học', N'adjective', N'INTERMEDIATE', N'The pattern has geometric shapes.', N'Hoa văn có các hình học.'),
(N'hexagon', N'/ˈheksəɡɒn/', N'hình lục giác', N'noun', N'INTERMEDIATE', N'A honeycomb has hexagonal cells.', N'Tổ ong có các ô hình lục giác.'),
(N'horizontal', N'/ˌhɒrɪˈzɒntəl/', N'nằm ngang', N'adjective', N'BEGINNER', N'Draw a horizontal line.', N'Vẽ một đường nằm ngang.'),
(N'oval', N'/ˈoʊvəl/', N'hình bầu dục', N'adjective', N'BEGINNER', N'The mirror is oval-shaped.', N'Gương có hình bầu dục.'),
(N'parallel', N'/ˈpærəlel/', N'song song', N'adjective', N'INTERMEDIATE', N'The rails are parallel.', N'Các đường ray song song.'),
(N'pentagon', N'/ˈpentəɡɒn/', N'hình ngũ giác', N'noun', N'INTERMEDIATE', N'A pentagon has five sides.', N'Hình ngũ giác có năm cạnh.'),
(N'perpendicular', N'/ˌpɜːrpənˈdɪkjʊlər/', N'vuông góc', N'adjective', N'INTERMEDIATE', N'The lines are perpendicular.', N'Các đường thẳng vuông góc.'),
(N'prism', N'/ˈprɪzəm/', N'lăng kính', N'noun', N'INTERMEDIATE', N'A prism splits light into colors.', N'Lăng kính chia ánh sáng thành màu sắc.'),
(N'sphere', N'/sfɪər/', N'hình cầu', N'noun', N'INTERMEDIATE', N'Earth is roughly a sphere.', N'Trái Đất có hình dạng gần như hình cầu.'),
(N'symmetry', N'/ˈsɪmɪtri/', N'sự đối xứng', N'noun', N'INTERMEDIATE', N'The design has perfect symmetry.', N'Thiết kế có sự đối xứng hoàn hảo.'),
(N'trapezoid', N'/ˈtræpɪzɔɪd/', N'hình thang', N'noun', N'INTERMEDIATE', N'A trapezoid has one pair of parallel sides.', N'Hình thang có một cặp cạnh song song.'),
(N'vertical', N'/ˈvɜːrtɪkəl/', N'thẳng đứng', N'adjective', N'BEGINNER', N'Keep the post vertical.', N'Giữ cột thẳng đứng.'),
-- Thematic: Numbers & Math
(N'calculate', N'/ˈkælkjʊleɪt/', N'tính toán', N'verb', N'BEGINNER', N'Calculate the total cost.', N'Tính tổng chi phí.'),
(N'decimal', N'/ˈdesɪməl/', N'số thập phân', N'noun', N'INTERMEDIATE', N'Write numbers as decimals.', N'Viết số dưới dạng số thập phân.'),
(N'denominator', N'/dɪˈnɒmɪneɪtər/', N'mẫu số', N'noun', N'INTERMEDIATE', N'The denominator is the bottom number.', N'Mẫu số là số ở dưới.'),
(N'equation', N'/ɪˈkweɪʒən/', N'phương trình', N'noun', N'INTERMEDIATE', N'Solve the equation for x.', N'Giải phương trình tìm x.'),
(N'fraction', N'/ˈfrækʃən/', N'phân số', N'noun', N'BEGINNER', N'One half is a fraction.', N'Một phần hai là một phân số.'),
(N'geometry', N'/dʒiˈɒmɪtri/', N'hình học', N'noun', N'INTERMEDIATE', N'Geometry studies shapes and space.', N'Hình học nghiên cứu hình dạng và không gian.'),
(N'integer', N'/ˈɪntɪdʒər/', N'số nguyên', N'noun', N'INTERMEDIATE', N'Integers include positive and negative numbers.', N'Số nguyên bao gồm số dương và âm.'),
(N'multiply', N'/ˈmʌltɪplaɪ/', N'nhân', N'verb', N'BEGINNER', N'Multiply 5 by 4 to get 20.', N'Nhân 5 với 4 để được 20.'),
(N'numerator', N'/ˈnjuːmərɪtər/', N'tử số', N'noun', N'INTERMEDIATE', N'The numerator is the top number.', N'Tử số là số ở trên.'),
(N'percentage', N'/pəˈsentɪdʒ/', N'tỷ lệ phần trăm', N'noun', N'INTERMEDIATE', N'Calculate the percentage increase.', N'Tính tỷ lệ phần trăm tăng.'),
(N'probability', N'/ˌprɒbəˈbɪlɪti/', N'xác suất', N'noun', N'INTERMEDIATE', N'What is the probability of rain?', N'Xác suất mưa là bao nhiêu?'),
(N'statistics', N'/stəˈtɪstɪks/', N'thống kê', N'noun', N'INTERMEDIATE', N'Statistics help analyze data.', N'Thống kê giúp phân tích dữ liệu.'),
(N'subtract', N'/səbˈtrækt/', N'trừ', N'verb', N'BEGINNER', N'Subtract 3 from 10 to get 7.', N'Trừ 3 từ 10 để được 7.'),
(N'theorem', N'/ˈθɪərəm/', N'định lý', N'noun', N'ADVANCED', N'Pythagoras''s theorem is fundamental.', N'Định lý Pythagoras là cơ bản.'),
(N'trigonometry', N'/ˌtrɪɡəˈnɒmɪtri/', N'lượng giác', N'noun', N'ADVANCED', N'Trigonometry uses angles and triangles.', N'Lượng giác sử dụng góc và tam giác.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('amber','azure','beige','bronze','charcoal','crimson','ebony','emerald','fuchsia','ivory','lavender','maroon','mustard','navy','nude','scarlet','silver','teal','turquoise','violet','circular','cubic','cylindrical','diagonal','dimension','geometric','hexagon','horizontal','oval','parallel','pentagon','perpendicular','prism','sphere','symmetry','trapezoid','vertical','calculate','decimal','denominator','equation','fraction','geometry','integer','multiply','numerator','percentage','probability','statistics','subtract','theorem','trigonometry');
