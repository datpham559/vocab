# VocabDaily — Tổng quan tính năng

Ứng dụng học từ vựng tiếng Anh, xây dựng trên nền tảng **Spring Boot + Angular + SQL Server**.

---

## Tính năng chính

### 1. Xác thực người dùng (Auth)

| Tính năng | Mô tả |
|---|---|
| Đăng ký | Tạo tài khoản với username, email, password, tên hiển thị |
| Đăng nhập | Xác thực bằng username + password |
| JWT Token | Token lưu trên localStorage, tự đính vào mọi request |
| Bảo vệ route | Các trang yêu cầu đăng nhập — tự redirect về login nếu chưa auth |
| Auto logout | Hết hạn token (24h) hoặc lỗi 401 → tự đăng xuất |

---

### 2. Dashboard (Trang chủ)

Trang tổng quan sau khi đăng nhập, hiển thị:

| Thông tin | Mô tả |
|---|---|
| Streak 🔥 | Số ngày học liên tiếp hiện tại |
| Tổng ngày đã học | Tổng số ngày có hoàn thành bài học |
| Tiến độ hôm nay | Thanh tiến trình X/10 từ đã học trong ngày (bộ từ hàng ngày) |
| Trạng thái hôm nay | Hoàn thành / Chưa xong |
| Thống kê từ vựng | Số từ theo từng trạng thái: Mới / Đang học / Ôn tập / Thành thạo |
| Phần trăm thành thạo | Tỉ lệ từ đã Mastered trên tổng từ đã gặp |
| Badge ôn tập | Số từ cần ôn hôm nay hiển thị ngay trên nút — nhắc nhở ôn tập |
| Nút hành động | Học từ mới / Ôn tập / Từ điển |

---

### 3. Học từ vựng tự do — `/study` *(mới)*

Học từ không giới hạn số lượng, không bị ràng buộc bộ từ hàng ngày.

**Luồng học:**

```
Chọn số từ → Flashcard → Quiz → Kết quả
```

| Bước | Mô tả |
|---|---|
| Chọn số từ | 10 / 20 / 50 / 100 / 200 từ — người dùng tự quyết |
| Flashcard | Xem từ → lật thẻ xem nghĩa → đánh dấu Đã nhớ / Chưa nhớ |
| Quiz | Trắc nghiệm 4 lựa chọn cho đúng các từ vừa học trong phiên |
| Kết quả | Thống kê số từ nhớ khi học flashcard + điểm % quiz |

**Logic chọn từ:**
1. Ưu tiên 1: Từ đang ở LEARNING / REVIEW và đến hạn ôn hôm nay
2. Ưu tiên 2: Từ chưa từng gặp (chưa có trong `user_word_progress`)

Từ đã MASTERED **không xuất hiện** trong phiên học mới.

---

### 4. Ôn tập — `/review` *(mới)*

Ôn lại từ đã học theo lịch spaced repetition.

| Tính năng | Mô tả |
|---|---|
| Đếm từ cần ôn | Hiển thị số từ đến hạn hôm nay ngay màn hình đầu |
| Quiz ôn tập | Trắc nghiệm 4 lựa chọn cho tất cả từ đến hạn (LEARNING + REVIEW + MASTERED) |
| Phản hồi trực tiếp | Highlight đáp án đúng/sai ngay sau khi chọn |
| Kết quả | Điểm %, thông điệp động lực theo kết quả |
| Badge trên navbar | Số từ cần ôn hiển thị nổi bật trên menu điều hướng |

---

### 5. Bộ từ hàng ngày (Daily Word Set)

- Mỗi ngày hệ thống **tự động tạo 1 bộ 10 từ** cho mỗi người dùng
- Logic chọn từ theo thứ tự ưu tiên:
  1. Từ đang LEARNING / REVIEW và đến hạn ôn (`next_review ≤ hôm nay`)
  2. Từ chưa từng gặp (NEW) — random bằng `NEWID()`
  3. Dự phòng nếu chưa đủ 10 từ
- Bộ từ được tạo **một lần duy nhất mỗi ngày** — truy cập lại vẫn là bộ cũ
- Hoàn thành bộ từ → cập nhật **streak**

---

### 6. Flashcard (Thẻ lật)

Có trong cả chế độ học tự do (`/study`) và bộ từ hàng ngày (`/flashcard`):

| Bước | Mô tả |
|---|---|
| Mặt trước | Từ tiếng Anh + phiên âm + loại từ |
| Lật thẻ | Animation 3D → nghĩa tiếng Việt + câu ví dụ + dịch |
| Đánh giá | Đã nhớ ✓ / Chưa nhớ ✗ — cập nhật tiến độ ngay lập tức |
| Thanh tiến trình | Hiển thị đang ở từ thứ mấy / tổng số từ |

---

### 7. Quiz (Trắc nghiệm)

Dùng trong nhiều ngữ cảnh: sau flashcard, ôn tập hàng ngày, review theo lịch:

| Tính năng | Mô tả |
|---|---|
| Dạng câu hỏi | Cho từ tiếng Anh → chọn nghĩa tiếng Việt đúng |
| 4 lựa chọn | 1 đáp án đúng + 3 từ nhiễu cùng độ khó (random `NEWID()`) |
| Phản hồi ngay | Đáp án đúng highlight xanh, sai highlight đỏ |
| Tiến độ | Thanh tiến trình theo câu, không quay lại câu trước |
| Kết quả | Điểm số và phần trăm |

---

### 8. Hệ thống Spaced Repetition (Lặp lại ngắt quãng)

