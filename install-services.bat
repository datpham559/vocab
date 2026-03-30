@echo off
setlocal enabledelayedexpansion
set ROOT=%~dp0
set BACKEND=%ROOT%backend

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

:: Install NSSM
where nssm >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Installing NSSM...
    winget install NSSM.NSSM --accept-source-agreements --accept-package-agreements
    :: Refresh PATH
    for /f "tokens=*" %%i in ('where /r "C:\ProgramData\chocolatey\bin" nssm.exe 2^>nul') do set NSSM=%%i
    if not defined NSSM (
        for /f "tokens=*" %%i in ('where /r "%LOCALAPPDATA%\Microsoft\WinGet" nssm.exe 2^>nul') do set NSSM=%%i
    )
) else (
    for /f "tokens=*" %%i in ('where nssm') do set NSSM=%%i
)

if not defined NSSM set NSSM=nssm
echo Using NSSM: %NSSM%

:: Find JAR file
set JAR=
for %%f in ("%BACKEND%\target\vocab-*.jar") do (
    if not "%%~nf"=="*" set JAR=%%f
)

if not defined JAR (
    echo [ERROR] JAR not found in %BACKEND%\target\
    echo Run build.bat first.
    pause
    exit /b 1
)
echo Found JAR: %JAR%

:: ----------------------------------------
:: Service 1: VocabApp (Spring Boot)
:: ----------------------------------------
echo.
echo [1/2] Installing VocabApp service...

%NSSM% stop VocabApp >nul 2>&1
%NSSM% remove VocabApp confirm >nul 2>&1

for /f "tokens=*" %%j in ('where java') do set JAVA=%%j
%NSSM% install VocabApp "!JAVA!"
%NSSM% set VocabApp AppParameters "-jar \"%JAR%\" --server.port=8899"
%NSSM% set VocabApp AppDirectory "%BACKEND%"
%NSSM% set VocabApp DisplayName "Vocab App - Backend"
%NSSM% set VocabApp Description "Spring Boot backend for Vocab learning app"
%NSSM% set VocabApp Start SERVICE_AUTO_START
%NSSM% set VocabApp AppStdout "%ROOT%logs\backend.log"
%NSSM% set VocabApp AppStderr "%ROOT%logs\backend-error.log"
%NSSM% set VocabApp AppRotateFiles 0

:: ----------------------------------------
:: Service 2: VocabTunnel (cloudflared)
:: ----------------------------------------
echo.
echo [2/2] Installing VocabTunnel service...

%NSSM% stop VocabTunnel >nul 2>&1
%NSSM% remove VocabTunnel confirm >nul 2>&1

%NSSM% install VocabTunnel cloudflared
%NSSM% set VocabTunnel AppParameters "tunnel --url http://localhost:8899"
%NSSM% set VocabTunnel DisplayName "Vocab App - Cloudflare Tunnel"
%NSSM% set VocabTunnel Description "Cloudflare tunnel for Vocab app"
%NSSM% set VocabTunnel Start SERVICE_AUTO_START
%NSSM% set VocabTunnel AppStdout "%ROOT%logs\tunnel.log"
%NSSM% set VocabTunnel AppStderr "%ROOT%logs\tunnel.log"
%NSSM% set VocabTunnel AppRotateFiles 1
%NSSM% set VocabTunnel AppDependencies VocabApp

:: Create logs folder
if not exist "%ROOT%logs" mkdir "%ROOT%logs"

:: Start services
echo.
echo Starting services...
net start VocabApp
timeout /t 15 /nobreak > nul
net start VocabTunnel

echo.
echo ========================================
echo   Done! Services installed and running.
echo.
echo   Manage services:
echo     Start:   net start VocabApp
echo     Stop:    net stop VocabApp
echo     Restart: nssm restart VocabApp
echo     Logs:    %ROOT%logs\
echo ========================================
pause
