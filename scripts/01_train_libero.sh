#!/bin/bash
# ---------------------------------------------------------------------------
# 训练 SmolVLA 解决 LIBERO-Spatial 任务
# 核心优化：彻底重置系统代理，切断 EGL 物理渲染导致的显存泄漏
# ---------------------------------------------------------------------------

WORKSPACE_DIR="/home/ycx/NewDisk"
CONDA_LIB_PATH="/home/ycx/miniconda3/envs/smolvla_env/lib/libstdc++.so.6"

# 清理历史训练残骸
rm -rf ${WORKSPACE_DIR}/lerobot/outputs/train/smolvla_libero_spatial

# 注入干净网络环境并启动纯净训练流
env -u all_proxy -u ALL_PROXY -u http_proxy -u https_proxy \
HTTP_PROXY="http://127.0.0.1:7897/" \
HTTPS_PROXY="http://127.0.0.1:7897/" \
PYTHONPATH="${WORKSPACE_DIR}/LIBERO:$PYTHONPATH" \
LD_PRELOAD="${CONDA_LIB_PATH}" \
lerobot-train \
  --policy.type smolvla \
  --dataset.repo_id local/libero_spatial \
  --dataset.root ${WORKSPACE_DIR}/huggingface_cache/lerobot/lerobot/libero_spatial_image \
  --output_dir ${WORKSPACE_DIR}/lerobot/outputs/train/smolvla_libero_spatial \
  --batch_size 2 \
  --steps 25000 \
  --policy.device cuda \
  --policy.use_amp True \
  --policy.push_to_hub False \
  --wandb.enable True \
  --wandb.project smolvla_libero_experiments
