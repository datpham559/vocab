# Hướng dẫn cài đặt & chạy VocabDaily

## Yêu cầu hệ thống

| Công cụ | Phiên bản |
|---|---|
| Java (JDK) | 17+ |
| Maven | 3.8+ |
| Node.js | 18+ |
| npm | 9+ |
| Angular CLI | 17+ |
| SQL Server | 2019+ (hoặc SQL Server Express) |

---

## 1. Cấu hình Database (SQL Server)

### 1.1 Tạo database

Mở SQL Server Management Studio (SSMS), đăng nhập bằng Windows Authentication, chạy:

```sql
CREATE DATABASE vocab_db;
```

### 1.2 Cấu hình kết nối — Windows Authentication

Dự án dùng **Windows Authentication** (không cần username/password).

Mở `backend/src/main/resources/application.yml`:

```yaml
spring:
  datasource:
    url: jdbc:sqlserver://localhost;databaseName=vocab_db;integratedSecurity=true;encrypt=false;trustServerCertificate=true
    driver-class-name: com.microsoft.sqlserver.jdbc.SQLServerDriver
```

> Không cần sửa gì nếu SQL Server đang chạy trên `localhost` và đã tạo database `vocab_db`.

### 1.3 Cài DLL cho Windows Authentication (bắt buộc)

Driver JDBC cần file native `.dll` để đọc Windows credential.

**Bước 1:** Tìm file DLL trong Maven cache:
```
C:\Users\<tên máy>\.m2\repository\com\microsoft\sqlserver\mssql-jdbc\
```
Vào thư mục version (vd: `12.6.1.jre11`), tìm file `mssql-jdbc_auth-xx.x64.dll`.

Nếu không thấy, tải bộ driver đầy đủ tại:
```
https://learn.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server
```
Giải nén → lấy file `mssql-jdbc_auth-12.x.x.x64.dll`.

**Bước 2:** Copy DLL vào thư mục `bin` của JDK đang dùng:
```
C:\Program Files\Java\jdk-17\bin\
```

**Bước 3:** Khởi động lại terminal rồi chạy backend.

### 1.4 Liquibase tự động chạy migration

Khi khởi động backend lần đầu, Liquibase sẽ tự động:
- Tạo toàn bộ bảng (`users`, `words`, `user_word_progress`, `daily_word_sets`, `daily_word_set_words`)
- Seed sẵn **~3.000 từ vựng** (50 file changeset, trải đều 3 cấp độ)

Bạn **không cần** chạy SQL thủ công.

---

## 2. Chạy Backend (Spring Boot)

### Cách 1: Dùng Maven (khuyên dùng)

```bash
cd backend
mvn spring-boot:run
```

### Cách 2: Build JAR rồi chạy

```bash
cd backend
mvn clean package -DskipTests
java -jar target/vocab-backend-0.0.1-SNAPSHOT.jar
```

### Cách 3: Mở bằng IntelliJ IDEA / VS Code

- Import project Maven
- Chạy class `VocabApplication.java`

### Kiểm tra backend đang chạy

```
GET http://localhost:8080/api/words
```

Trả về JSON danh sách từ vựng → backend OK.

---

## 3. Chạy Frontend (Angular 17)

### 3.1 Cài Angular CLI 17

```bash
npm install -g @angular/cli@17
```

### 3.2 Cài dependencies

```bash
cd frontend
npm install
```

### 3.3 Chạy development server

```bash
ng serve
```

hoặc:

```bash
npm start
```

Truy cập: **http://localhost:4200**

### 3.4 Build production

```bash
ng build --configuration production
```

Output tại `frontend/dist/vocab-frontend/`.

---

## 4. Thứ tự khởi động

```
1. Khởi động SQL Server
2. Chạy Backend  →  http://localhost:8080
3. Chạy Frontend →  http://localhost:4200
```

---

## 5. Cấu hình nâng cao

### Đổi JWT secret

Mở `backend/src/main/resources/application.yml`:

```yaml
app:
  jwt:
    secret: 404E635266556A586E3272...   # chuỗi hex 64 ký tự bất kỳ
    expiration: 86400000                 # thời gian hết hạn token (ms), mặc định 24h
```

### Đổi số từ trong bộ từ hàng ngày

Mở `backend/src/main/java/com/vocab/service/DailyWordSetService.java`:

```java
private static final int DAILY_WORD_COUNT = 10;  // đổi số này
```

> Phiên học tự do (`/study`) không bị giới hạn — người dùng tự chọn số từ.

### Đổi API URL cho frontend

Mở `frontend/src/environments/environment.ts`:

```typescript
export const environment = {
  production: false,
  apiUrl: 'http://localhost:8080/api'  // đổi nếu backend chạy port khác
};
```

### Cho phép CORS từ domain khác

Mở `backend/src/main/java/com/vocab/config/CorsConfig.java`:

```java
config.setAllowedOrigins(List.of("http://localhost:4200", "https://yourdomain.com"));
```

---

## 6. Tài khoản test nhanh

Vào **http://localhost:4200/auth/register** để tạo tài khoản mới.

Không có tài khoản mặc định — bắt buộc đăng ký trước khi sử dụng.

---

## 7. Điều hướng chính

| URL | Tính năng |
|---|---|
| `/dashboard` | Trang chủ, thống kê tổng quan |
| `/study` | Học từ mới (chọn số lượng, không giới hạn) |
| `/review` | Ôn tập từ đến hạn (spaced repetition) |
| `/words` | Kho từ vựng, tìm kiếm, lọc A-Z |
| `/flashcard` | Bộ từ hàng ngày — flashcard |
| `/quiz` | Bộ từ hàng ngày — quiz |

---

## 8. Xử lý lỗi thường gặp

| Lỗi | Nguyên nhân | Cách sửa |
|---|---|---|
| `This driver is not configured for integrated authentication` | Thiếu file DLL Windows Auth | Xem lại mục 1.3 — copy DLL vào thư mục `bin` của JDK |
| `Cannot open database vocab_db` | Chưa tạo database | Chạy `CREATE DATABASE vocab_db` trong SSMS |
| `Connection refused` | SQL Server chưa chạy | Kiểm tra SQL Server service trong Windows Services |
| `Port 8080 already in use` | Có app khác chiếm port | Đổi `server.port` trong `application.yml` |
| `Port 4200 already in use` | Có Angular app khác đang chạy | Chạy `ng serve --port 4201` |
| `CORS error` trên browser | Frontend và backend khác origin | Kiểm tra `CorsConfig.java`, đảm bảo URL frontend có trong allowed origins |
| Liquibase `checksum mismatch` | File SQL changelog bị sửa sau khi đã chạy | Không sửa nội dung changelog đã chạy — thêm changeset mới thay thế |
| `/study` trả về 0 từ | Chưa có từ nào trong DB | Kiểm tra Liquibase đã seed xong chưa — xem log backend khi khởi động |
