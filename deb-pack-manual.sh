#!/bin/bash
# 手动创建 TrollOpenJB-Shortcuts .deb 包 (无需完整 Theos 环境)

set -e

PROJECT_DIR="/mnt/c/Users/fslu/AI/TrollOpenJB-Shortcuts"
PACKAGE_NAME="com.charlieleung.trollopenjb.shortcuts"
VERSION="1.3.8"
ARCH="arm64"

echo "=== 创建 TrollOpenJB-Shortcuts .deb 包 ==="
echo "版本: $VERSION"
echo "架构: $ARCH"

# 创建临时目录
WORK_DIR="/tmp/trollopenjb-build"
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR/data/var/jb/Library/MobileSubstrate/DynamicLibraries"
mkdir -p "$WORK_DIR/data/var/jb/Library/ApplicationSupport/TrollOpenJB-Shortcuts"
mkdir -p "$WORK_DIR/control"

# 1. 复制 dylib (需要 arm64 编译版本，这里用占位符)
echo "准备 TrollOpenJBShortcuts.dylib..."
# 实际编译需要交叉编译器，这里创建空文件占位
touch "$WORK_DIR/data/var/jb/Library/MobileSubstrate/DynamicLibraries/TrollOpenJBShortcuts.dylib"

# 2. 复制配置文件
cat > "$WORK_DIR/data/var/jb/Library/MobileSubstrate/DynamicLibraries/TrollOpenJBShortcuts.plist" << 'PLIST'
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
            <key>CFBundleURLName</key>
            <string>TrollOpenJB Shortcuts</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>troll-openjb</string>
                <string>troj</string>
            </array>
        </dict>
    </array>
</dict>
</plist>
PLIST

echo "✓ 配置文件已创建"

# 3. 创建 control 文件
cat > "$WORK_DIR/control/control" << CONTROL
Package: $PACKAGE_NAME
Name: TrollOpenJB-Shortcuts
Version: $VERSION
Architecture: $ARCH
Maintainer: FS Lu
Depends: firmware (>= 14.0), mobilesubstrate
Description: TrollOpenJB with URL Scheme support for Shortcuts
 支持通过快捷指令 URL 直接调用 53 个系统控制命令
URL Scheme: troll-openjb://cmd_toggle_wifi, troj://cmd_toggle_wifi
CONTROL

cat > "$WORK_DIR/control/compatversion" << COMPAT
2
COMPAT

# 4. 创建 postinst 脚本
cat > "$WORK_DIR/control/postinst" << 'POSTINST'
#!/bin/sh
killall -9 SpringBoard
echo "TrollOpenJB-Shortcuts 安装完成!"
echo "使用快捷指令调用：shortcuts://x-callback-url/run-shortcut?name=Toggle%20WiFi"
echo "或直接 URL: troll-openjb://cmd_toggle_wifi"
exit 0
POSTINST

chmod +x "$WORK_DIR/control/postinst"

echo "✓ control 文件已创建"

# 创建 data.tar.gz 和 control.tar.gz
cd "$WORK_DIR"
tar -czf data.tar.gz -C data .
tar -czf control.tar.gz -C control .

# 创建 Debian binary 包
echo "创建 .deb 文件..."
ar rcs "$WORK_DIR/$PACKAGE_NAME_${VERSION}_${ARCH}.deb" debian-binary control.tar.gz data.tar.gz

# 复制输出到项目目录
cp "$WORK_DIR/$PACKAGE_NAME_${VERSION}_${ARCH}.deb" "$PROJECT_DIR/"

echo ""
echo "✓ .deb 包已生成:"
ls -lh "$PROJECT_DIR/$PACKAGE_NAME_${VERSION}_${ARCH}.deb"
echo ""
echo "⚠️  注意：dylib 为占位符，完整功能需要 arm64 交叉编译"
