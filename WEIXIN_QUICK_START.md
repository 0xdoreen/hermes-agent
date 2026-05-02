# 🚀 微信网关快速启动（1 分钟）

> 一键启动 HermesAgent 微信网关，5 分钟内即可在微信里使用 AI Agent

## ⚡ 最快启动方式

### Windows 用户

**选项 1：PowerShell（推荐）**
```powershell
cd D:\SD\Project\Python_Work\HermesAgent
.\setup-weixin.ps1
```

**选项 2：命令行**
```cmd
cd D:\SD\Project\Python_Work\HermesAgent
setup-weixin.bat
```

### Linux/macOS 用户

```bash
cd ~/path/to/HermesAgent
bash setup-weixin.sh
```

---

## 📱 执行流程

```
1️⃣ 运行脚本
   ↓
2️⃣ 选择配置或跳过（如果已配置）
   ↓
3️⃣ 用微信扫 QR 码
   ↓
4️⃣ 在手机上确认登录
   ↓
5️⃣ 选择运行方式（前台/后台）
   ↓
6️⃣ 完成！开始用微信聊天
```

---

## ✅ 成功标志

看到这些消息：
```
✅ Weixin account configured
[Weixin] Adapter initialized...
[Weixin] Connected successfully
```

---

## 💬 测试

用微信给 bot 发消息，应该会收到回复

---

## 🔗 更多信息

- **详细指南**：[WEIXIN_SETUP_GUIDE.md](./WEIXIN_SETUP_GUIDE.md)
- **配置参考**：[WEIXIN_CONFIG_SUMMARY.md](./WEIXIN_CONFIG_SUMMARY.md)
- **快速参考**：[QUICKSTART.md](./QUICKSTART.md)

---

## 🎯 就是这样！

现在 HermesAgent 已经准备好在微信里工作了。

**下一步：** 
1. 运行 `.\setup-weixin.ps1`（或对应你系统的脚本）
2. 扫 QR 码
3. 开始聊天！

**如需帮助：** 查看 [WEIXIN_CONFIG_SUMMARY.md](./WEIXIN_CONFIG_SUMMARY.md) 中的故障排除部分
