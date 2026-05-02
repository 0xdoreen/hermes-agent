# Hermes Agent Launcher for PowerShell
# Prerequisites: Ollama must be running (ollama serve)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Hermes Agent v0.8.0" -ForegroundColor Green
Write-Host "  Using: DeepSeek-R1:14B (Local Ollama)" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Change to script directory
Set-Location $PSScriptRoot

# Set UTF-8 encoding
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$env:PYTHONIOENCODING = "utf-8"

# Add Python to PATH if not already there
$pythonPath = "C:\Users\doreen\AppData\Local\Programs\Python\Python313"
if ($env:PATH -notlike "*$pythonPath*") {
    $env:PATH = "$pythonPath;$env:PATH"
}

# Check if Ollama is running
Write-Host "Checking Ollama connection..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:11434/api/tags" -Method Get -TimeoutSec 2 -UseBasicParsing -ErrorAction Stop
    Write-Host "✓ Ollama is running" -ForegroundColor Green
} catch {
    Write-Host "✗ Ollama is not responding" -ForegroundColor Red
    Write-Host "  Please run in another PowerShell window: ollama serve" -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

Write-Host ""

# Start Hermes
python -m hermes_cli.main @args

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "Error: Failed to start Hermes (exit code: $LASTEXITCODE)" -ForegroundColor Red
    Write-Host "Make sure:" -ForegroundColor Yellow
    Write-Host "  1. Python 3.13+ is installed"
    Write-Host "  2. Ollama is running (ollama serve)"
    Write-Host "  3. You're in the HermesAgent directory"
    pause
}
