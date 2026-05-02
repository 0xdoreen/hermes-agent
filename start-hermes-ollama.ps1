# Hermes Agent - Ollama DeepSeek 启动脚本
# 直接设置所有环境变量

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Hermes Agent + Ollama + DeepSeek" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# 切换到脚本目录
Set-Location $PSScriptRoot

# 设置编码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$env:PYTHONIOENCODING = "utf-8"

# 添加 Python 到 PATH
$pythonPath = "C:\Users\doreen\AppData\Local\Programs\Python\Python313"
$env:PATH = "$pythonPath;$env:PATH"

# 设置自定义提供商环境变量
$env:CUSTOM_API_KEY = "ollama"
$env:CUSTOM_BASE_URL = "http://localhost:11434/v1"
$env:CUSTOM_API_MODE = "openai"

# 确保不使用 OpenRouter/OpenAI
$env:OPENROUTER_API_KEY = ""
$env:OPENAI_API_KEY = ""

# 检查 Ollama 连接
Write-Host "检查 Ollama 连接..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:11434/api/tags" -Method Get -TimeoutSec 2 -UseBasicParsing -ErrorAction Stop
    Write-Host "✓ Ollama 已启动" -ForegroundColor Green
} catch {
    Write-Host "✗ Ollama 未响应" -ForegroundColor Red
    Write-Host "  请在另一个 PowerShell 中运行: ollama serve" -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

Write-Host ""
Write-Host "启动 Hermes..." -ForegroundColor Yellow
Write-Host ""

# 启动 Hermes
& python -m hermes_cli.main @args

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "错误：Hermes 启动失败 (代码: $LASTEXITCODE)" -ForegroundColor Red
    pause
}
