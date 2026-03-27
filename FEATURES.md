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

### 3. Học từ vựng tự do — `/study`

Học từ không giới hạn số lượng, không bị ràng buộc bộ từ hàng ngày.

**Luồng học:**

```
Chọn số từ → Flashcard → Quiz gõ từ → Kết quả
```

| Bước | Mô tả |
|---|---|
| Chọn số từ | 10 / 20 / 50 / 100 / 200 từ — người dùng tự quyết |
| Flashcard | Mặt trước: từ tiếng Anh + phiên âm; mặt sau: nghĩa tiếng Việt + ví dụ. Nút Đã nhớ / Chưa nhớ **luôn hiển thị** (không cần lật trước) |
| Quiz gõ từ | Hiển thị nghĩa tiếng Việt → người dùng **gõ từ tiếng Anh** |
| Ô gợi ý từ | Hiển thị số ô bằng số chữ cái, chữ cái đầu được tiết lộ |
| Kết quả | Thống kê số từ nhớ khi học flashcard + điểm % quiz |

**Logic chọn từ:**
1. Ưu tiên 1: Từ đang ở LEARNING / REVIEW và đến hạn ôn hôm nay
2. Ưu tiên 2: Từ chưa từng gặp (chưa có trong `user_word_progress`)

---

### 4. Ôn tập — `/review`

Ôn lại toàn bộ từ đã học theo vòng lặp — không giới hạn trong ngày.

| Tính năng | Mô tả |
|---|---|
| Tổng từ đã học | Hiển thị tổng số từ đã từng học (≠ NEW) |
| Chọn số từ/phiên | 10 / 20 / 30 / 50 từ mỗi phiên |
| Chu kỳ ôn | Mỗi lần ôn lấy các từ **lâu nhất chưa được ôn** (oldest `last_reviewed` first) — hết 1 vòng thì bắt đầu lại |
| Chế độ thông thường | Cho từ tiếng Anh → chọn nghĩa tiếng Việt (4 lựa chọn) |
| Chế độ nâng cao | Cho nghĩa tiếng Việt → **gõ từ tiếng Anh**; mỗi lần sai tiết lộ thêm 1 gợi ý; có nút Bỏ qua |
| Ô gợi ý (nâng cao) | Sau lần sai đầu: hiện các ô chữ cái, lần lượt tiết lộ thêm theo số lần sai |
| Phản hồi trực tiếp | Highlight đáp án đúng/sai ngay sau khi chọn/gõ |
| Kết quả | Điểm %, thông điệp động lực theo kết quả |
| Badge trên navbar | Số từ đã học hiển thị trên menu điều hướng |

---

### 5. Kiểm tra trình độ — `/exam`

Đánh giá trình độ CEFR (A1 → C2) thông qua bài kiểm tra từ vựng.

| Tính năng | Mô tả |
|---|---|
| Chọn số câu | 30 / 40 / 50 / 60 câu |
| Chế độ chọn đáp án | 4 lựa chọn — chọn nghĩa tiếng Việt đúng |
| Chế độ gõ từ | Hiển thị nghĩa tiếng Việt → gõ từ tiếng Anh |
| Chế độ hỗn hợp | Ngẫu nhiên xen kẽ cả 2 dạng câu hỏi |
| Ô gợi ý từ | Ở dạng gõ: hiện số ô + chữ cái đầu |
| Đồng hồ đếm ngược | 15 giây / câu, hiển thị thanh timer |
| Phân bổ câu hỏi | 40% Beginner + 40% Intermediate + 20% Advanced |
| Loại từ (part of speech) | Hiển thị loại từ trong câu hỏi |
| Nhiễu cùng loại từ | Đáp án nhiễu được chọn cùng `part_of_speech` — ngăn bypass bằng nhận diện loại từ |
| Thuật toán CEFR | Gated algorithm: phải qua được cấp thấp mới đạt cấp cao |
| Kết quả chi tiết | Điểm từng cấp độ + xếp loại CEFR tổng thể |

**Thuật toán CEFR:**
```
A ≥ 90% + I ≥ 60% + B ≥ 60% → C2
A ≥ 70% + I ≥ 60% + B ≥ 60% → C1
I ≥ 65% + B ≥ 50%             → B2
I ≥ 40% hoặc B ≥ 70%          → B1
B ≥ 50%                        → A2
Còn lại                        → A1
```

---

### 6. Phòng Quiz nhiều người — `/room`

Thi đấu quiz realtime với nhiều người chơi, không cần WebSocket.

**Luồng:**
```
Tạo phòng / Nhập mã → Chờ đủ người → Host bắt đầu → Quiz → Bảng xếp hạng
```

