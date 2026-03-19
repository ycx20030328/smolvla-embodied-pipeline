#!/bin/bash
# 评估 SmolVLA 在 PushT 环境的 2D 轨迹规划能力

WORKSPACE_DIR="/home/ycx/NewDisk"
CONDA_LIB_PATH="/home/ycx/miniconda3/envs/smolvla_env/lib/libstdc++.so.6"
POLICY_PATH="${WORKSPACE_DIR}/lerobot/outputs/train/smolvla_pusht/checkpoints/last/pretrained_model"

env -u all_proxy -u ALL_PROXY -u http_proxy -u https_proxy \
LD_PRELOAD="${CONDA_LIB_PATH}" \
MUJOCO_GL=egl PYOPENGL_PLATFORM=egl \
lerobot-eval \
  --policy.type smolvla \
  --policy.pretrained_path ${POLICY_PATH} \
  --env.type gym \
  --env.task pusht \
  --eval.n_episodes 10 \
  --eval.batch_size 1 \
  --policy.device cuda \
  --policy.use_amp true
