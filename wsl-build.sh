#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════
#  TrollOpenJB - 快捷指令集成版 - WSL2 一键编译脚本
# ═══════════════════════════════════════════════════════════════════════════
#
#  用途：在 WSL2 环境中编译打包 TrollOpenJB-Shortcuts
#  使用：wsl ./wsl-build.sh
#
# ═══════════════════════════════════════════════════════════════════════════

set -e

cd ~/AI/TrollOpenJB-Shortcuts

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  TrollOpenJB - 快捷指令集成版 - WSL2 编译                    ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# 检查 Theos
if [ -z "$THEOS" ]; then
    echo "❌ 未找到 THEOS 环境变量"
    echo "请在 ~/.bashrc 中添加:"
    echo "  export THEOS=/root/theos"
    echo "  export PATH=\$THEOS/bin:\$PATH"
    exit 1
fi

echo "✅ Theos: $THEOS"
echo ""

# 清理旧构建
echo "🧹 清理旧构建..."
make clean 2>/dev/null || true

# 编译
echo "🔨 开始编译..."
echo ""

if make package FINALPACKAGE=1; then
    echo ""
    echo "✅ 编译成功!"
    echo ""
    echo "📦 输出文件:"
    ls -lh packages/*.deb
    echo ""
    echo "📥 复制 Windows 目录..."
    
    # 复制到 Windows 可访问目录
    cp packages/*.deb /mnt/c/Users/fslu/AI/TrollOpenJB-Shortcuts/packages/ 2>/dev/null || true
    
    echo ""
    echo "✅ 完成！"
    echo "   deb 文件位置：/mnt/c/Users/fslu/AI/TrollOpenJB-Shortcuts/packages/"
else
    echo "❌ 编译失败"
    exit 1
fi
