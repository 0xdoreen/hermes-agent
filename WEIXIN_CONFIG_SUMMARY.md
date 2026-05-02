# 微信集成配置总结

## 📊 当前状态

| 项目 | 状态 | 备注 |
|-----|------|------|
| HermesAgent 版本 | v0.8.0 | ✅ |
| Python 版本 | 3.13.2 | ✅ |
| aiohttp | 3.13.5 | ✅ 已安装 |
| cryptography | 46.0.3 | ✅ 已安装 |
| 微信适配器 | weixin.py | ✅ 已集成 |
| **配置完成度** | **0%** | ⏳ 待开始 |

---

## 🎯 三步启动微信网关

### 第一步：启动配置向导

选择你的操作系统：

**Windows PowerShell:**
```powershell
cd D:\SD\Project\Python_Work\HermesAgent
.\setup-weixin.ps1
```

**Windows CMD:**
```cmd
cd D:\SD\Project\Python_Work\HermesAgent
setup-weixin.bat
```

**Linux/macOS:**
```bash
cd ~/Projects/HermesAgent
bash setup-weixin.sh
```

**或手动配置：**
```bash
hermes gateway setup
```

### 第二步：扫描 QR 码

1. 脚本会显示一个 **QR 二维码**
2. 用你的 **微信** 扫描该二维码
3. 在手机微信上确认"登录请求"
4. 脚本会自动获取你的登录信息

### 第三步：启动网关

**前台运行（用于测试）：**
```bash
hermes gateway run
```

**后台运行（生产环境）：**
```bash
hermes gateway start
```

---

## ✨ 成功标志

看到这些消息说明配置成功：

```
✅ Weixin account configured: [account_id]
[Weixin] Adapter initialized...
[Weixin] Connected successfully
✓ Gateway is running
```

---

## 📍 关键文件位置

### 配置文件

| 文件 | 位置 | 说明 |
|-----|------|------|
| 环境变量 | `~/.hermes/.env` | 存储 WEIXIN_ACCOUNT_ID 和 WEIXIN_TOKEN |
| 主配置 | `~/.hermes/config.yaml` | Hermes 主配置文件 |
| 网关日志 | `~/.hermes/logs/gateway.log` | 网关运行日志 |

### 源代码

| 文件 | 路径 | 功能 |
|-----|------|------|
| 微信适配器 | `gateway/platforms/weixin.py` | 微信 API 集成 |
| 网关 CLI | `hermes_cli/gateway.py` | 网关命令行接口 |
| 设置向导 | `hermes_cli/setup.py` | 配置向导 |

### 文档

| 文件 | 内容 |
|-----|------|
| `WEIXIN_SETUP_GUIDE.md` | 详细配置指南 |
| `WEIXIN_CONFIG_SUMMARY.md` | 本文件 |
| `QUICKSTART.md` | 快速启动指南 |

---

## 🔧 配置选项

### 权限策略（DM_POLICY）

编辑 `~/.hermes/.env`：

```env
# 选项 1: 仅白名单用户可用
WEIXIN_DM_POLICY=allowlist
WEIXIN_DM_ALLOWLIST=user1,user2,user3

# 选项 2: 所有私聊用户可用
WEIXIN_DM_POLICY=allow_all

# 选项 3: 禁用私聊
WEIXIN_DM_POLICY=disabled
```

### 群组策略（GROUP_POLICY）

```env
# 选项 1: 禁用群组（推荐）
WEIXIN_GROUP_POLICY=disabled

# 选项 2: 仅白名单群组
WEIXIN_GROUP_POLICY=allowlist
WEIXIN_GROUP_ALLOWLIST=group1,group2

# 选项 3: 所有群组
WEIXIN_GROUP_POLICY=allow_all
```

---

## 🧪 测试方法

### 基础测试

1. **启动网关**：
   ```bash
   hermes gateway run
   ```

2. **用微信发消息**：
   - 在微信里给 bot 账号发送消息
   - 应该会收到回复

