@echo off
setlocal enabledelayedexpansion
set ROOT=%~dp0
set BACKEND=%ROOT%backend
set SERVICE=%ROOT%service
set WINSW_APP=%SERVICE%\VocabAppService.exe
set WINSW_TUNNEL=%SERVICE%\VocabTunnelService.exe

:: Check admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Run this script as Administrator.
    echo Right-click install-services.bat and select "Run as administrator"
    pause
    exit /b 1
)

echo ========================================
echo   Vocab App - Install Windows Services
echo ========================================
echo.

if not exist "%BACKEND%\target\vocab-backend-0.0.1-SNAPSHOT.jar" (
    echo [ERROR] JAR not found in %BACKEND%\target\
    echo Run build.bat first.
    pause
    exit /b 1
)

:: ----------------------------------------
:: Service 1: VocabApp (Spring Boot)
:: ----------------------------------------
echo.
echo [1/2] Installing VocabApp service...
"%WINSW_APP%" stop >nul 2>&1
"%WINSW_APP%" uninstall >nul 2>&1
"%WINSW_APP%" install
if %errorlevel% neq 0 ( echo [ERROR] Failed to install VocabApp service & pause & exit /b 1 )

:: ----------------------------------------
:: Service 2: VocabTunnel (cloudflared)
:: ----------------------------------------
echo.
echo [2/2] Installing VocabTunnel service...
"%WINSW_TUNNEL%" stop >nul 2>&1
"%WINSW_TUNNEL%" uninstall >nul 2>&1
"%WINSW_TUNNEL%" install
if %errorlevel% neq 0 ( echo [ERROR] Failed to install VocabTunnel service & pause & exit /b 1 )

:: Start services
echo.
echo Starting services...
"%WINSW_APP%" start
timeout /t 15 /nobreak > nul
"%WINSW_TUNNEL%" start

echo.
echo ========================================
echo   Done! Services installed and running.
echo.
echo   Manage services:
echo     Start:   "%WINSW_APP%" start   (or "%WINSW_TUNNEL%" start)
echo     Stop:    "%WINSW_APP%" stop    (or "%WINSW_TUNNEL%" stop)
echo     Restart: "%WINSW_APP%" restart
echo     Logs:    %SERVICE%\logs\
echo ========================================
pause
