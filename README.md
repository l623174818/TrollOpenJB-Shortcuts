# TrollOpenJB - 快捷指令集成版

在 iPhone 上实现 iPad 风格的多窗口分屏功能，**支持快捷指令 (Shortcuts) URL Scheme 调用**。

---

## 🎯 新增功能

### 快捷指令 URL Scheme

通过 URL 直接调用 TrollOpenJB 的 53 个系统控制命令：

```
troll-openjb://<command>
troj://<command>              # 短别名
```

### 示例

```
troll-openjb://cmd_toggle_personal_hotspot    # 切换热点
troll-openjb://cmd_toggle_wifi                # 切换 WiFi
troll-openjb://cmd_front_app_split            # 前台应用分屏
troj://cmd_take_screenshot                    # 截图
```

---

## 📦 安装

### 要求

- iOS 16.0+
- TrollStore 或 越狱环境
- Theos (编译需要)

### 编译

```bash
cd TrollOpenJB-Shortcuts

# 一键编译打包
./build.sh

# 或手动编译
make package
```

### 安装

```bash
# 方法 1: Sileo/Cydia
# 将 deb 上传到设备，使用包管理器安装

# 方法 2: 命令行
dpkg -i com.charlieleung.trollopenjb.shortcuts_1.3.7-shortcuts_iphoneos-arm64.deb

# 方法 3: TrollStore
# 直接点击 deb 文件安装
```

---

## 🔗 快捷指令使用

### 方式 A: 基础调用

```
1. 打开 URL
   URL: troll-openjb://cmd_toggle_personal_hotspot

2. 显示通知 (可选)
   消息：热点已切换
```

### 方式 B: 带参数

```
打开 URL: troll-openjb://cmd_toggle_night_shift?enabled=1
```

### 方式 C: Siri 语音

1. 创建快捷指令
2. 命名为「打开热点"
3. 添加操作：打开 URL `troll-openjb://cmd_toggle_personal_hotspot`
4. 添加到 Siri
5. 说「嘿 Siri，打开热点」

---

## 📋 53 个命令列表

### 网络控制

| 命令 | URL | 说明 |
|------|-----|------|
| WiFi | `troll-openjb://cmd_toggle_wifi` | 切换 WiFi |
| 蓝牙 | `troll-openjb://cmd_toggle_bluetooth` | 切换蓝牙 |
| 飞行模式 | `troll-openjb://cmd_toggle_airplane_mode` | 切换飞行模式 |
| 蜂窝数据 | `troll-openjb://cmd_toggle_cellular_data` | 切换移动数据 |
| VPN | `troll-openjb://cmd_toggle_vpn` | 切换 VPN |
| **热点** | `troll-openjb://cmd_toggle_personal_hotspot` | 切换个人热点 ⭐ |

### 截图/录屏

| 命令 | URL | 说明 |
|------|-----|------|
| 截图 | `troll-openjb://cmd_take_screenshot` | 截取全屏 |
| 截图并编辑 | `troll-openjb://cmd_take_screenshot_and_edit` | 截图后编辑 |
| 区域截图 | `troll-openjb://cmd_screenshot_region` | 选区截图 |
| 截图到剪贴板 | `troll-openjb://cmd_screenshot_to_pasteboard` | 截图复制 |
| 录屏 | `troll-openjb://cmd_screen_record` | 屏幕录制 |
| 录屏 - 麦克风 | `troll-openjb://cmd_screen_record_mic` | 录屏 + 麦克风 |

### 多任务/分屏

| 命令 | URL | 说明 |
|------|-----|------|
| 前台应用分屏 | `troll-openjb://cmd_front_app_split` | 当前应用分屏 ⭐ |
| 单窗口模式 | `troll-openjb://cmd_toggle_single_window_mode` | 单窗口切换 |
| 清理分屏背景 | `troll-openjb://cmd_cleanup_split_background` | 清理背景 |
| 收缩浮动窗口 | `troll-openjb://cmd_shrink_floating_windows` | 收缩窗口 |

### 声音控制

| 命令 | URL | 说明 |
|------|-----|------|
| 静音 | `troll-openjb://cmd_toggle_mute` | 切换静音 |
| 静音模式 | `troll-openjb://cmd_toggle_silent_mode` | 静音模式 |
| 增加音量 | `troll-openjb://cmd_increase_volume` | 音量+ |
| 降低音量 | `troll-openjb://cmd_decrease_volume` | 音量 - |

### 显示控制

| 命令 | URL | 说明 |
|------|-----|------|
| 夜览模式 | `troll-openjb://cmd_toggle_night_shift` | 夜览切换 |
| 自动亮度 | `troll-openjb://cmd_toggle_auto_brightness` | 自动亮度 |
| 原彩显示 | `troll-openjb://cmd_toggle_true_tone` | 原彩切换 |
| 智能反转 | `troll-openjb://cmd_toggle_smart_invert` | 智能反转 |
| 方向锁定 | `troll-openjb://cmd_toggle_orientation` | 方向锁定 |

### 系统控制

| 命令 | URL | 说明 |
|------|-----|------|
| 注销 | `troll-openjb://cmd_respring` | 注销 SpringBoard |
| 重启设备 | `troll-openjb://cmd_reboot_device` | 重启设备 |
| Siri | `troll-openjb://cmd_activate_siri` | 呼叫 Siri |
| 勿扰模式 | `troll-openjb://cmd_toggle_dnd` | 勿扰切换 |
| 低电量模式 | `troll-openjb://cmd_toggle_low_power_mode` | 省电模式 |

### Agent 功能

| 命令 | URL | 说明 |
|------|-----|------|
| 聊天 Agent | `troll-openjb://cmd_chat_agent` | AI 聊天 |
| 音频聊天 | `troll-openjb://cmd_audio_chat` | 语音对话 |
| 视觉 Agent | `troll-openjb://cmd_visual_agent` | 视觉识别 |
| Troll Agent 音乐 | `troll-openjb://cmd_troll_agent_music` | 音乐播放 |

---

## 🐛 故障排除

### URL 无法打开

1. 确认 TrollOpenJB 已安装
2. 确认插件已注入 SpringBoard
3. 重启 SpringBoard: `killall SpringBoard`

### 命令不执行

查看日志:
```bash
log show --predicate 'eventMessage contains "TrollOpenJB"' --last 1m
```

### 通知不显示

检查通知权限:
设置 → 通知 → TrollOpenJB → 允许通知

---

## 📁 项目结构

```
TrollOpenJB-Shortcuts/
├── Makefile              # Theos 编译配置
├── Tweak.x               # URL Scheme 处理核心
├── TrollOpenJB.plist     # 注入配置
├── Package/
│   └── DEBIAN/
│       ├── control       # 包信息
│       └── postinst      # 安装后脚本
├── build.sh              # 一键打包脚本
└── README.md             # 本文档
```

---

## 🔧 开发

### 添加新命令

1. 在 `Tweak.x` 的 `CommandNames` 字典中添加映射
2. 确保原有插件支持该命令的 Darwin Notification

### 调试

```bash
# 实时日志
tail -f /var/log/syslog | grep TrollOpenJB

# 测试 URL
troll-openjb://cmd_toggle_wifi
```

---

## 📄 许可证

与原 TrollOpenJB 插件相同

---

## 🙏 致谢

- **原插件作者**: Charlie Leung (TrollOpenJB)
- **快捷指令集成**: 2026-10-28

---

## 📞 支持

- QQ 群：1094778353
- 问题反馈：GitHub Issues

---

**版本**: 1.3.7-shortcuts  
**更新日期**: 2026-10-28
