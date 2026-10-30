# TrollOpenJB 快捷指令部署包

## 目录
1. [快速安装](#快速安装)
2. [53 个命令完整列表](#53-个命令完整列表)
3. [手动创建快捷指令](#手动创建快捷指令)
4. [批量导入方法](#批量导入方法)
5. [故障排除](#故障排除)

---

## 快速安装

### 前提条件
- ✅ iPhone 已越狱 (Dopamine 3.0 或其他)
- ✅ 已安装 TrollOpenJB 1.3.7 插件
- ✅ iOS 14.0 或更高版本

### 安装步骤

1. **确认插件已启用**
   - 打开 设置 → TrollOpenJB
   - 确保插件开关为 开启 状态

2. **创建第一个快捷指令 (WiFi 开关)**
   - 打开「快捷指令」App
   - 点击右上角 「+」
   - 点击「添加操作」
   - 搜索「URL」并添加
   - 输入：`troll-openjb://cmd_toggle_wifi`
   - 再次点击「添加操作」
   - 搜索「打开 URL」并添加
   - 命名快捷指令为「WiFi 开关」
   - 点击「完成」

3. **测试**
   - 在快捷指令 App 中点击「WiFi 开关」
   - 或添加到主屏幕/Widget
   - 点击运行，WiFi 应该切换状态

---

## 53 个命令完整列表

### 网络与连接 (6 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| WiFi 开关 | `troll-openjb://cmd_toggle_wifi` | `troj://wifi` |
| 蓝牙开关 | `troll-openjb://cmd_toggle_bluetooth` | `troj://bluetooth` |
| 飞行模式 | `troll-openjb://cmd_toggle_airplane_mode` | `troj://airplane` |
| 蜂窝数据 | `troll-openjb://cmd_toggle_cellular_data` | `troj://cellular` |
| VPN 开关 | `troll-openjb://cmd_toggle_vpn` | `troj://vpn` |
| 个人热点 | `troll-openjb://cmd_toggle_personal_hotspot` | `troj://hotspot` |

### 系统控制 (8 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| 静音开关 | `troll-openjb://cmd_toggle_mute` | `troj://mute` |
| 响铃模式 | `troll-openjb://cmd_toggle_silent_mode` | `troj://ring` |
| 勿扰模式 | `troll-openjb://cmd_toggle_do_not_disturb` | `troj://dnd` |
| 锁屏 | `troll-openjb://cmd_lock_screen` | `troj://lock` |
| 注销 | `troll-openjb://cmd_respring` | `troj://respring` |
| 重启 | `troll-openjb://cmd_reboot_device` | `troj://reboot` |
| 关机 | `troll-openjb://cmd_shutdown_device` | `troj://shutdown` |
| 安全模式 | `troll-openjb://cmd_safe_mode` | `troj://safe` |

### 屏幕与显示 (6 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| 自动旋转 | `troll-openjb://cmd_toggle_auto_rotate` | `troj://autorotate` |
| 截图 | `troll-openjb://cmd_take_screenshot` | `troj://screenshot` |
| 录屏 | `troll-openjb://cmd_screen_record` | `troj://record` |
| 深色模式 | `troll-openjb://cmd_toggle_dark_mode` | `troj://dark` |
| 亮度 50% | `troll-openjb://cmd_set_brightness?value=50` | `troj://brightness/50` |
| 音量 50% | `troll-openjb://cmd_set_volume?value=50` | `troj://volume/50` |

### 应用与进程 (6 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| 前台分屏 | `troll-openjb://cmd_front_app_split` | `troj://split` |
| 挂起前台 | `troll-openjb://cmd_suspend_front_app` | `troj://suspend` |
| 重启 SpringBoard | `troll-openjb://cmd_respring` | `troj://respring` |
| 清除后台 | `troll-openjb://cmd_clear_background_apps` | `troj://clear` |
| 打开设置 | `troll-openjb://cmd_open_settings` | `troj://settings` |

### 多媒体控制 (5 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| 播放暂停 | `troll-openjb://cmd_play_pause` | `troj://playpause` |
| 下一曲 | `troll-openjb://cmd_next_track` | `troj://next` |
| 上一曲 | `troll-openjb://cmd_prev_track` | `troj://prev` |
| 音量加 | `troll-openjb://cmd_volume_up` | `troj://volup` |
| 音量减 | `troll-openjb://cmd_volume_down` | `troj://voldown` |

### 摄像头与手电筒 (3 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| 手电筒 | `troll-openjb://cmd_toggle_flashlight` | `troj://flash` |
| 打开相机 | `troll-openjb://cmd_open_camera` | `troj://camera` |
| 切换相机 | `troll-openjb://cmd_switch_camera` | `troj://switchcam` |

### 定位与传感器 (2 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| 定位服务 | `troll-openjb://cmd_toggle_location` | `troj://location` |
| 指南针 | `troll-openjb://cmd_toggle_compass` | `troj://compass` |

### 辅助功能 (5 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| 旁白 | `troll-openjb://cmd_toggle_voiceover` | `troj://vo` |
| 缩放 | `troll-openjb://cmd_toggle_zoom` | `troj://zoom` |
| 反色 | `troll-openjb://cmd_toggle_invert` | `troj://invert` |
| 灰度 | `troll-openjb://cmd_toggle_grayscale` | `troj://gray` |
| 降低白点 | `troll-openjb://cmd_toggle_reduce_white_point` | `troj://whitepoint` |

### 开发者工具 (3 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| UI 调试 | `troll-openjb://cmd_toggle_ui_debug` | `troj://uidebug` |
| SSH | `troll-openjb://cmd_toggle_ssh` | `troj://ssh` |
| ADB | `troll-openjb://cmd_toggle_adb` | `troj://adb` |

### 系统信息 (4 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| 设备信息 | `troll-openjb://cmd_show_device_info` | `troj://info` |
| 网络信息 | `troll-openjb://cmd_show_network_info` | `troj://netinfo` |
| 存储信息 | `troll-openjb://cmd_show_storage_info` | `troj://storage` |
| 电池信息 | `troll-openjb://cmd_show_battery_info` | `troj://battery` |

### 其他实用 (5 个)
| 快捷指令名 | URL Scheme | 短 URL |
|-----------|-----------|--------|
| Siri | `troll-openjb://cmd_activate_siri` | `troj://siri` |
| Apple Pay | `troll-openjb://cmd_trigger_apple_pay` | `troj://pay` |
| 触觉反馈 | `troll-openjb://cmd_toggle_haptics` | `troj://haptics` |
| 低功耗 | `troll-openjb://cmd_toggle_low_power_mode` | `troj://lowpower` |
| 引导式访问 | `troll-openjb://cmd_guided_access` | `troj://guided` |

---

## 手动创建快捷指令

### 方法 1: 单个创建
```
1. 打开 快捷指令 App
2. 点击右上角 + 号
3. 点击「添加操作」
4. 搜索「URL」并添加
5. 在 URL 栏输入：troll-openjb://cmd_toggle_wifi
6. 再次点击「添加操作」
7. 搜索「打开 URL」并添加
8. 点击顶部名称，重命名为「WiFi 开关」
9. 点击「完成」
```

### 方法 2: 添加到主屏幕
```
1. 在快捷指令 App 中长按已创建的快捷指令
2. 点击「分享」
3. 选择「添加到主屏幕」
4. 命名并选择图标
5. 点击「添加」
```

### 方法 3: 添加到 Widget
```
1. 在主屏幕下拉进入搜索
2. 滚动到底部点击「编辑」
3. 添加「快捷指令」Widget
4. 选择「智能显示」或「特定快捷指令」
```

---

## 批量导入方法

### 使用快捷指令自动化
可以创建自动化在特定条件下触发：

1. 打开 设置 → 快捷指令 → 自动化
2. 点击「创建个人自动化」
3. 选择触发条件 (如「打开 App」、「连接 CarPlay」等)
4. 添加操作 → URL → 输入 troll-openjb:// 命令
5. 添加操作 → 打开 URL
6. 关闭「运行前询问」
7. 完成

### 使用 Siri 快捷方式
对 Siri 说：
- 「嘿 Siri，打开 WiFi」(需先创建对应快捷指令)
- Siri 可以学习你的快捷指令并自动执行

---

## 故障排除

### Q: 点击快捷指令显示「无法打开页面」
**A:** 检查以下项：
- TrollOpenJB 插件是否已安装
- 插件是否在 设置 → TrollOpenJB 中启用
- URL Scheme 格式是否正确 (区分大小写)

### Q: 快捷指令运行但无效果
**A:** 
- 某些命令需要特定权限 (如定位、相机)
- 检查 TrollOpenJB 设置中是否启用了该命令
- 尝试注销后重试

### Q: 如何创建所有 53 个快捷指令？
**A:** 推荐创建最常用的 10-15 个，不需要全部创建。
常用组合：
1. WiFi 开关
2. 蓝牙开关  
3. 手电筒
4. 截图
5. 深色模式
6. 手电筒
7. 勿扰模式
8. 个人热点
9. 静音开关
10. 重启 (respring)

### Q: 可以分享给朋友吗？
**A:** 可以，通过快捷指令 App 的分享功能导出为 .shortcut 文件

---

## 技术细节

### URL Scheme 格式
```
基础格式：troll-openjb://<command>
短格式：troj://<command>
参数格式：troll-openjb://<command>?key=value&key2=value2
```

### 支持的参数
| 命令 | 参数 | 示例 |
|-----|------|------|
| 设置亮度 | value (0-100) | `troll-openjb://cmd_set_brightness?value=75` |
| 设置音量 | value (0-100) | `troll-openjb://cmd_set_volume?value=50` |

---

## 版本信息
- TrollOpenJB: 1.3.7
- 快捷指令集成：1.0
- 更新日期：2026-10-29
- 作者：Charlie Leung + Shortcuts Integration

---

## 文件清单
本部署包包含：
- `README-Shortcuts.md` - 本文档
- `TrollOpenJB-所有命令.url.txt` - 53 命令 URL 列表
- `Tweak.x` - 插件源代码 (含 URL Scheme 支持)
- `Makefile` - Theos 编译配置
- `TrollOpenJB.plist` - 注入配置与 URL Scheme 声明
- `DEBIAN/control` - 包元数据

---

**注意**: 本版本为 TrollOpenJB 的快捷指令集成扩展，需要原版 TrollOpenJB 1.3.7 作为运行环境。
