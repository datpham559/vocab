# Deploy trên Windows

## Build

```bat
build.bat
```

Kết quả: `backend/target/vocab-backend-0.0.1-SNAPSHOT.jar`

---

## Chạy lần đầu (cài service)

Chạy với quyền **Administrator**:

```bat
install-services.bat
```

Cài 2 service tự động khởi động cùng Windows:
- **VocabApp** — Spring Boot chạy port `8899`
- **VocabTunnel** — Cloudflare tunnel ra internet

---

## Cập nhật khi có code mới

Chạy với quyền **Administrator**:

```bat
deploy.bat
```

Script tự build lại và restart service.

---

## Quản lý service

```bat
net start VocabApp
net stop VocabApp
nssm restart VocabApp
```

## Xem log

```bat
powershell Get-Content logs\backend.log -Wait -Tail 50
```
