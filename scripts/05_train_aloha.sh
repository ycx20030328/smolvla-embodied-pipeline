#!/bin/bash
# ---------------------------------------------------------------------------
# 训练 SmolVLA 解决 ALOHA/SO100 复杂堆叠与抓取任务
# ---------------------------------------------------------------------------

WORKSPACE_DIR="/home/ycx/NewDisk"
CONDA_LIB_PATH="/home/ycx/miniconda3/envs/smolvla_env/lib/libstdc++.so.6"

rm -rf ${WORKSPACE_DIR}/lerobot/outputs/train/smolvla_aloha_stacking

env -u all_proxy -u ALL_PROXY -u http_proxy -u https_proxy \
HF_ENDPOINT="https://hf-mirror.com" \
HF_HOME="${WORKSPACE_DIR}/hf_cache" \
LD_PRELOAD="${CONDA_LIB_PATH}" \
lerobot-train \
  --policy.type smolvla \
  --policy.pretrained_path lerobot/smolvla_base \
  --dataset.repo_id lerobot/svla_so100_stacking \
  --output_dir ${WORKSPACE_DIR}/lerobot/outputs/train/smolvla_aloha_stacking \
  --batch_size 8 \
  --steps 20000 \
  --policy.device cuda \
  --policy.use_amp True \
  --policy.push_to_hub False \
  --wandb.mode disabled