| Tính năng | Mô tả |
|---|---|
| Tạo phòng | Chọn số câu (10/20/30), nhận mã phòng 6 ký tự |
| Vào phòng | Nhập mã phòng để tham gia |
| Chờ phòng | Danh sách người tham gia realtime, host thấy nút Bắt đầu |
| Quiz multiplayer | 4 lựa chọn, đồng hồ 15 giây/câu |
| Phím tắt | `1`–`4` để chọn đáp án nhanh |
| Thang điểm tốc độ | Tối đa **1000 điểm**/câu — trả lời càng nhanh càng nhiều điểm (min 500 nếu đúng, 0 nếu sai) |
| Điểm vừa kiếm | Hiện badge `+750 điểm` hoặc `Sai rồi` sau mỗi câu |
| Bảng điểm live | Cập nhật realtime sau mỗi câu, sắp xếp theo điểm |
| Kết quả cuối | Leaderboard với huy chương 🥇🥈🥉, tô sáng vị trí của mình |
| Tự dọn phòng | Phòng tự xóa sau 2 giờ không hoạt động |
| Polling | Frontend poll mỗi 1 giây — không cần WebSocket |

---

### 7. Bộ từ hàng ngày (Daily Word Set)

- Mỗi ngày hệ thống **tự động tạo 1 bộ 10 từ** cho mỗi người dùng
- Logic chọn từ theo thứ tự ưu tiên:
  1. Từ đang LEARNING / REVIEW và đến hạn ôn (`next_review ≤ hôm nay`)
  2. Từ chưa từng gặp (NEW) — random bằng `NEWID()`
- Bộ từ được tạo **một lần duy nhất mỗi ngày** — truy cập lại vẫn là bộ cũ
- Hoàn thành bộ từ → cập nhật **streak**

---

### 8. Flashcard (Thẻ lật)

| Bước | Mô tả |
|---|---|
| Mặt trước | Từ tiếng Anh + phiên âm + loại từ + nút phát âm 🔊 |
| Lật thẻ | Animation 3D → nghĩa tiếng Việt + câu ví dụ + dịch |
| Đánh giá | Đã nhớ ✓ / Chưa nhớ ✗ — **không cần lật thẻ trước** |
| Thanh tiến trình | Hiển thị đang ở từ thứ mấy / tổng số từ |

---

### 9. Quiz (Trắc nghiệm)

| Tính năng | Mô tả |
|---|---|
| Dạng câu hỏi | Cho từ tiếng Anh → chọn nghĩa tiếng Việt đúng |
| 4 lựa chọn | 1 đáp án đúng + 3 từ nhiễu **cùng loại từ** (nếu có), fallback cùng độ khó |
| Loại từ | Hiển thị `part of speech` trong câu hỏi |
| Phím tắt | `1`–`4` chọn đáp án |
| Phản hồi ngay | Đáp án đúng highlight xanh, sai highlight đỏ |
| Kết quả | Điểm số và phần trăm |

---

### 10. Hệ thống Spaced Repetition

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

### 11. Kho từ vựng — `/words`

| Tính năng | Mô tả |
|---|---|
| Tổng số từ | Hiển thị tổng số từ trong hệ thống kèm số theo từng cấp độ |
| Tìm kiếm | Tìm theo từ tiếng Anh hoặc nghĩa tiếng Việt |
| Lọc theo cấp độ | Tất cả / Cơ bản / Trung cấp / Nâng cao |
| Lọc A-Z | 26 nút chữ cái — click để lọc từ bắt đầu bằng chữ cái đó |
| Phân trang | Chọn số từ mỗi trang: 10 / 20 / 50 / 100 |
| Xem chi tiết | Click từ → mở rộng xem loại từ, chủ đề, ví dụ |
| Dữ liệu | ~3.000 từ vựng tiếng Anh phổ biến, chia 3 cấp độ |

---

### 12. Học theo chủ đề — `/topics`

| Tính năng | Mô tả |
|---|---|
| Danh sách chủ đề | Hiển thị tất cả chủ đề có trong hệ thống kèm số từ mỗi chủ đề |
| Học theo chủ đề | Chọn chủ đề → vào phiên học chỉ gồm từ thuộc chủ đề đó |

---

### 13. Quản trị — `/admin`

Chỉ dành cho tài khoản có role ADMIN.

| Tính năng | Mô tả |
|---|---|
| Danh sách người dùng | Xem toàn bộ tài khoản, thống kê streak và số từ đã học |
| Thêm từ vựng | Nhập tay hoặc tra từ qua Gemini AI để tự điền thông tin |
| Quản lý từ | Xem, sửa, xóa từ trong kho |

---

### 14. Tiện ích

| Tính năng | Mô tả |
|---|---|
| Phát âm 🔊 | Web Speech API phát âm từ tiếng Anh — có ở flashcard, quiz, review, phòng quiz |
| Phím tắt | Bật/tắt gợi ý phím tắt qua nút ⌨️ trên navbar |
| Gợi ý phím tắt | Hiện hint `1–4`, `Enter`, `Esc` tùy ngữ cảnh trong từng màn hình |

