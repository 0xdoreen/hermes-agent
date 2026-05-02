@echo off
REM Hermes Agent Launcher for Windows CMD
REM Prerequisites: Ollama must be running (ollama serve)

setlocal enabledelayedexpansion

cd /d "%~dp0"

echo.
echo ========================================
echo   Hermes Agent v0.8.0
echo   Using: DeepSeek-R1:14B (Local Ollama)
echo ========================================
echo.

REM Set UTF-8 encoding for better console support
chcp 65001 >nul

REM Add Python to PATH
set PATH=C:\Users\doreen\AppData\Local\Programs\Python\Python313;%PATH%

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo Error: Python is not in PATH
    echo Please ensure Python 3.13 is installed
    pause
    exit /b 1
)

REM Check if Ollama is running
echo Checking Ollama connection...
timeout /t 1 /nobreak >nul
curl -s http://localhost:11434/api/tags >nul 2>&1
if errorlevel 1 (
    echo.
    echo Error: Ollama is not responding
    echo Please run in another CMD window: ollama serve
    echo.
    pause
    exit /b 1
)
echo OK - Ollama is running
echo.

REM Start Hermes
python -m hermes_cli.main %*

if errorlevel 1 (
    echo.
    echo Error: Failed to start Hermes
    echo Make sure:
    echo   1. Python 3.13+ is installed and in PATH
    echo   2. Ollama is running (ollama serve)
    echo   3. You're in the HermesAgent directory
    pause
)
