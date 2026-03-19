#!/bin/bash
# 环境初始化与依赖安装脚本

# 1. 安装 LeRobot 及其依赖
git clone https://github.com/huggingface/lerobot.git
cd lerobot
pip install -e ".[smolvla]"

# 2. 安装 LIBERO 评估仿真环境
cd ..
git clone https://github.com/Lifelong-Robot-Learning/LIBERO.git
cd LIBERO
pip install -e .

# 3. 配置平台账号
echo "请根据提示登录 Hugging Face 和 WandB（请确保使用最新的安全 Token）:"
huggingface-cli login
wandb login
