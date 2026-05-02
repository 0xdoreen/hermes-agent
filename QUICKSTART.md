# 🚀 Hermes Agent + DeepSeek 快速启动指南

## ✅ 配置状态

| 项目 | 状态 | 详情 |
|-----|------|------|
| **Hermes 版本** | v0.8.0 | ✅ 已安装 |
| **Python** | 3.13.2 | ✅ 已安装 |
| **Ollama 连接** | http://localhost:11434 | ✅ 已验证 |
| **默认模型** | deepseek-r1:14b | ✅ 已配置 |
| **可用模型** | 4 个 | ✅ qwen2.5-coder:14b, qwen2.5:7b 等 |

---

## 🎯 启动 Hermes

### 方式 1：使用 PowerShell（推荐）

```powershell
# 打开 PowerShell 后执行：
cd D:\SD\Project\Python_Work\HermesAgent
.\start-hermes.ps1
```

### 方式 2：使用 CMD

```cmd
cd D:\SD\Project\Python_Work\HermesAgent
start-hermes.bat
```

### 方式 3：直接使用 Python

```bash
cd D:\SD\Project\Python_Work\HermesAgent
python -m hermes_cli.main
```

---

## 📝 首次使用

1. **启动 Hermes**（选择上述任一方式）
2. **开始对话**：输入任何消息
3. **查看可用命令**：输入 `/help`
4. **切换模型**：输入 `/model` 查看或切换其他模型
5. **结束会话**：输入 `/exit` 或 `Ctrl+C`

---

## 🛠️ 常用命令

| 命令 | 功能 |
|-----|------|
| `/help` | 显示所有可用命令 |
| `/model` | 查看或切换 LLM 模型 |
| `/skills` | 列出所有可用技能 |
| `/new` | 开始新会话 |
| `/clear` | 清空当前会话 |
| `/compress` | 压缩上下文 |
| `/exit` | 退出 Hermes |

---

## 🔄 切换到其他模型

```bash
# 在 Hermes 中：
/model ollama:qwen2.5-coder:14b
```

**可用模型：**
- ✅ `deepseek-r1:14b` (9.0 GB) - 推荐，最强推理
- `qwen2.5-coder:14b` (9.0 GB) - 编码专家
- `qwen2.5:7b` (4.7 GB) - 轻量级通用
- `qwen2.5-vl:7b` (4.7 GB) - 视觉语言

---

## ⚙️ 配置文件位置

| 文件 | 位置 | 用途 |
|-----|------|------|
| 主配置 | `~/.hermes/config.yaml` | Hermes 配置 |
| 环境变量 | `D:\SD\Project\Python_Work\HermesAgent\.env` | 项目特定变量 |
| 会话记录 | `~/.hermes/sessions/` | 对话历史 |

---

## 💬 微信（WeChat）集成

### 快速启动微信网关

```powershell
# PowerShell 版本
.\setup-weixin.ps1

# 或 CMD 版本
setup-weixin.bat

# 或 Bash 版本
bash setup-weixin.sh
```

### 手动配置步骤

1. **启动配置向导**：
   ```bash
   hermes gateway setup
   ```

2. **选择 Weixin**，按提示扫 QR 码

3. **启动网关**：
   ```bash
   # 前台运行（用于测试）
   hermes gateway run

   # 或后台运行（生产环境）
   hermes gateway start
   ```

### 配置权限策略（可选）

编辑 `~/.hermes/.env`：

```env
# 只响应私聊白名单
WEIXIN_DM_POLICY=allowlist
WEIXIN_DM_ALLOWLIST=your_user_id

# 群聊响应政策
WEIXIN_GROUP_POLICY=disabled
```

详见：[微信设置指南](./WEIXIN_SETUP_GUIDE.md)

---

## 🔧 前提条件

### 确保 Ollama 正在运行

```bash
# 在另一个终端中
ollama serve
```

### 验证 Ollama 状态

```bash
# 查看所有模型
ollama list

# 测试 API
curl http://localhost:11434/api/tags
```

---

## 🐛 常见问题

### Q: "连接被拒绝" 或 "无法连接到 Ollama"
**A:** 确保 Ollama 正在运行（`ollama serve`）

### Q: 模型加载很慢
**A:** DeepSeek-R1:14B 是大模型，首次加载到内存需要时间。耐心等待。

### Q: 在 WSL2 中使用 Hermes
**A:** WSL2 中的 bash/zsh 不支持交互式 TUI。请在 Windows PowerShell 或 CMD 中运行。

### Q: 如何更改默认模型？
**A:** 编辑 `~/.hermes/config.yaml`，修改：
```yaml
model:
  default: qwen2.5:7b  # 改为你想要的模型
```

---

## 📚 更多资源

- **官方文档**：https://hermes-agent.nousresearch.com/docs/
- **GitHub**：https://github.com/NousResearch/hermes-agent
- **Discord**：https://discord.gg/NousResearch

---

## ✨ 功能亮点

✅ **本地运行** - 无需云服务或 API 密钥  
✅ **支持多模型** - 轻松切换不同模型  
✅ **工具集成** - 代码执行、文件操作、Web 搜索等  
✅ **技能系统** - 自动学习和存储工作流  
✅ **持久化记忆** - 跨会话记住用户信息  
✅ **消息平台** - 支持 Telegram、Discord 等（可选配置）

---

祝你使用愉快！🎉
