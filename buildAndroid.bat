@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

:: 参数解析
set BUILD_SHARED=ON
if "%1"=="static" set BUILD_SHARED=OFF

:: 强制清理
echo [INFO] 正在清理构建目录...
rmdir /s /q build_android 2>nul
mkdir build_android

:: 编译
echo [INFO] 正在编译 (%BUILD_SHARED%)...
cd build_android
cmake ^
  -DCMAKE_TOOLCHAIN_FILE=../android_toolchain.cmake ^
  -DBUILD_SHARED_LIBS=%BUILD_SHARED% ^
  -G Ninja ..
ninja

:: 验证输出
echo [INFO] 生成结果:
dir *.so *.a

pause