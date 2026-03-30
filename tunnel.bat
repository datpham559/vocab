@echo off
echo ========================================
echo   Vocab App - Start with Tunnel
echo ========================================
echo.

where cloudflared >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] cloudflared not found.
    echo Run cloudflared-setup.bat first.
    pause
    exit /b 1
)

echo [1/3] Starting Spring Boot backend...
start "Vocab Backend" cmd /k "cd /d %~dp0backend && mvnw.cmd spring-boot:run"

echo [2/3] Waiting 20s for backend to start...
timeout /t 20 /nobreak > nul

echo [3/3] Starting Angular frontend (with API proxy)...
start "Vocab Frontend" cmd /k "cd /d %~dp0frontend && ng serve --proxy-config proxy.conf.json --allowed-hosts all"

echo Waiting 15s for frontend to start...
timeout /t 15 /nobreak > nul

echo.
echo ========================================

REM Use named tunnel if config exists, otherwise quick tunnel
if exist "%USERPROFILE%\.cloudflared\config.yml" (
    echo   Starting named tunnel (permanent URL^)...
    echo ========================================
    echo.
    cloudflared tunnel run vocab-app
) else (
    echo   No config found — using quick tunnel (temporary URL^)
    echo   Run cloudflared-setup.bat for a permanent URL.
    echo ========================================
    echo.
    cloudflared tunnel --url http://localhost:4200
)
