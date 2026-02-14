
#!/bin/bash

# 初始化micromamba shell
eval "$(micromamba shell hook --shell bash)"

# 激活lerobot环境
micromamba activate lerobot

# 切换到项目根目录
cd /Users/quantux/robot/lerobot

# 设置DYLD_LIBRARY_PATH，优先使用cv2自带的libavdevice库
export DYLD_LIBRARY_PATH=/Users/quantux/.local/share/mamba/envs/lerobot/lib/python3.10/site-packages/cv2/.dylibs:$DYLD_LIBRARY_PATH

python src/lerobot/scripts/lerobot_teleoperate.py \
    --robot.type=so101_follower \
    --robot.port=/dev/tty.usbmodem5B3E1203541 \
    --robot.id=my_awesome_follower_arm \
    --robot.calibration_dir=/Users/quantux/.cache/huggingface/lerobot/calibration/robots/so101_follower \
    --robot.cameras="{ fixed: {type: opencv, index_or_path: 1, width: 640, height: 480, fps: 30}, handeye: {type: opencv, index_or_path: 0, width: 640, height: 480, fps: 30}}" \
    --teleop.type=so101_leader \
    --teleop.port=/dev/tty.usbmodem5B3E1198221 \
    --teleop.id=my_awesome_leader_arm \
    --teleop.calibration_dir=/Users/quantux/.cache/huggingface/lerobot/calibration/teleoperators/so101_leader \
    --display_data=true
