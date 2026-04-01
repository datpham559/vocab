# Vocab App — Hướng dẫn Deploy

## Kiến trúc tổng quan

```
[Người dùng] → [Cloudflare Tunnel] → [Spring Boot :8899]
                                              │
                                    ┌─────────┴──────────┐
                                    │  /api/**  → REST    │
                                    │  /ws/**   → WS      │
                                    │  /**      → Angular │
                                    │           (static)  │
                                    └────────────────────-┘
                                              │
                                        [SQL Server]
```

Angular được build thành file tĩnh rồi nhúng thẳng vào JAR của Spring Boot (`resources/static`). Kết quả chỉ có **1 file JAR duy nhất** để chạy.

---

## Yêu cầu môi trường

| Phần mềm | Phiên bản | Ghi chú |
|----------|-----------|---------|
| Java JDK | 17+ | Đường dẫn: `C:\Program Files\Java\jdk-17.x.x` |
| Node.js | 18+ | Kèm npm |
| Angular CLI | 17+ | `npm install -g @angular/cli` |
| Maven | 3.8+ | Hoặc dùng `mvnw` trong thư mục backend |
| SQL Server | 2019+ | Database: `vocab_db`, user: `sa` |
| NSSM | 2.24+ | Quản lý Windows Service |
| cloudflared | mới nhất | Cloudflare Tunnel ra internet |

---

## Cấu trúc thư mục

```
vocab/
├── backend/                  # Spring Boot
│   ├── src/main/resources/
│   │   ├── application.yml   # Config chính
│   │   ├── static/           # Angular build copy vào đây (auto)
│   │   └── db/changelog/     # Liquibase SQL migrations
│   └── target/
│       └── vocab-backend-0.0.1-SNAPSHOT.jar
├── frontend/                 # Angular
│   └── dist/vocab-frontend/browser/  # Output sau khi build
├── logs/
│   ├── backend.log
│   └── tunnel.log
├── build.bat                 # Chỉ build (không deploy)
├── deploy.bat                # Build + restart service (cần Admin)
├── install-services.bat      # Lần đầu cài NSSM service
└── reinstall-service.bat     # Cài lại service nếu lỗi
```

---

## Lần đầu cài đặt (First-time setup)

### 1. Tạo database SQL Server
```sql
CREATE DATABASE vocab_db;
```

### 2. Cấu hình `application.yml`
```yaml
spring:
  datasource:
    url: jdbc:sqlserver://localhost;databaseName=vocab_db;encrypt=false;trustServerCertificate=true
    username: sa
    password: "mật_khẩu_của_bạn"
  liquibase:
    enabled: true   # ← bật lên để chạy migration lần đầu
```
> Sau khi chạy lần đầu xong, có thể để `enabled: false` vì Liquibase đã lưu checksum.

### 3. Build lần đầu
```bat
build.bat
```

### 4. Cài Windows Services (chạy với quyền Admin)
```bat
install-services.bat
```
Script này cài:
- **VocabApp** — Spring Boot chạy port `8899`, tự start khi boot
- **VocabTunnel** — cloudflared tunnel ra internet, phụ thuộc VocabApp

---

## Deploy khi có code mới

### Cách nhanh (1 lệnh, cần Admin)
```bat
deploy.bat
```
Script tự động:
1. Stop service VocabApp
2. Build Angular production
3. Copy Angular vào `backend/src/main/resources/static/`
4. Build Spring Boot JAR (`mvn package -DskipTests`)
5. Restart service VocabApp

### Cách thủ công (từng bước)

**Bước 1 — Build frontend:**
```bat
cd frontend
npm install
ng build --configuration production
```

**Bước 2 — Copy sang backend:**
```bat
xcopy /e /i /q frontend\dist\vocab-frontend\browser\* backend\src\main\resources\static\
```

**Bước 3 — Build backend JAR:**
```bat
cd backend
mvn package -DskipTests
```

**Bước 4 — Restart service (Admin):**
```bat
net stop VocabApp
net start VocabApp
```

---

## Chạy local để dev

**Terminal 1 — Backend:**
```bat
cd backend
mvn spring-boot:run
```
Chạy trên port `8080`. Liquibase tự migrate nếu `enabled: true`.

**Terminal 2 — Frontend:**
```bat
cd frontend
ng serve
```
Chạy trên port `4200`. Proxy tự forward `/api` và `/ws` sang port `8080`.

Nếu backend đang chạy service ở port `8899`:
```bat
cd frontend
set BACKEND_PORT=8899 && ng serve
```

---

## Quản lý service

```bat
# Xem trạng thái
sc query VocabApp
sc query VocabTunnel

# Start / Stop / Restart
net start VocabApp
net stop VocabApp
nssm restart VocabApp

# Xem logs realtime
powershell Get-Content logs\backend.log -Wait -Tail 50
powershell Get-Content logs\tunnel.log -Wait -Tail 20

# Cài lại service nếu bị lỗi
reinstall-service.bat    # chạy với Admin
```

---

## Liquibase — Quản lý migration

Mỗi lần thêm bảng / thêm từ vựng cần:

1. Tạo file SQL mới trong `backend/src/main/resources/db/changelog/`:
```
060-seed-words-batch52.sql   ← số thứ tự tăng dần
```

2. Thêm vào `db.changelog-master.xml`:
```xml
<include file="db/changelog/060-seed-words-batch52.sql"/>
```

3. Bật `liquibase.enabled: true` trong `application.yml`, restart → tự migrate.

> Liquibase lưu checksum trong bảng `DATABASECHANGELOG`. Changeset đã chạy sẽ **không chạy lại**.

---

## Biến môi trường

| Biến | Mặc định | Dùng khi |
|------|---------|---------|
| `BACKEND_PORT` | `8080` | `ng serve` trỏ sang port khác |
| `GEMINI_API_KEY` | _(trống)_ | Tính năng tra từ điển tự động |

---

## Troubleshooting

| Triệu chứng | Nguyên nhân | Cách xử lý |
|-------------|------------|------------|
| Service không start | JAR chưa build | Chạy `build.bat` trước |
| `global is not defined` (browser) | SockJS polyfill thiếu | Đã fix trong `main.ts` |
| WebSocket lỗi | Proxy sai port | Kiểm tra `BACKEND_PORT` hoặc `proxy.conf.js` |
| Liquibase lỗi checksum | Sửa file changeset đã chạy | Không được sửa — tạo file mới |
| Angular 404 khi F5 | Spring Boot chưa forward | Đã cấu hình trong `WebMvcConfig` |
| Port 8899 bị dùng | Process khác | `netstat -ano | findstr 8899` rồi kill |