Mỗi từ có trạng thái học, tự động lên lịch ôn:

```
NEW → LEARNING → REVIEW → MASTERED
```

| Hành động | Chuyển trạng thái | next_review |
|---|---|---|
| Đúng (NEW) | NEW → LEARNING | +1 ngày |
| Đúng (LEARNING) | LEARNING → REVIEW | +3 ngày |
| Đúng (REVIEW) | REVIEW → MASTERED | +7 ngày |
| Đúng (MASTERED) | MASTERED → MASTERED | +14 ngày |
| Sai (LEARNING) | LEARNING → LEARNING | +1 ngày |
| Sai (REVIEW) | REVIEW → LEARNING | +1 ngày |
| Sai (MASTERED) | MASTERED → REVIEW | +3 ngày |

---

### 9. Kho từ vựng — `/words`

| Tính năng | Mô tả |
|---|---|
| Tổng số từ | Hiển thị tổng số từ trong hệ thống kèm số theo từng cấp độ |
| Tìm kiếm | Tìm theo từ tiếng Anh hoặc nghĩa tiếng Việt |
| Lọc theo cấp độ | Tất cả / Cơ bản / Trung cấp / Nâng cao — kèm số lượng từng loại |
| Lọc A-Z | 26 nút chữ cái — click để lọc từ bắt đầu bằng chữ cái đó |
| Phân trang | Chọn số từ mỗi trang: 10 / 20 / 50 / 100; phân trang thông minh với `…` |
| Xem chi tiết | Click từ → mở rộng xem loại từ, chủ đề, ví dụ |
| Dữ liệu | ~3.000 từ vựng tiếng Anh phổ biến, chia 3 cấp độ |

---

### 10. Theo dõi tiến độ (Progress Tracking)

- Mỗi cặp (người dùng, từ) lưu riêng trong `user_word_progress`
- Ghi nhận: số lần đúng, sai, lần ôn cuối, ngày ôn tiếp theo
- API `/api/progress` trả toàn bộ tiến độ của người dùng

---

## Luồng sử dụng

### Học từ mới (khuyên dùng)
```
Dashboard → Học từ mới (/study)
  → Chọn số từ (vd: 20)
  → Flashcard 20 từ (lật + đánh giá)
  → Quiz 20 câu (trắc nghiệm)
  → Kết quả
```

### Ôn tập hàng ngày
```
Dashboard / Navbar → Ôn tập (/review)  [badge hiện số từ cần ôn]
  → Xem số từ đến hạn hôm nay
  → Quiz tất cả từ đến hạn
  → Kết quả + cập nhật lịch spaced repetition
```

### Bộ từ hàng ngày (legacy)
```
Dashboard → Học ngay (/flashcard)
  → Flashcard 10 từ hôm nay
  → Quiz (/quiz)
  → Dashboard (cập nhật streak)
```

---

## Cấu trúc dữ liệu

```
users                    — tài khoản, streak, last_study_date
words                    — kho ~3.000 từ vựng
user_word_progress       — tiến độ của từng người với từng từ (status, next_review)
daily_word_sets          — bộ 10 từ mỗi ngày của mỗi người
daily_word_set_words     — quan hệ N-N giữa bộ từ và từ vựng
```

---

## API Endpoints

### Auth
| Method | Endpoint | Mô tả |
|---|---|---|
| POST | `/api/auth/register` | Đăng ký tài khoản |
| POST | `/api/auth/login` | Đăng nhập, nhận JWT |

### Dashboard & Progress
| Method | Endpoint | Mô tả |
|---|---|---|
| GET | `/api/dashboard` | Thông tin tổng quan |
| GET | `/api/progress` | Tiến độ học của user hiện tại |
| PATCH | `/api/progress/{wordId}` | Cập nhật tiến độ sau khi học |

### Học từ tự do *(mới)*
| Method | Endpoint | Mô tả |
|---|---|---|
| GET | `/api/study/session?count=20` | Lấy N từ để học (không giới hạn) |
| GET | `/api/study/quiz?wordIds=1,2,3` | Quiz cho các từ vừa học |
| GET | `/api/study/review` | Quiz ôn tập từ đến hạn |
| GET | `/api/study/review/count` | Số từ cần ôn hôm nay |

### Bộ từ hàng ngày
| Method | Endpoint | Mô tả |
|---|---|---|
| GET | `/api/daily-word-sets/today` | Lấy (hoặc tạo) bộ từ hôm nay |
| PATCH | `/api/daily-word-sets/{id}/complete` | Đánh dấu hoàn thành |
| GET | `/api/quiz/today` | Quiz cho bộ từ hôm nay |

### Từ vựng
| Method | Endpoint | Mô tả |
|---|---|---|
| GET | `/api/words` | Danh sách từ (phân trang, lọc difficulty, lọc A-Z, tìm kiếm) |
| GET | `/api/words/stats` | Tổng số từ theo từng cấp độ |

---

## Tech Stack

| Layer | Công nghệ |
|---|---|
| Backend | Spring Boot 3.2, Spring Security, Spring Data JPA |
| Auth | JWT (jjwt 0.12.5), BCrypt |
| Database | SQL Server 2019+, Liquibase (SQL script format) |
| Frontend | Angular 17, Standalone Components, Signals |
| HTTP | HttpClient + Functional Interceptors |
| Styling | SCSS, CSS Variables, CSS 3D Transform (flashcard) |
| Dữ liệu | ~3.000 từ vựng, seed qua 50 file Liquibase changeset |
