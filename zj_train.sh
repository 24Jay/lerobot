#!/bin/bash
# 初始化micromamba shell
eval "$(micromamba shell hook --shell bash)"

# 激活lerobot环境
micromamba activate lerobot
ds_root=/Users/quantux/.cache/huggingface/datasets/lerobot_v3/demo

# 从命令行参数获取policy类型，如果没有指定则默认为act
if [ $# -eq 1 ]; then
    policy=$1
else
    policy=act
fi
device=mps

echo "ds_root: "${ds_root}
echo "policy: "${policy}
echo "device: "${device}


python src/lerobot/scripts/lerobot_train.py \
	--dataset.repo_id=demo \
	--dataset.root=${ds_root} \
	--policy.type=${policy} \
	--output_dir=outputs/train/${policy}_so101_test \
	--job_name=${policy}_so101_test \
	--policy.device=${device} \
	--wandb.enable=false \
	--policy.push_to_hub=false
