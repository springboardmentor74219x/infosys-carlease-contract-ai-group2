@echo off
REM ============================================================
REM Car Lease/Loan Contract AI - Project Runner
REM ============================================================
REM This script starts all project components

echo.
echo ============================================================
echo  CAR LEASE/LOAN CONTRACT AI PROJECT
echo ============================================================
echo.

REM Get the current directory
set "PROJECT_DIR=%cd%"

echo [1/3] Starting Backend API Server on port 8000...
echo.
start "Backend Server" cmd /k "cd %PROJECT_DIR%\car_loan_backend && python -m uvicorn main:app --host 0.0.0.0 --port 8000"

timeout /t 3

echo [2/3] Starting Web UI Server on port 5000...
echo.
start "Web UI Server" cmd /k "cd %PROJECT_DIR% && python serve_ui.py"

timeout /t 3

echo [3/3] Opening Web UI in Chrome...
echo.
start "" "http://localhost:5000/web_ui.html"

echo.
echo ============================================================
echo  PROJECT STARTUP COMPLETE
echo ============================================================
echo.
echo Services running:
echo   [+] Backend API: http://localhost:8000
echo   [+] API Docs: http://localhost:8000/docs
echo   [+] Web UI: http://localhost:5000/web_ui.html
echo.
echo Press any key to exit...
pause
