@echo off
setlocal
set ROOT=%~dp0
set FRONTEND=%ROOT%frontend
set BACKEND=%ROOT%backend
set STATIC=%BACKEND%\src\main\resources\static

echo ========================================
echo   Vocab App - Full Build
echo ========================================
echo.

echo [1/4] Installing frontend dependencies...
cd /d "%FRONTEND%"
call npm install
if %errorlevel% neq 0 ( echo [ERROR] npm install failed & pause & exit /b 1 )

echo.
echo [2/4] Building Angular (production)...
call ng build --configuration production
if %errorlevel% neq 0 ( echo [ERROR] Angular build failed & pause & exit /b 1 )

echo.
echo [3/4] Copying Angular build to Spring Boot static folder...
if exist "%STATIC%" rmdir /s /q "%STATIC%"
mkdir "%STATIC%"
xcopy /e /i /q "%FRONTEND%\dist\vocab-frontend\browser\*" "%STATIC%\"
if %errorlevel% neq 0 (
    xcopy /e /i /q "%FRONTEND%\dist\vocab-frontend\*" "%STATIC%\"
)
echo Copied to: %STATIC%

echo.
echo [4/4] Building Spring Boot JAR...
cd /d "%BACKEND%"
call mvn.cmd package -DskipTests
if %errorlevel% neq 0 ( echo [ERROR] Maven build failed & pause & exit /b 1 )

echo.
echo ========================================
echo   Build complete!
for %%f in ("%BACKEND%\target\*.jar") do echo   JAR: %%f
echo ========================================
pause
