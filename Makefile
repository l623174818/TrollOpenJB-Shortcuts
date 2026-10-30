# =============================================================================
#  TrollOpenJB - 快捷指令 URL Scheme 支持
# =============================================================================
#
#  版本：1.3.7- Shortcuts
#  日期：2026-10-28
#  作者：Charlie Leung (原) + Shortcuts Integration
#
#  新增功能:
#  - troll-openjb:// URL Scheme 支持
#  - troj:// 短别名
#  - 53 个快捷指令命令暴露
#
#  使用方式:
#  - troll-openjb://cmd_toggle_personal_hotspot
#  - troj://cmd_toggle_wifi
#
# =============================================================================

TARGET := iphone:clang:14.5:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TrollOpenJB

TrollOpenJB_FILES = Tweak.x
TrollOpenJB_FRAMEWORKS = UIKit Foundation UserNotifications
TrollOpenJB_PRIVATE_FRAMEWORKS = CoreTelephony Preferences AppSupport
# 禁用模块系统，Linux 上 Darwin 模块不可用
TrollOpenJB_CFLAGS = -fobjc-arc -DTHEOS_PACKAGE_SCHEME=rootless -fno-modules

include $(THEOS_MAKE_PATH)/tweak.mk

# 安装后重启 SpringBoard
after-install::
	install.exec "killall -9 SpringBoard || killall SpringBoard"
	@echo "✅ TrollOpenJB 快捷指令集成版已安装"
	@echo "📱 快捷指令 URL Scheme: troll-openjb:// troj://"
	@echo "🔗 示例：troll-openjb://cmd_toggle_personal_hotspot"