---

## Luồng sử dụng điển hình

### Học từ mới
```
Dashboard → Học từ (/study)
  → Chọn số từ (vd: 20)
  → Flashcard 20 từ
  → Quiz gõ từ 20 câu
  → Kết quả
```

### Ôn tập
```
Navbar → Ôn tập (/review)
  → Xem tổng số từ đã học
  → Chọn số từ/phiên + chế độ (thường / nâng cao)
  → Quiz → Kết quả
```

### Thi đấu nhiều người
```
Navbar → Phòng Quiz (/room)
  → Tạo phòng (chọn số câu) → Chia sẻ mã
  → Các người chơi nhập mã vào phòng
  → Host bấm Bắt đầu
  → Quiz 15s/câu, chấm điểm tốc độ
  → Bảng xếp hạng cuối
```

### Kiểm tra trình độ
```
Navbar → Kiểm tra trình độ (/exam)
  → Chọn số câu + chế độ
  → Làm bài (có đồng hồ)
  → Xem kết quả CEFR
```

---

## Cấu trúc dữ liệu

```
users                    — tài khoản, streak, last_study_date, role
words                    — kho ~3.000 từ vựng (word, meaning, pos, category, difficulty)
user_word_progress       — tiến độ của từng người với từng từ (status, next_review, last_reviewed)
daily_word_sets          — bộ 10 từ mỗi ngày của mỗi người
daily_word_set_words     — quan hệ N-N giữa bộ từ và từ vựng
[in-memory]              — active_rooms: phòng quiz đang hoạt động (ConcurrentHashMap)
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

### Học từ tự do
| Method | Endpoint | Mô tả |
|---|---|---|
| GET | `/api/study/session?count=20` | Lấy N từ để học |
| GET | `/api/study/quiz?wordIds=1,2,3` | Quiz cho các từ vừa học |
| GET | `/api/study/review?count=20` | Quiz ôn tập (cycle-based) |
| GET | `/api/study/review/count` | Tổng số từ đã học |
| GET | `/api/study/categories` | Danh sách chủ đề kèm số từ |
| GET | `/api/study/session/category?category=X&count=20` | Học từ theo chủ đề |

### Bộ từ hàng ngày
| Method | Endpoint | Mô tả |
|---|---|---|
| GET | `/api/daily-word-sets/today` | Lấy (hoặc tạo) bộ từ hôm nay |
| PATCH | `/api/daily-word-sets/{id}/complete` | Đánh dấu hoàn thành |
| GET | `/api/quiz/today` | Quiz cho bộ từ hôm nay |

### Từ vựng
| Method | Endpoint | Mô tả |
|---|---|---|
| GET | `/api/words` | Danh sách từ (phân trang, lọc, tìm kiếm) |
| GET | `/api/words/stats` | Tổng số từ theo từng cấp độ |
| GET | `/api/words/lookup?word=X` | Tra từ qua Gemini AI (admin) |

### Kiểm tra trình độ
| Method | Endpoint | Mô tả |
|---|---|---|
| GET | `/api/exam/questions?count=40` | Lấy bộ câu hỏi kiểm tra |

### Phòng Quiz
| Method | Endpoint | Mô tả |
|---|---|---|
| POST | `/api/room` | Tạo phòng mới |
| POST | `/api/room/{code}/join` | Vào phòng |
| POST | `/api/room/{code}/start` | Bắt đầu game (chỉ host) |
| POST | `/api/room/{code}/answer` | Gửi đáp án |
| GET | `/api/room/{code}/state` | Lấy trạng thái phòng (polling) |

### Admin
| Method | Endpoint | Mô tả |
|---|---|---|
| GET | `/api/admin/users` | Danh sách người dùng |
| POST | `/api/admin/words` | Thêm từ mới |
| DELETE | `/api/admin/words/{id}` | Xóa từ |

---

## Tech Stack

| Layer | Công nghệ |
|---|---|
| Backend | Spring Boot 3.2, Spring Security, Spring Data JPA |
| Auth | JWT (jjwt 0.12.5), BCrypt |
| Database | SQL Server 2019+, Liquibase (SQL script format) |
| In-memory state | ConcurrentHashMap, ScheduledExecutorService (phòng quiz) |
| AI | Google Gemini API (tra từ tự động) |
| Frontend | Angular 17, Standalone Components, Signals |
| HTTP | HttpClient + Functional Interceptors |
| Realtime | Polling (interval + switchMap) — không dùng WebSocket |
| Styling | SCSS, CSS Variables, CSS 3D Transform (flashcard) |
| Dữ liệu | ~3.000 từ vựng, seed qua 50+ file Liquibase changeset |
