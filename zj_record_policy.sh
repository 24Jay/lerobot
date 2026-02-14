#!/bin/bash
HF_USER=quantux

port=/dev/tty.usbmodem5B3E1203541

# 初始化micromamba shell
eval "$(micromamba shell hook --shell bash)"

# 激活lerobot环境
micromamba activate lerobot

# 切换到项目根目录
cd /Users/quantux/robot/lerobot

# 设置DYLD_LIBRARY_PATH，优先使用cv2自带的libavdevice库
export DYLD_LIBRARY_PATH=/Users/quantux/.local/share/mamba/envs/lerobot/lib/python3.10/site-packages/cv2/.dylibs:$DYLD_LIBRARY_PATH

# 删除已存在的数据集目录
rm -rf /Users/quantux/.cache/huggingface/lerobot/quantux/eval_so101_new

python src/lerobot/scripts/lerobot_record.py \
    --robot.type=so101_follower \
    --robot.port=${port} \
    --robot.id=my_awesome_follower_arm \
    --robot.calibration_dir=/Users/quantux/.cache/huggingface/lerobot/calibration/robots/so101_follower \
    --robot.cameras="{ handeye: {type: opencv,index_or_path: 0, width: 640, height: 480, fps: 30}, front: {type: opencv,index_or_path: 1, width: 640, height: 480, fps: 30}}"\
     --display_data=true \
     --display_compressed_images=false \
     --dataset.repo_id=${HF_USER}/eval_so101_new \
     --dataset.single_task="Grab the screwdriver" \
     --dataset.push_to_hub=false \
     --policy.path=./models/smolvla/006000/pretrained_model