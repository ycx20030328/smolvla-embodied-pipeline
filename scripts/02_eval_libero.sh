#!/bin/bash
# ---------------------------------------------------------------------------
# 评估 SmolVLA 的 3D 空间抓取泛化能力
# 核心优化：引入 EGL 无头渲染，通过 task_ids 限制单并发，防止显存溢出
# ---------------------------------------------------------------------------

WORKSPACE_DIR="/home/ycx/NewDisk"
CONDA_LIB_PATH="/home/ycx/miniconda3/envs/smolvla_env/lib/libstdc++.so.6"
POLICY_PATH="${WORKSPACE_DIR}/lerobot/outputs/train/smolvla_libero_spatial/checkpoints/last/pretrained_model"

env -u all_proxy -u ALL_PROXY -u http_proxy -u https_proxy \
HTTP_PROXY="http://127.0.0.1:7897/" \
HTTPS_PROXY="http://127.0.0.1:7897/" \
PYTHONPATH="${WORKSPACE_DIR}/LIBERO:$PYTHONPATH" \
LD_PRELOAD="${CONDA_LIB_PATH}" \
MUJOCO_GL=egl PYOPENGL_PLATFORM=egl \
lerobot-eval \
  --policy.type smolvla \
  --policy.pretrained_path ${POLICY_PATH} \
  --env.type libero \
  --env.task libero_spatial \
  --env.task_ids "[9]" \
  --eval.n_episodes 10 \
  --eval.batch_size 1 \
  --policy.device cuda \
  --policy.use_amp true
