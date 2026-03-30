@echo off
setlocal enabledelayedexpansion
echo ========================================
echo   Cloudflare Tunnel - First Time Setup
echo ========================================
echo.

where cloudflared >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Installing cloudflared...
    winget install Cloudflare.cloudflared
    echo.
    echo Restart this script after installation completes.
    pause
    exit /b 0
)

echo [STEP 1] Login to Cloudflare
echo Your browser will open — log in and authorize.
echo.
cloudflared tunnel login
if %errorlevel% neq 0 (
    echo [ERROR] Login failed.
    pause
    exit /b 1
)

echo.
echo [STEP 2] Creating tunnel "vocab-app"...
cloudflared tunnel create vocab-app
if %errorlevel% neq 0 (
    echo [ERROR] Tunnel creation failed (may already exist — that's OK).
)

echo.
echo [STEP 3] Getting tunnel UUID...
for /f "tokens=1" %%i in ('cloudflared tunnel list ^| findstr "vocab-app"') do set TUNNEL_ID=%%i
echo Tunnel ID: %TUNNEL_ID%

echo.
set /p DOMAIN="[STEP 4] Enter your domain (e.g. vocab.yourdomain.com): "

echo.
echo [STEP 5] Routing DNS for %DOMAIN%...
cloudflared tunnel route dns vocab-app %DOMAIN%

echo.
echo [STEP 6] Writing config file...

set CONFIG_DIR=%USERPROFILE%\.cloudflared
if not exist "%CONFIG_DIR%" mkdir "%CONFIG_DIR%"

(
echo tunnel: %TUNNEL_ID%
echo credentials-file: %CONFIG_DIR%\%TUNNEL_ID%.json
echo.
echo ingress:
echo   - hostname: %DOMAIN%
echo     service: http://localhost:4200
echo   - service: http_status:404
) > "%CONFIG_DIR%\config.yml"

echo.
echo ========================================
echo   Setup complete!
echo   Config saved to: %CONFIG_DIR%\config.yml
echo.
echo   Run tunnel.bat to start.
echo ========================================
pause
