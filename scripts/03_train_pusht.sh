#!/bin/bash
# ---------------------------------------------------------------------------
# 训练 SmolVLA 解决 PushT 任务 (2D 精细轨迹规划)
# 核心优化：启用国内 HF 镜像加速下载，关闭 W&B 离线训练
# ---------------------------------------------------------------------------

WORKSPACE_DIR="/home/ycx/NewDisk"
CONDA_LIB_PATH="/home/ycx/miniconda3/envs/smolvla_env/lib/libstdc++.so.6"

rm -rf ${WORKSPACE_DIR}/lerobot/outputs/train/smolvla_pusht

env -u all_proxy -u ALL_PROXY -u http_proxy -u https_proxy \
HF_ENDPOINT="https://hf-mirror.com" \
HF_HOME="${WORKSPACE_DIR}/hf_cache" \
LD_PRELOAD="${CONDA_LIB_PATH}" \
lerobot-train \
  --policy.type smolvla \
  --policy.pretrained_path lerobot/smolvla_base \
  --dataset.repo_id lerobot/pusht \
  --output_dir ${WORKSPACE_DIR}/lerobot/outputs/train/smolvla_pusht \
  --batch_size 8 \
  --steps 20000 \
  --policy.device cuda \
  --policy.use_amp True \
  --policy.push_to_hub False \
  --wandb.mode disabled
