# 微信（WeChat）集成指南

本指南帮助你在 HermesAgent 中配置微信（Weixin）网关。

## 🎯 目标
让 HermesAgent 能够在微信里接收和发送消息。

## ✅ 前置条件

1. **Python 3.11+** - 已安装
2. **依赖库** - 已安装：
   - `aiohttp` (3.13.5) ✓
   - `cryptography` (46.0.3) ✓
3. **微信账号** - 用于登录（建议使用小号测试）

---

## 📋 配置步骤

### 步骤 1：启动微信配置向导

```bash
hermes gateway setup
```

执行命令后会看到菜单，选择：**Weixin (WeChat)** 选项

### 步骤 2：扫码登录

- 终端会显示一个 **QR 二维码**
- 使用你的微信扫描此二维码
- 在手机微信上确认登录请求

### 步骤 3：自动配置完成

配置向导会自动：
- 获取你的 `account_id` 和 `token`
- 保存到 `~/.hermes/.env` 文件
- 显示配置成功的提示

---

## ⚙️ 可选配置

### 权限策略设置（可选但重要）

编辑 `~/.hermes/.env` 文件，添加以下配置：

```env
# 只响应私聊白名单中的用户
WEIXIN_DM_POLICY=allowlist

# 默认关闭群聊响应（如需开启请谨慎）
WEIXIN_GROUP_POLICY=disabled
# 或允许特定群组
# WEIXIN_GROUP_POLICY=allowlist
```

### 允许列表配置

如果使用 `allowlist` 策略，在 `~/.hermes/.env` 中添加：

```env
# 私聊白名单（用户 ID）
WEIXIN_DM_ALLOWLIST=user1,user2,user3

# 群组白名单（群聊 ID）
WEIXIN_GROUP_ALLOWLIST=group1,group2
```

---

## 🚀 启动网关服务

配置完成后，启动微信网关：

### 前台运行（用于测试）

```bash
hermes gateway run
```

你应该看到类似的输出：
```
[Weixin] Adapter initialized...
[Weixin] Connected successfully
```

### 后台运行（生产环境）

```bash
hermes gateway start
```

查看状态：
```bash
hermes gateway status
```

停止服务：
```bash
hermes gateway stop
```

---

## 🧪 测试

1. **启动网关后**，用你登录的微信账号给你的 bot 账号发送消息
2. **检查响应**：bot 应该会回复你的消息
3. **查看日志**：
   ```bash
   # 如果是后台服务
   tail -f ~/.hermes/logs/gateway.log
   ```

---

## 🔒 功能特性

HermesAgent 的微信适配器支持：

✅ **文本消息** - 基础聊天  
✅ **图片** - 发送和接收图片  
✅ **视频** - 发送和接收视频  
✅ **文档** - 文件传输  
✅ **长轮询** - 稳定的消息推送（getupdates API）  
✅ **加密** - AES-128-ECB 媒体文件加密  
✅ **消息去重** - 防止重复处理（300s TTL）  

---

## 🐛 故障排除

### 问题：扫码后无反应

**解决方案：**
- 确保微信账号能正常登录
- 检查网络连接
- 尝试重新运行 `hermes gateway setup`

### 问题：网关启动失败

**检查步骤：**
```bash
# 1. 检查环境变量是否正确设置
cat ~/.hermes/.env | grep WEIXIN

# 2. 确保依赖完整
python -m pip list | grep -E "aiohttp|cryptography"

# 3. 查看详细错误
hermes gateway run
```

### 问题：bot 无法接收消息

**检查列表：**
- [ ] WEIXIN_ACCOUNT_ID 和 WEIXIN_TOKEN 正确设置
- [ ] 网关服务正在运行
- [ ] 如果使用了 `allowlist`，确认发送者在白名单中
- [ ] 检查权限策略配置是否被禁用

### 问题：发送消息超时或失败

**可能原因：**
- API 超时（默认 15 秒）
- 网络连接不稳定
- 微信 API 服务异常

**解决方案：**
```bash
# 重启网关服务
hermes gateway restart
```

---

## 📚 相关文件位置

| 文件/目录 | 说明 |
|---------|------|
| `~/.hermes/.env` | 环境变量（包含 WEIXIN_ACCOUNT_ID 等） |
| `~/.hermes/config.yaml` | 主配置文件 |
| `~/.hermes/logs/` | 日志目录 |
| `gateway/platforms/weixin.py` | 微信适配器源码 |

---

## 🔗 API 端点

HermesAgent 使用腾讯的 iLink Bot API：

| 端点 | 用途 |
|-----|------|
| `ilink/bot/getupdates` | 长轮询获取消息 |
| `ilink/bot/sendmessage` | 发送消息 |
| `ilink/bot/sendtyping` | 发送"正在输入"状态 |
| `ilink/bot/getconfig` | 获取配置 |
| `ilink/bot/getuploadurl` | 上传媒体文件 |
| `ilink/bot/get_bot_qrcode` | QR 码登录 |

Base URL: `https://ilinkai.weixin.qq.com`

---

## 💡 最佳实践

1. **使用小号测试** - 在个人账号上先测试，再投入生产
2. **启用权限策略** - 使用 `allowlist` 限制访问范围
3. **监控日志** - 定期检查网关日志发现问题
4. **定期重启** - 生产环境中建议定期重启网关服务（如每天一次）
5. **备份配置** - 保存 `~/.hermes/.env` 的备份

---

## 🆘 获取帮助

如遇问题，可以：

1. 查看日志：`~/.hermes/logs/gateway.log`
2. 运行诊断：`hermes gateway status`
3. 重新配置：`hermes gateway setup`
4. 查看源码：`gateway/platforms/weixin.py`

---

**配置完成！祝使用愉快！** 🎉