3. **测试命令**：
   ```
   /help          # 查看可用命令
   /model         # 查看当前模型
   /skills        # 列出可用技能
   ```

### 高级测试

```bash
# 查看网关状态
hermes gateway status

# 查看实时日志
tail -f ~/.hermes/logs/gateway.log

# 重启网关
hermes gateway restart

# 停止网关
hermes gateway stop
```

---

## 🐛 常见问题

### Q: 扫码后没有反应？
**A:** 
- 检查网络连接
- 确保微信账号能正常登录
- 尝试重新运行 `hermes gateway setup`

### Q: 网关启动失败？
**A:**
```bash
# 检查依赖
python -m pip list | grep -E "aiohttp|cryptography"

# 检查配置
cat ~/.hermes/.env | grep WEIXIN

# 重新配置
hermes gateway setup
```

### Q: 收不到消息？
**A:**
- 检查 WEIXIN_DM_POLICY 配置
- 确保你在白名单中
- 查看网关日志：`tail -f ~/.hermes/logs/gateway.log`

### Q: 发送消息超时？
**A:**
- 重启网关服务
- 检查网络连接
- 微信 API 服务可能临时不可用

---

## 📚 支持的功能

✅ **文本消息** - 发送和接收  
✅ **图片** - 完整支持  
✅ **视频** - 完整支持  
✅ **文档** - 文件传输  
✅ **实时同步** - 长轮询 API  
✅ **加密媒体** - AES-128-ECB  
✅ **消息去重** - 防止重复处理  
✅ **用户隔离** - 权限白名单  
✅ **群组支持** - 可选启用  

❌ **红包** - 不支持  
❌ **小程序** - 不支持  
❌ **公众号** - 需要企业微信  

---

## 🔐 安全建议

1. **使用小号测试** - 生产前先在测试账号验证
2. **启用白名单** - 使用 WEIXIN_DM_ALLOWLIST 限制访问
3. **禁用群组** - 除非必要，否则设置为 `disabled`
4. **定期检查日志** - 监控异常活动
5. **保护环境变量** - 不要共享 `.env` 文件
6. **定期重启** - 建议每天重启网关服务一次

---

## 📞 获取帮助

### 遇到问题时：

1. **查看详细日志**：
   ```bash
   tail -f ~/.hermes/logs/gateway.log
   ```

2. **查看网关状态**：
   ```bash
   hermes gateway status
   ```

3. **查看配置**：
   ```bash
   cat ~/.hermes/.env | grep WEIXIN
   cat ~/.hermes/config.yaml
   ```

4. **重新配置**：
   ```bash
   hermes gateway setup
   ```

5. **重启网关**：
   ```bash
   hermes gateway restart
   ```

---

## 📋 快速参考

### 常用命令

```bash
# 配置
hermes gateway setup          # 启动配置向导
hermes setup                  # 完整设置向导

# 运行
hermes gateway run            # 前台运行（调试）
hermes gateway start          # 后台运行
hermes gateway stop           # 停止服务
hermes gateway restart        # 重启服务

# 状态
hermes gateway status         # 查看网关状态
tail -f ~/.hermes/logs/gateway.log  # 查看日志

# 模型
hermes model                  # 切换模型
hermes /model                 # 在会话中切换

# 其他
hermes /help                  # 查看命令帮助
hermes sessions               # 管理会话
```

---

## ✅ 配置清单

- [ ] 已安装依赖：aiohttp 3.13.5+
- [ ] 已安装依赖：cryptography 46.0.3+
- [ ] 已运行 `hermes gateway setup`
- [ ] 已用微信扫 QR 码登录
- [ ] 已验证 `~/.hermes/.env` 中有 WEIXIN_ACCOUNT_ID
- [ ] 已启动网关服务（`hermes gateway run` 或 `start`）
- [ ] 已测试发送/接收消息
- [ ] 已配置权限策略（可选）
- [ ] 已配置群组策略（可选）

---

**🎉 配置完成！现在可以在微信里使用 HermesAgent 了！**
