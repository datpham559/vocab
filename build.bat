@echo off
setlocal enabledelayedexpansion
set ROOT=%~dp0
set FRONTEND=%ROOT%frontend
set BACKEND=%ROOT%backend
set STATIC=%BACKEND%\src\main\resources\static
set WINSW=%ROOT%service\VocabAppService.exe
set JAR=%BACKEND%\target\vocab-backend-0.0.1-SNAPSHOT.jar

echo ========================================
echo   Vocab App - Build
echo ========================================
echo.

:: Auto-detect whether VocabApp is already installed as a service:
:: - Installed  -> this is a redeploy: stop it, build, start it again.
:: - Not installed -> first build: just produce the JAR (run install-services.bat after).
sc query VocabApp >nul 2>&1
set SERVICE_EXISTS=0
if %errorlevel% equ 0 set SERVICE_EXISTS=1

if %SERVICE_EXISTS% equ 1 (
    net session >nul 2>&1
    if !errorlevel! neq 0 (
        echo [ERROR] VocabApp service is already installed - run this as Administrator to redeploy.
        echo Right-click build.bat and select "Run as administrator"
        pause & exit /b 1
    )
)

echo [1/5] Building frontend...
cd /d "%FRONTEND%"
call npm install --silent
if %errorlevel% neq 0 ( echo [ERROR] npm install failed & pause & exit /b 1 )
call ng build --configuration production
if %errorlevel% neq 0 ( echo [ERROR] Angular build failed & pause & exit /b 1 )

echo [2/5] Copying frontend to backend static...
if exist "%STATIC%" rmdir /s /q "%STATIC%"
mkdir "%STATIC%"
xcopy /e /i /q "%FRONTEND%\dist\vocab-frontend\browser\*" "%STATIC%\" >nul 2>&1
if %errorlevel% neq 0 (
    xcopy /e /i /q "%FRONTEND%\dist\vocab-frontend\*" "%STATIC%\" >nul 2>&1
)

if %SERVICE_EXISTS% equ 1 (
    echo [3/5] Stopping VocabApp service...
    "%WINSW%" stop >nul 2>&1
    timeout /t 3 /nobreak >nul
    taskkill /F /IM java.exe >nul 2>&1
    timeout /t 3 /nobreak >nul
    if exist "%JAR%" del /f /q "%JAR%" >nul 2>&1
    if exist "%JAR%.original" del /f /q "%JAR%.original" >nul 2>&1
) else (
    echo [3/5] VocabApp service not installed yet - skipping stop.
)

echo [4/5] Building backend...
cd /d "%BACKEND%"
call mvn.cmd package -DskipTests -q
if %errorlevel% neq 0 ( echo [ERROR] Maven build failed & pause & exit /b 1 )

if %SERVICE_EXISTS% equ 1 (
    echo [5/5] Starting VocabApp service...
    "%WINSW%" start
    echo.
    timeout /t 8 /nobreak >nul
    sc query VocabApp | findstr STATE
) else (
    echo [5/5] Build done - VocabApp service not installed yet.
    echo   Run install-services.bat ^(as Administrator^) to install and start it.
)

echo.
echo ========================================
echo   Done!
for %%f in ("%BACKEND%\target\*.jar") do echo   JAR: %%f
echo ========================================
pause
