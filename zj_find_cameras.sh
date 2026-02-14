#!/bin/bash

# 初始化micromamba shell
eval "$(micromamba shell hook --shell bash)"

# 激活lerobot环境
micromamba activate lerobot

# 切换到项目根目录
cd /Users/quantux/robot/lerobot

# 使用lerobot提供的脚本查找OpenCV相机
echo "查找OpenCV相机..."
python src/lerobot/scripts/lerobot_find_cameras.py opencv

# 使用system_profiler命令查看详细相机信息
echo "\n详细相机信息..."
system_profiler SPCameraDataType
