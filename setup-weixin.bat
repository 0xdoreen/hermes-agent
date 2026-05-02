@echo off
chcp 65001 >nul
REM WeChat Gateway Setup and Run Script
REM Encoding: UTF-8

setlocal enabledelayedexpansion

echo.
echo ==================================================
echo     HermesAgent WeChat Gateway Setup
echo ==================================================
echo.

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found
    echo Please ensure Python 3.11+ is installed and in PATH
    pause
    exit /b 1
)

echo [OK] Python installed
echo.

REM Check existing config
if exist "%USERPROFILE%\.hermes\.env" (
    echo [OK] Found existing config at ~/.hermes/.env
    echo.
    set /p "reconfigure=Reconfigure WeChat? (y/n, default n): "
    if /i "!reconfigure!"=="y" goto :run_setup
    goto :start_gateway
)

echo [INFO] First-time setup, launching config wizard
echo.

:run_setup
echo Launching WeChat setup wizard...
echo.
echo Instructions:
echo   1. Select "Weixin (WeChat)" option
echo   2. Scan the QR code with WeChat
echo   3. Confirm login on your phone
echo.
pause

python -m hermes gateway setup

if errorlevel 1 (
    echo [ERROR] Setup failed, please check the error message
    pause
    exit /b 1
)

:start_gateway

echo.
echo ==================================================
echo     WeChat Gateway Setup Complete
echo ==================================================
echo.
echo Select startup mode:
echo.
echo   1. Foreground (debug mode, Ctrl+C to stop)
echo   2. Background (production mode)
echo   3. View status only
echo   4. Stop gateway service
echo   5. Exit
echo.

set /p "choice=Please select (1-5): "

if "!choice!"=="1" (
    echo.
    echo Starting WeChat gateway in foreground mode...
    echo.
    python -m hermes gateway run
    goto :end
)

if "!choice!"=="2" (
    echo.
    echo Starting WeChat gateway in background mode...
    echo.
    python -m hermes gateway start
    timeout /t 2 /nobreak >nul
    echo.
    echo [OK] Gateway started
    echo View status: hermes gateway status
    echo View logs: type %USERPROFILE%\.hermes\logs\gateway.log
    goto :end
)

if "!choice!"=="3" (
    echo.
    echo Gateway status:
    echo.
    python -m hermes gateway status
    goto :end
)

if "!choice!"=="4" (
    echo.
    echo Stopping gateway service...
    echo.
    python -m hermes gateway stop
    timeout /t 1 /nobreak >nul
    echo [OK] Gateway stopped
    goto :end
)

if "!choice!"=="5" (
    goto :end
)

echo [ERROR] Invalid choice
goto :end

:end
echo.
pause
endlocal
