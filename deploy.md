# Build & Deploy trên Windows

## Kiến trúc

| Service (Windows) | Chạy gì | Port | Tự khởi động cùng Windows |
|---|---|---|---|
| **VocabApp** | Spring Boot (`vocab-backend-*.jar`) | `8899` | Có |
| **VocabTunnel** | `cloudflared tunnel` → expose VocabApp ra internet | — | Có (phụ thuộc VocabApp) |

Cả 2 service chạy qua **[WinSW](https://github.com/winsw/winsw)**, file nằm sẵn trong project — không cần cài NSSM hay công cụ wrapper nào ở ngoài:

```
service/
  VocabAppService.exe / .xml       ← config + wrapper cho backend
  VocabTunnelService.exe / .xml    ← config + wrapper cho cloudflared
  logs/                            ← log của WinSW (stdout/stderr), tự tạo khi service chạy
```

Đọc thẳng file `.xml` để biết chính xác service chạy lệnh gì (executable, arguments, working directory, restart policy...) — không cần mò trong file `.bat`.

---

## Yêu cầu

- **JDK 17** tại `C:\Program Files\Java\jdk-17.0.12` — đường dẫn này hardcode trong `service/VocabAppService.xml`. Nếu đổi vị trí/version JDK, sửa lại thẻ `<executable>` trong file đó.
- **Node.js + Angular CLI 17** — để build frontend (`build.bat` tự chạy `npm install` + `ng build`).
- **cloudflared** cài qua winget — chỉ cần cho VocabTunnel:
  ```bat
  winget install Cloudflare.cloudflared
  ```
  Đường dẫn mặc định `C:\Program Files (x86)\cloudflared\cloudflared.exe` cũng hardcode trong `service/VocabTunnelService.xml`.

---

## 1. Build (lần đầu, hoặc cập nhật code)

```bat
build.bat
```

Một file duy nhất cho cả build đầu tiên lẫn redeploy — script tự nhận biết **VocabApp** đã được cài làm service hay chưa (`sc query VocabApp`):

- **Chưa cài (lần đầu):** build Angular (production) → copy vào `backend/src/main/resources/static` → build JAR `backend/target/vocab-backend-0.0.1-SNAPSHOT.jar`. Không đụng service vì chưa có gì để dừng/khởi động lại.
- **Đã cài (redeploy):** build lại như trên, rồi tự dừng **VocabApp** trước khi build backend (tránh khoá file jar đang chạy) và khởi động lại sau khi build xong. Lúc này cần chạy với quyền **Administrator** (script tự kiểm tra và báo lỗi nếu thiếu).

Không đụng tới **VocabTunnel** trong cả 2 trường hợp — tunnel không phụ thuộc vào code, không cần restart khi build/deploy.

---

## 2. Cài service lần đầu

Sau khi `build.bat` đã tạo JAR, chạy với quyền **Administrator**:

```bat
install-services.bat
```

- Yêu cầu JAR đã build sẵn (chạy `build.bat` trước nếu chưa).
- Cài + start **VocabApp** và **VocabTunnel** qua WinSW.
- Idempotent: script tự `stop` → `uninstall` → `install` từng service theo tên trước khi cài lại — nếu máy đang có service cùng tên cài bằng công cụ khác (vd. NSSM từ bản cũ), nó sẽ tự dừng và gỡ đăng ký cũ rồi thay bằng WinSW, không cần thao tác tay riêng.

---

## 3. Cloudflare Tunnel

### Mặc định: quick tunnel (URL tạm)

`service/VocabTunnelService.xml` hiện dùng:

```
cloudflared tunnel --url http://localhost:8899
```

Đây là **quick tunnel** — sinh URL ngẫu nhiên dạng `https://xxxx.trycloudflare.com` **mỗi lần service khởi động lại** (reboot máy, service crash rồi tự restart, chạy lại `install-services.bat`...). Xem URL hiện tại:

```bat
powershell Get-Content service\logs\VocabTunnelService.out.log -Tail 20
```

(tìm dòng có `trycloudflare.com`)

### Khuyến nghị: tunnel với domain cố định

Vì app chạy dạng service 24/7, URL đổi liên tục mỗi lần restart sẽ làm hỏng mọi link đã chia sẻ trước đó. Nếu có domain riêng, nên set up **named tunnel** một lần:

1. Chạy `cloudflared-setup.bat` — đăng nhập Cloudflare (mở trình duyệt), tạo tunnel tên `vocab-app`, route DNS về domain của bạn, ghi config vào `%USERPROFILE%\.cloudflared\config.yml`.
2. Sửa `service/VocabTunnelService.xml`, đổi dòng `<arguments>` thành:
   ```xml
   <arguments>tunnel run vocab-app</arguments>
   ```
3. Cài lại service để áp dụng config mới:
   ```bat
   service\VocabTunnelService.exe stop
   service\VocabTunnelService.exe uninstall
   service\VocabTunnelService.exe install
   service\VocabTunnelService.exe start
   ```
   (hoặc chạy lại `install-services.bat`)

Sau bước này, URL public sẽ cố định theo domain đã route, không đổi qua các lần restart.

---

## 4. Quản lý service

```bat
service\VocabAppService.exe start
service\VocabAppService.exe stop
service\VocabAppService.exe restart

service\VocabTunnelService.exe start
service\VocabTunnelService.exe stop
service\VocabTunnelService.exe restart
```

Kiểm tra trạng thái / binary path đang đăng ký với Windows:

```bat
sc query VocabApp
sc qc VocabApp
```

## 5. Xem log

```bat
powershell Get-Content service\logs\VocabAppService.out.log -Wait -Tail 50
powershell Get-Content service\logs\VocabTunnelService.out.log -Wait -Tail 50
```

---

## 6. Xử lý sự cố

| Vấn đề | Nguyên nhân | Cách sửa |
|---|---|---|
| `install-services.bat` báo lỗi ngay từ đầu | Chưa chạy với quyền Administrator | Right-click → Run as administrator |
| `[ERROR] JAR not found` | Chưa build backend | Chạy `build.bat` trước |
| Service cài xong nhưng không start | JDK/cloudflared không đúng đường dẫn hardcode trong XML | Sửa `<executable>` trong `service/VocabAppService.xml` hoặc `VocabTunnelService.xml` cho khớp máy thật, rồi `stop`→`uninstall`→`install`→`start` lại |
| Port 8899 đã bị chiếm | Có tiến trình `java.exe` cũ chưa tắt hẳn | `taskkill /F /IM java.exe`, hoặc đổi `--server.port=` trong `VocabAppService.xml` |
| URL tunnel đổi liên tục | Đang dùng quick tunnel (mặc định) | Xem mục 3 — set up named tunnel với domain cố định |
| Muốn xem log lỗi lúc service không khởi động được (trước cả khi Spring Boot kịp log) | — | `service\logs\VocabAppService.err.log` hoặc `VocabAppService.wrapper.log` |
