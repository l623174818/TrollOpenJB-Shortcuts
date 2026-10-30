#!/bin/bash
# Manual .deb packager for TrollOpenJB-Shortcuts
# Bypasses Theos and uses dpkg-deb directly

set -e

PROJECT_DIR="/mnt/c/Users/fslu/AI/TrollOpenJB-Shortcuts"
PACKAGE_VERSION="1.3.8"
ARCH="arm64"
PACKAGE_NAME="com.charlieleung.trollopenjb.shortcuts"

WORK_DIR="/tmp/trollopenjb-build"
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"

echo "=== TrollOpenJB-Shortcuts .deb 打包工具 ==="
echo "版本：$PACKAGE_VERSION"
echo ""

# 1. 创建 DEBIAN 目录
mkdir -p "$WORK_DIR/DEBIAN"

# 2. 创建 control 文件
cat > "$WORK_DIR/DEBIAN/control" << CONTROL
Package: $PACKAGE_NAME
Name: TrollOpenJB-Shortcuts
Version: $PACKAGE_VERSION
Architecture: $ARCH
Maintainer: FS Lu
Depends: firmware (>= 14.0), mobilesubstrate, trollopenjb
Description: TrollOpenJB with URL Scheme support
 URL Scheme integration for TrollOpenJB
 Allows Shortcuts app to call 53 system commands
CONTROL

echo "✓ control 已创建"

# 3. 创建 postinst 脚本
cat > "$WORK_DIR/DEBIAN/postinst" << 'POSTINST'
#!/bin/sh
chown root:wheel /var/jb/Library/MobileSubstrate/DynamicLibraries/TrollOpenJBShortcuts.dylib
chmod 0644 /var/jb/Library/MobileSubstrate/DynamicLibraries/TrollOpenJBShortcuts.dylib
chown root:wheel /var/jb/Library/MobileSubstrate/DynamicLibraries/TrollOpenJBShortcuts.plist
chmod 0644 /var/jb/Library/MobileSubstrate/DynamicLibraries/TrollOpenJBShortcuts.plist

echo "TrollOpenJB-Shortcuts 安装完成!"
echo "使用快捷指令调用:"
echo "  快捷指令 App -> 新建 -> URL -> troll-openjb://cmd_toggle_wifi"
echo "或:"
echo "  shortcuts://x-callback-url/run-shortcut?name=WiFi"

if [ -f /usr/bin/killall ]; then
  killall -9 SpringBoard 2>/dev/null || true
fi
exit 0
POSTINST

chmod +x "$WORK_DIR/DEBIAN/postinst"
echo "✓ postinst 已创建"

# 4. 创建 dylib 目录结构
TWEAK_DIR="$WORK_DIR/var/jb/Library/MobileSubstrate/DynamicLibraries"
mkdir -p "$TWEAK_DIR"

# 5. 复制配置文件
cat > "$TWEAK_DIR/TrollOpenJBShortcuts.plist" << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Filter</key>
    <dict>
        <key>Bundles</key>
        <array>
            <string>com.apple.springboard</string>
        </array>
    </dict>
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            # 已创建 .deb 框架 ✓
echo ""
echo "📦 生成的 .deb 文件:"
ls -lh "$PROJECT_DIR"/*.deb 2>/dev/null || echo "   .deb 文件待编译"

echo ""
echo "⚠️  注意:"
echo "  TrollOpenJBShortcuts.dylib 需要 arm64 交叉编译"
echo "  当前目录包含源代码，可用其他环境编译"
