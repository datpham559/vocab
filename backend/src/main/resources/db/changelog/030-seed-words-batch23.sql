--liquibase formatted sql

--changeset vocab:030-seed-words-batch23
INSERT INTO words (word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
SELECT v.word, v.pronunciation, v.meaning_vi, v.part_of_speech, v.difficulty, v.example_sentence, v.example_translation
FROM (VALUES
-- Thematic: Finance & Economics
(N'asset', N'/ˈæset/', N'tài sản', N'noun', N'INTERMEDIATE', N'Real estate is a valuable asset.', N'Bất động sản là tài sản có giá trị.'),
(N'audit', N'/ˈɔːdɪt/', N'kiểm toán', N'noun', N'INTERMEDIATE', N'The company passed the annual audit.', N'Công ty vượt qua kiểm toán hàng năm.'),
(N'bond', N'/bɒnd/', N'trái phiếu / liên kết', N'noun', N'INTERMEDIATE', N'Invest in government bonds.', N'Đầu tư vào trái phiếu chính phủ.'),
(N'capital', N'/ˈkæpɪtəl/', N'vốn / thủ đô', N'noun', N'INTERMEDIATE', N'Raise capital from investors.', N'Huy động vốn từ nhà đầu tư.'),
(N'collateral', N'/kəˈlætərəl/', N'tài sản thế chấp', N'noun', N'ADVANCED', N'Use property as collateral for a loan.', N'Dùng bất động sản làm tài sản thế chấp.'),
(N'commodity', N'/kəˈmɒdɪti/', N'hàng hóa', N'noun', N'INTERMEDIATE', N'Oil is a valuable commodity.', N'Dầu là hàng hóa có giá trị.'),
(N'credit', N'/ˈkredɪt/', N'tín dụng', N'noun', N'INTERMEDIATE', N'Apply for a credit card.', N'Đăng ký thẻ tín dụng.'),
(N'currency', N'/ˈkʌrənsi/', N'tiền tệ', N'noun', N'INTERMEDIATE', N'The local currency is the dong.', N'Tiền tệ địa phương là đồng.'),
(N'debt', N'/det/', N'nợ', N'noun', N'INTERMEDIATE', N'Pay off your debt as soon as possible.', N'Trả nợ càng sớm càng tốt.'),
(N'deficit', N'/ˈdefɪsɪt/', N'thâm hụt', N'noun', N'ADVANCED', N'The budget deficit grew this year.', N'Thâm hụt ngân sách tăng năm nay.'),
(N'dividend', N'/ˈdɪvɪdend/', N'cổ tức', N'noun', N'ADVANCED', N'Shareholders receive quarterly dividends.', N'Cổ đông nhận cổ tức hàng quý.'),
(N'equity', N'/ˈekwɪti/', N'vốn chủ sở hữu', N'noun', N'ADVANCED', N'Build equity in your home.', N'Xây dựng vốn sở hữu trong nhà của bạn.'),
(N'expenditure', N'/ɪkˈspendɪtʃər/', N'chi tiêu', N'noun', N'ADVANCED', N'Track your monthly expenditure.', N'Theo dõi chi tiêu hàng tháng của bạn.'),
(N'fiscal', N'/ˈfɪskəl/', N'tài chính / ngân sách', N'adjective', N'ADVANCED', N'The fiscal year ends in December.', N'Năm tài chính kết thúc vào tháng Mười Hai.'),
(N'inflation', N'/ɪnˈfleɪʃən/', N'lạm phát', N'noun', N'INTERMEDIATE', N'Inflation reduces purchasing power.', N'Lạm phát làm giảm sức mua.'),
(N'interest rate', N'/ˈɪntrəst reɪt/', N'lãi suất', N'noun', N'INTERMEDIATE', N'The interest rate dropped to 2%.', N'Lãi suất giảm xuống 2%.'),
(N'invest', N'/ɪnˈvest/', N'đầu tư', N'verb', N'INTERMEDIATE', N'Invest early for a better future.', N'Đầu tư sớm cho tương lai tốt hơn.'),
(N'liability', N'/ˌlaɪəˈbɪlɪti/', N'trách nhiệm pháp lý / nợ phải trả', N'noun', N'ADVANCED', N'Assets minus liabilities equals equity.', N'Tài sản trừ nợ phải trả bằng vốn chủ sở hữu.'),
(N'liquidity', N'/lɪˈkwɪdɪti/', N'tính thanh khoản', N'noun', N'ADVANCED', N'Cash has the highest liquidity.', N'Tiền mặt có tính thanh khoản cao nhất.'),
(N'mortgage', N'/ˈmɔːrɡɪdʒ/', N'thế chấp nhà', N'noun', N'INTERMEDIATE', N'She took out a mortgage to buy a house.', N'Cô ấy thế chấp để mua nhà.'),
(N'portfolio', N'/pɔːrtˈfoʊlioʊ/', N'danh mục đầu tư', N'noun', N'ADVANCED', N'Diversify your investment portfolio.', N'Đa dạng hóa danh mục đầu tư.'),
(N'profit', N'/ˈprɒfɪt/', N'lợi nhuận', N'noun', N'INTERMEDIATE', N'The company made a large profit.', N'Công ty kiếm được lợi nhuận lớn.'),
(N'revenue', N'/ˈrevɪnjuː/', N'doanh thu', N'noun', N'INTERMEDIATE', N'Increase revenue with new products.', N'Tăng doanh thu với sản phẩm mới.'),
(N'shareholder', N'/ˈʃeərhəʊldər/', N'cổ đông', N'noun', N'INTERMEDIATE', N'Shareholders voted on the merger.', N'Cổ đông bỏ phiếu về việc sáp nhập.'),
(N'stock market', N'/stɒk ˈmɑːrkɪt/', N'thị trường chứng khoán', N'noun', N'INTERMEDIATE', N'The stock market rose sharply.', N'Thị trường chứng khoán tăng mạnh.'),
(N'subsidy', N'/ˈsʌbsɪdi/', N'trợ cấp / trợ giá', N'noun', N'INTERMEDIATE', N'The government provides farming subsidies.', N'Chính phủ cung cấp trợ giá nông nghiệp.'),
(N'surplus', N'/ˈsɜːrpləs/', N'thặng dư', N'noun', N'ADVANCED', N'A trade surplus benefits the economy.', N'Thặng dư thương mại có lợi cho nền kinh tế.'),
(N'tariff', N'/ˈtærɪf/', N'thuế quan', N'noun', N'ADVANCED', N'Import tariffs protect local industry.', N'Thuế quan nhập khẩu bảo vệ công nghiệp trong nước.'),
(N'transaction', N'/trænˈzækʃən/', N'giao dịch', N'noun', N'INTERMEDIATE', N'Every transaction is recorded.', N'Mỗi giao dịch được ghi lại.'),
(N'venture', N'/ˈventʃər/', N'liên doanh / mạo hiểm', N'noun', N'INTERMEDIATE', N'They started a joint venture.', N'Họ thành lập liên doanh.'),
-- Thematic: Technology & Computing
(N'algorithm', N'/ˈælɡərɪðəm/', N'thuật toán', N'noun', N'INTERMEDIATE', N'The algorithm sorts data efficiently.', N'Thuật toán sắp xếp dữ liệu hiệu quả.'),
(N'application', N'/ˌæplɪˈkeɪʃən/', N'ứng dụng', N'noun', N'BEGINNER', N'Download the application on your phone.', N'Tải ứng dụng về điện thoại.'),
(N'bandwidth', N'/ˈbændwɪdθ/', N'băng thông', N'noun', N'INTERMEDIATE', N'High bandwidth enables fast streaming.', N'Băng thông cao cho phép phát trực tiếp nhanh.'),
(N'browser', N'/ˈbraʊzər/', N'trình duyệt', N'noun', N'BEGINNER', N'Open your browser to visit the site.', N'Mở trình duyệt để truy cập trang.'),
(N'cache', N'/kæʃ/', N'bộ nhớ cache', N'noun', N'INTERMEDIATE', N'Clear your browser cache.', N'Xóa cache trình duyệt.'),
(N'cloud computing', N'/klaʊd kəmˈpjuːtɪŋ/', N'điện toán đám mây', N'noun', N'INTERMEDIATE', N'Cloud computing stores data online.', N'Điện toán đám mây lưu trữ dữ liệu trực tuyến.'),
(N'coding', N'/ˈkoʊdɪŋ/', N'lập trình', N'noun', N'INTERMEDIATE', N'Learn coding to build apps.', N'Học lập trình để xây dựng ứng dụng.'),
(N'database', N'/ˈdeɪtəbeɪs/', N'cơ sở dữ liệu', N'noun', N'INTERMEDIATE', N'Store customer data in the database.', N'Lưu trữ dữ liệu khách hàng trong cơ sở dữ liệu.'),
(N'debug', N'/diːˈbʌɡ/', N'gỡ lỗi', N'verb', N'INTERMEDIATE', N'Debug the code before releasing.', N'Gỡ lỗi code trước khi phát hành.'),
(N'encryption', N'/ɪnˈkrɪpʃən/', N'mã hóa', N'noun', N'ADVANCED', N'Encryption protects your data.', N'Mã hóa bảo vệ dữ liệu của bạn.'),
(N'firewall', N'/ˈfaɪərwɔːl/', N'tường lửa', N'noun', N'INTERMEDIATE', N'Install a firewall for security.', N'Cài đặt tường lửa để bảo mật.'),
(N'framework', N'/ˈfreɪmwɜːrk/', N'khung / framework', N'noun', N'INTERMEDIATE', N'Use a web development framework.', N'Sử dụng framework phát triển web.'),
(N'hardware', N'/ˈhɑːrdweər/', N'phần cứng', N'noun', N'BEGINNER', N'The hardware needs upgrading.', N'Phần cứng cần nâng cấp.'),
(N'interface', N'/ˈɪntərfeɪs/', N'giao diện', N'noun', N'INTERMEDIATE', N'The user interface is simple.', N'Giao diện người dùng đơn giản.'),
(N'kernel', N'/ˈkɜːrnəl/', N'nhân hệ điều hành', N'noun', N'ADVANCED', N'The kernel manages system resources.', N'Nhân hệ điều hành quản lý tài nguyên hệ thống.'),
(N'malware', N'/ˈmælweər/', N'phần mềm độc hại', N'noun', N'INTERMEDIATE', N'Malware can damage your computer.', N'Phần mềm độc hại có thể làm hỏng máy tính.'),
(N'protocol', N'/ˈproʊtəkɒl/', N'giao thức', N'noun', N'INTERMEDIATE', N'HTTP is a web protocol.', N'HTTP là giao thức web.'),
(N'server', N'/ˈsɜːrvər/', N'máy chủ', N'noun', N'INTERMEDIATE', N'The server is down for maintenance.', N'Máy chủ đang bảo trì.'),
(N'software', N'/ˈsɒftweər/', N'phần mềm', N'noun', N'BEGINNER', N'Install the software to begin.', N'Cài đặt phần mềm để bắt đầu.'),
(N'upload', N'/ˈʌploʊd/', N'tải lên', N'verb', N'BEGINNER', N'Upload your photo here.', N'Tải ảnh của bạn lên đây.')
) AS v(word, pronunciation, meaning_vi, part_of_speech, difficulty, example_sentence, example_translation)
WHERE NOT EXISTS (SELECT 1 FROM words w WHERE w.word = v.word);

--rollback DELETE FROM words WHERE word IN ('asset','audit','bond','capital','collateral','commodity','credit','currency','debt','deficit','dividend','equity','expenditure','fiscal','inflation','interest rate','invest','liability','liquidity','mortgage','portfolio','profit','revenue','shareholder','stock market','subsidy','surplus','tariff','transaction','venture','algorithm','application','bandwidth','browser','cache','cloud computing','coding','database','debug','encryption','firewall','framework','hardware','interface','kernel','malware','protocol','server','software','upload');
