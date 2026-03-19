#!/bin/bash
# 评估 SmolVLA 在 ALOHA 架构下的协同抓取能力

WORKSPACE_DIR="/home/ycx/NewDisk"
CONDA_LIB_PATH="/home/ycx/miniconda3/envs/smolvla_env/lib/libstdc++.so.6"
POLICY_PATH="${WORKSPACE_DIR}/lerobot/outputs/train/smolvla_aloha_stacking/checkpoints/last/pretrained_model"

env -u all_proxy -u ALL_PROXY -u http_proxy -u https_proxy \
LD_PRELOAD="${CONDA_LIB_PATH}" \
MUJOCO_GL=egl PYOPENGL_PLATFORM=egl \
lerobot-eval \
  --policy.type smolvla \
  --policy.pretrained_path ${POLICY_PATH} \
  --env.type aloha \
  --env.task aloha_sim_insertion \
  --eval.n_episodes 10 \
  --eval.batch_size 1 \
  --policy.device cuda \
  --policy.use_amp true
