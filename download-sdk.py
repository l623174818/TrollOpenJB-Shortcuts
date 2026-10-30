#!/usr/bin/env python3
"""下载 iOS SDK 到 WSL"""
import os
import urllib.request
import tarfile
import hashlib

PROXY = "http://127.0.0.1:7897"

# SDK 镜像源 (多个备用)
SOURCES = [
    # DerekSelander SDKs
    "https://github.com/DerekSelander/SDKs/raw/master/iPhoneOS11.4.sdk.tar.xz",
    # xybp888 iOS-SDKs
    "https://github.com/xybp888/iOS-SDKs/raw/master/iPhoneOS11.4.sdk.tar.gz",
    # theos/sdks
    "https://github.com/theos/sdks/archive/refs/heads/master.tar.gz",
]

DOWNLOAD_DIR = "/tmp"
SDK_DEST = "/root/theos/sdks/iPhoneOS11.4.sdk"

def download_with_proxy(url, dest):
    """使用代理下载文件"""
    proxy = urllib.request.ProxyHandler({
        'http': PROXY,
        'https': PROXY
    })
    opener = urllib.request.build_opener(proxy)
    urllib.request.install_opener(opener)
    
    print(f"Downloading: {url}")
    try:
        urllib.request.urlretrieve(url, dest)
        size = os.path.getsize(dest)
        print(f"  Downloaded: {size:,} bytes ({size/1024/1024:.1f} MB)")
        return True
    except Exception as e:
        print(f"  Failed: {e}")
        return False

def extract_sdk(src, dest):
    """解压 SDK"""
    print(f"Extracting to {dest}...")
    try:
        if src.endswith('.xz'):
            import lzma
            with lzma.open(src, 'rb') as f:
                content = f.read()
            # 需要进一步处理 tar
            import io
            tar = tarfile.open(fileobj=io.BytesIO(content))
            tar.extractall(dest)
        elif src.endswith('.gz'):
            tar = tarfile.open(src, 'r:gz')
            tar.extractall(dest)
        elif src.endswith('.tar'):
            tar = tarfile.open(src, 'r')
            tar.extractall(dest)
        print("  Extracted successfully")
        return True
    except Exception as e:
        print(f"  Extract failed: {e}")
        return False

def main():
    os.makedirs(DOWNLOAD_DIR, exist_ok=True)
    os.makedirs(SDK_DEST, exist_ok=True)
    
    for i, url in enumerate(SOURCES):
        filename = f"ios_sdk_{i}.tar.xz" if "DerekSelander" in url else f"ios_sdk_{i}.tar.gz"
        filepath = os.path.join(DOWNLOAD_DIR, filename)
        
        if download_with_proxy(url, filepath):
            print("Download successful, extracting...")
            # 尝试解压
            if extract_sdk(filepath, SDK_DEST):
                print("\n✓ SDK installation complete!")
                # List contents
                for root, dirs, files in os.walk(SDK_DEST):
                    level = root.replace(SDK_DEST, '').count(os.sep)
                    indent = '  ' * level
                    print(f'{indent}{os.path.basename(root)}/')
                    if level < 2:
                        for f in files[:5]:
                            print(f'{indent}  {f}')
                return True
            else:
                print("Extract failed, trying next source...")
                if os.path.exists(filepath):
                    os.remove(filepath)
    
    print("All sources failed")
    return False

if __name__ == "__main__":
    main()
