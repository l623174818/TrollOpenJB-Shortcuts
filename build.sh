#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════
#  TrollOpenJB - 快捷指令集成版 - 打包脚本
# ═══════════════════════════════════════════════════════════════════════════
#
#  用途：一键编译打包 TrollOpenJB 快捷指令集成版
#  使用：./build.sh
#
# ═══════════════════════════════════════════════════════════════════════════

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 项目信息
PACKAGE_NAME="TrollOpenJB-Shortcuts"
VERSION="1.3.7-shortcuts"
OUTPUT_DIR="./packages"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}  TrollOpenJB - 快捷指令集成版 - 打包脚本                ${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# 检查 Theos 环境
echo -e "${YELLOW}[1/5]${NC} 检查 Theos 环境..."
if [ -z "$THEOS" ]; then
    echo -e "${RED}✗ 错误：未找到 THEOS 环境变量${NC}"
    echo "请先安装 Theos: https://theos.dev/docs/"
    exit 1
fi
echo -e "${GREEN}✓ Theos 已配置：$THEOS${NC}"

# 检查依赖
echo -e "${YELLOW}[2/5]${NC} 检查依赖..."
for cmd in dpkg-deb make; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}✗ 错误：未找到 $cmd${NC}"
        exit 1
    fi
done
echo -e "${GREEN}✓ 依赖检查通过${NC}"

# 创建输出目录
echo -e "${YELLOW}[3/5]${NC} 创建输出目录..."
mkdir -p "$OUTPUT_DIR"
echo -e "${GREEN}✓ 输出目录：$OUTPUT_DIR${NC}"

# 编译
echo -e "${YELLOW}[4/5]${NC} 开始编译..."
echo ""

# 清理旧的构建
make clean 2>/dev/null || true

# 编译
if make package FINALPACKAGE=1; then
    echo ""
    echo -e "${GREEN}✓ 编译成功${NC}"
else
    echo -e "${RED}✗ 编译失败${NC}"
    exit 1
fi

# 复制 deb 到输出目录
echo -e "${YELLOW}[5/5]${NC} 复制 deb 包..."

# 查找编译好的 deb
DEB_FILE=$(ls -t packages/*.deb 2>/dev/null | head -1)

if [ -n "$DEB_FILE" ] && [ -f "$DEB_FILE" ]; then
    cp "$DEB_FILE" "$OUTPUT_DIR/"
    echo -e "${GREEN}✓ 已复制：$OUTPUT_DIR/$(basename $DEB_FILE)${NC}"
else
    echo -e "${YELLOW}⚠ 未找到 deb 文件，尝试手动打包...${NC}"
    
    # 手动打包
    PACKAGE_DIR="_/var/jb"
    DEBIAN_DIR="Package/DEBIAN"
    
    mkdir -p "$PACKAGE_DIR/Library/MobileSubstrate/DynamicLibraries"
    cp TrollOpenJB.dylib "$PACKAGE_DIR/Library/MobileSubstrate/DynamicLibraries/" 2>/dev/null || true
    cp TrollOpenJB.plist "$PACKAGE_DIR/Library/MobileSubstrate/DynamicLibraries/"
    
    # 创建 control 文件
    cat > "$DEBIAN_DIR/control" << 'EOF'
Package: com.charlieleung.trollopenjb.shortcuts
Name: TrollOpenJB (Shortcuts)
Version: 1.3.7-shortcuts
Architecture: iphoneos-arm64
Description: TrollOpenJB 分屏插件 - 快捷指令集成版
Maintainer: Charlie Leung + Shortcuts Integration
Section: Tweaks
Priority: optional
Depends: mobilesubstrate, firmware (>= 16.0)
Tag: role::tweak, interface::shortcut
EOF
    
    dpkg-deb --build "$PACKAGE_DIR" "$OUTPUT_DIR/trollopenjb-shortcuts_${VERSION}_iphoneos-arm64.deb"
    echo -e "${GREEN}✓ 打包完成：$OUTPUT_DIR/trollopenjb-shortcuts_${VERSION}_iphoneos-arm64.deb${NC}"
fi

# 显示结果
echo ""
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}  打包完成                                                ${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}输出文件:${NC}"
ls -lh "$OUTPUT_DIR"/*.deb
echo ""
echo -e "${YELLOW}安装方式:${NC}"
echo "  1. 上传 deb 到设备"
echo "  2. 使用 Sileo/Cydia 安装"
echo "  3. 或命令行：dpkg -i <deb 文件>"
echo ""
echo -e "${YELLOW}快捷指令 URL Scheme:${NC}"
echo "  troll-openjb://cmd_toggle_personal_hotspot"
echo "  troj://cmd_toggle_wifi"
echo ""
