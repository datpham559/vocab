@echo off
setlocal enabledelayedexpansion
set ROOT=%~dp0
set BACKEND=%ROOT%backend
set FRONTEND=%ROOT%frontend
set STATIC=%BACKEND%\src\main\resources\static
set NSSM=C:\Users\Admin\AppData\Local\Microsoft\WinGet\Packages\NSSM.NSSM_Microsoft.Winget.Source_8wekyb3d8bbwe\nssm-2.24-101-g897c7ad\win64\nssm.exe
set JAVA=C:\Program Files\Java\jdk-17.0.12\bin\java.exe
set JAR=%BACKEND%\target\vocab-backend-0.0.1-SNAPSHOT.jar

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Run as Administrator!
    echo Right-click deploy.bat and select "Run as administrator"
    pause & exit /b 1
)

echo ========================================
echo   Vocab App - Deploy
echo ========================================
echo.

echo [1/5] Stopping service...
net stop VocabApp >nul 2>&1
taskkill /F /IM java.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo [2/5] Building frontend...
cd /d "%FRONTEND%"
call npm install --silent
if %errorlevel% neq 0 ( echo [ERROR] npm install failed & pause & exit /b 1 )
call ng build --configuration production
if %errorlevel% neq 0 ( echo [ERROR] Angular build failed & pause & exit /b 1 )

echo [3/5] Copying frontend to backend...
if exist "%STATIC%" rmdir /s /q "%STATIC%"
mkdir "%STATIC%"
xcopy /e /i /q "%FRONTEND%\dist\vocab-frontend\browser\*" "%STATIC%\" >nul 2>&1
if %errorlevel% neq 0 (
    xcopy /e /i /q "%FRONTEND%\dist\vocab-frontend\*" "%STATIC%\" >nul 2>&1
)

echo [4/5] Building backend...
cd /d "%BACKEND%"
call mvn.cmd package -DskipTests -q
if %errorlevel% neq 0 ( echo [ERROR] Maven build failed & pause & exit /b 1 )

echo [5/5] Starting service...
net stop VocabApp >nul 2>&1
"%NSSM%" remove VocabApp confirm >nul 2>&1
"%NSSM%" install VocabApp "%JAVA%"
"%NSSM%" set VocabApp AppParameters "-jar \"%JAR%\" --server.port=8899"
"%NSSM%" set VocabApp AppDirectory "%BACKEND%"
"%NSSM%" set VocabApp DisplayName "Vocab App - Backend"
"%NSSM%" set VocabApp Start SERVICE_AUTO_START
"%NSSM%" set VocabApp AppStdout "%ROOT%logs\backend.log"
"%NSSM%" set VocabApp AppStderr "%ROOT%logs\backend-error.log"
"%NSSM%" set VocabApp AppRotateFiles 0
net start VocabApp

echo.
timeout /t 8 /nobreak >nul
sc query VocabApp | findstr STATE

echo.
echo ========================================
echo   Done! App is running on port 8899
echo ========================================
pause
