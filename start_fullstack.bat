@echo off
title LokSewa Prep SaaS - Full Stack Launcher (Node.js + MongoDB + Flutter Web)
echo =====================================================================
echo   LOKSEWA PREP SaaS - RBB IT LEVEL 5 FULL-STACK PLATFORM
echo =====================================================================
echo.
echo [1/2] Starting Node.js + MongoDB Backend API on http://localhost:5000 ...
start "LokSewa Backend (Port 5000)" cmd /k "cd /d E:\loksewa_prep_app\backend && node server.js"

timeout /t 3 /nobreak >nul

echo [2/2] Starting Flutter Web App on http://localhost:8080 ...
start "LokSewa Flutter Web (Port 8080)" cmd /k "cd /d E:\loksewa_prep_app\build\web && python -m http.server 8080"

timeout /t 2 /nobreak >nul
start http://localhost:8080

echo.
echo Both Backend (Port 5000) and Frontend (Port 8080) are now running!
pause
