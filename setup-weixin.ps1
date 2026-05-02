# PowerShell 脚本: 微信网关配置和启动
# WeChat Gateway Setup and Run Script

Write-Host ""
Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     HermesAgent 微信（WeChat）网关配置      ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# 检查 Python
try {
    python --version | Out-Null
    Write-Host "✅ Python 已安装" -ForegroundColor Green
} catch {
    Write-Host "❌ 错误: 未找到 Python" -ForegroundColor Red
    Write-Host "请确保 Python 3.11+ 已安装并在 PATH 中" -ForegroundColor Yellow
    Read-Host "按 Enter 键退出"
    exit 1
}

Write-Host ""

# 检查现有配置
$hermesEnvPath = "$env:USERPROFILE\.hermes\.env"
if (Test-Path $hermesEnvPath) {
    Write-Host "✅ 已找到现有配置（~/.hermes/.env）" -ForegroundColor Green
    Write-Host ""

    $reconfigure = Read-Host "是否重新配置微信? (y/n, 默认 n)"
    if ($reconfigure -ne "y" -and $reconfigure -ne "Y") {
        Write-Host ""
        Write-Host "跳过配置向导，直接启动网关..." -ForegroundColor Yellow
        Write-Host ""
        goto StartGateway
    }
} else {
    Write-Host "ℹ️  首次配置，将启动配置向导" -ForegroundColor Yellow
    Write-Host ""
}

# 启动配置向导
Write-Host "📋 启动微信配置向导..." -ForegroundColor Cyan
Write-Host ""
Write-Host "说明:" -ForegroundColor White
Write-Host "  1. 选择 'Weixin (WeChat)' 选项" -ForegroundColor Gray
Write-Host "  2. 用微信扫描显示的 QR 码" -ForegroundColor Gray
Write-Host "  3. 在手机微信上确认登录" -ForegroundColor Gray
Write-Host ""
Read-Host "按 Enter 键继续"
Write-Host ""

python -m hermes gateway setup

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ 配置失败，请检查错误信息" -ForegroundColor Red
    Read-Host "按 Enter 键退出"
    exit 1
}

:StartGateway

Write-Host ""
Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║         微信网关配置完成！                  ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "选择启动方式:" -ForegroundColor White
Write-Host ""
Write-Host "  1. 前台运行（用于调试，按 Ctrl+C 停止）" -ForegroundColor Gray
Write-Host "  2. 后台运行（生产环境）" -ForegroundColor Gray
Write-Host "  3. 仅查看状态" -ForegroundColor Gray
Write-Host "  4. 停止网关服务" -ForegroundColor Gray
Write-Host "  5. 退出" -ForegroundColor Gray
Write-Host ""

$choice = Read-Host "请选择 (1-5)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "🚀 启动微信网关（前台模式）..." -ForegroundColor Green
        Write-Host ""
        python -m hermes gateway run
    }

    "2" {
        Write-Host ""
        Write-Host "🚀 启动微信网关（后台模式）..." -ForegroundColor Green
        Write-Host ""
        python -m hermes gateway start
        Start-Sleep -Seconds 2
        Write-Host ""
        Write-Host "✅ 网关已启动" -ForegroundColor Green
        Write-Host "📊 查看状态: hermes gateway status" -ForegroundColor Yellow
        Write-Host "📋 查看日志: Get-Content -Path $env:USERPROFILE\.hermes\logs\gateway.log -Wait" -ForegroundColor Yellow
    }

    "3" {
        Write-Host ""
        Write-Host "📊 网关状态:" -ForegroundColor Cyan
        Write-Host ""
        python -m hermes gateway status
    }

    "4" {
        Write-Host ""
        Write-Host "🛑 停止网关服务..." -ForegroundColor Yellow
        Write-Host ""
        python -m hermes gateway stop
        Start-Sleep -Seconds 1
        Write-Host "✅ 网关已停止" -ForegroundColor Green
    }

    default {
        Write-Host ""
        Write-Host "❌ 无效选择，退出" -ForegroundColor Red
    }
}

Write-Host ""
Read-Host "按 Enter 键退出"
