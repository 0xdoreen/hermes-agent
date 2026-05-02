#!/bin/bash

# Bash 脚本: 微信网关配置和启动
# WeChat Gateway Setup and Run Script

set -e

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║     HermesAgent 微信（WeChat）网关配置      ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# 检查 Python
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 未找到 Python 3"
    echo "请确保 Python 3.11+ 已安装"
    exit 1
fi

python3 --version
echo "✅ Python 已安装"
echo ""

# 检查依赖
echo "📦 检查依赖..."
python3 -c "import aiohttp; print('  ✅ aiohttp:', aiohttp.__version__)"
python3 -c "import cryptography; print('  ✅ cryptography:', cryptography.__version__)"
echo ""

# 检查现有配置
HERMES_ENV_PATH="${HOME}/.hermes/.env"
if [ -f "$HERMES_ENV_PATH" ]; then
    echo "✅ 已找到现有配置 ($HERMES_ENV_PATH)"
    echo ""

    read -p "是否重新配置微信? (y/n, 默认 n): " reconfigure
    if [ "$reconfigure" != "y" ] && [ "$reconfigure" != "Y" ]; then
        echo ""
        echo "跳过配置向导，直接启动网关..."
        echo ""
        goto_start_gateway=true
    fi
else
    echo "ℹ️  首次配置，将启动配置向导"
    echo ""
fi

# 启动配置向导（如果需要）
if [ "$goto_start_gateway" != "true" ]; then
    echo "📋 启动微信配置向导..."
    echo ""
    echo "说明:"
    echo "  1. 选择 'Weixin (WeChat)' 选项"
    echo "  2. 用微信扫描显示的 QR 码"
    echo "  3. 在手机微信上确认登录"
    echo ""
    read -p "按 Enter 键继续..."
    echo ""

    python3 -m hermes gateway setup || {
        echo "❌ 配置失败，请检查错误信息"
        exit 1
    }
fi

# 显示启动选项
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║         微信网关配置完成！                  ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "选择启动方式:"
echo ""
echo "  1. 前台运行（用于调试，按 Ctrl+C 停止）"
echo "  2. 后台运行（生产环境）"
echo "  3. 仅查看状态"
echo "  4. 停止网关服务"
echo "  5. 退出"
echo ""

read -p "请选择 (1-5): " choice

case $choice in
    1)
        echo ""
        echo "🚀 启动微信网关（前台模式）..."
        echo ""
        python3 -m hermes gateway run
        ;;

    2)
        echo ""
        echo "🚀 启动微信网关（后台模式）..."
        echo ""
        python3 -m hermes gateway start
        sleep 2
        echo ""
        echo "✅ 网关已启动"
        echo "📊 查看状态: hermes gateway status"
        echo "📋 查看日志: tail -f ~/.hermes/logs/gateway.log"
        ;;

    3)
        echo ""
        echo "📊 网关状态:"
        echo ""
        python3 -m hermes gateway status
        ;;

    4)
        echo ""
        echo "🛑 停止网关服务..."
        echo ""
        python3 -m hermes gateway stop
        sleep 1
        echo "✅ 网关已停止"
        ;;

    *)
        echo ""
        echo "❌ 无效选择，退出"
        ;;
esac

echo ""
read -p "按 Enter 键退出..."
