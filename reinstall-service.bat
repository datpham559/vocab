@echo off
setlocal enabledelayedexpansion
set ROOT=%~dp0
set BACKEND=%ROOT%backend
set NSSM=C:\Users\Admin\AppData\Local\Microsoft\WinGet\Packages\NSSM.NSSM_Microsoft.Winget.Source_8wekyb3d8bbwe\nssm-2.24-101-g897c7ad\win64\nssm.exe
set JAVA=C:\Program Files\Java\jdk-17.0.12\bin\java.exe
set JAR=%BACKEND%\target\vocab-backend-0.0.1-SNAPSHOT.jar

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Run as Administrator!
    pause & exit /b 1
)

if not exist "%LOGS_DIR%" set LOGS_DIR=%ROOT%logs
if not exist "%LOGS_DIR%" mkdir "%LOGS_DIR%"

echo Removing old service...
net stop VocabApp >nul 2>&1
"%NSSM%" remove VocabApp confirm >nul 2>&1

echo Installing VocabApp service...
echo   Java: %JAVA%
echo   JAR:  %JAR%

"%NSSM%" install VocabApp "%JAVA%"
"%NSSM%" set VocabApp AppParameters "-jar \"%JAR%\" --server.port=8899"
"%NSSM%" set VocabApp AppDirectory "%BACKEND%"
"%NSSM%" set VocabApp DisplayName "Vocab App - Backend"
"%NSSM%" set VocabApp Start SERVICE_AUTO_START
"%NSSM%" set VocabApp AppStdout "%ROOT%logs\backend.log"
"%NSSM%" set VocabApp AppStderr "%ROOT%logs\backend-error.log"
"%NSSM%" set VocabApp AppRotateFiles 0

echo.
echo Updating VocabTunnel to port 8899...
net stop VocabTunnel >nul 2>&1
"%NSSM%" set VocabTunnel AppParameters "tunnel --url http://localhost:8899"
net start VocabTunnel >nul 2>&1

echo.
echo Starting VocabApp service...
net start VocabApp

echo.
timeout /t 5 /nobreak >nul
sc query VocabApp | findstr STATE
pause
