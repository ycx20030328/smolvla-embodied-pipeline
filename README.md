# Embodied-VLA-Pipeline: Training SmolVLA on Consumer GPUs
https://github.com/user-attachments/assets/a0682eaa-ebce-41d9-88c6-5dcd5113a451
https://github.com/user-attachments/assets/3f56add5-e58d-4ab3-a005-e93a8f479258
https://github.com/user-attachments/assets/13cd07a0-90d7-4f1a-bcf9-b61b5030ff5a
https://github.com/user-attachments/assets/8429a8b6-be75-4f81-ae20-ad27b78c83a9
https://github.com/user-attachments/assets/dcb37b34-cea7-4605-ade3-dae530978f4d
https://github.com/user-attachments/assets/8b4a5536-f3ee-4a9f-b3f1-b1bdcb29b11a


本仓库包含了基于端到端视觉-语言-动作（VLA）架构，在受限算力环境（单卡 8GB 显存）下，完成 SmolVLA 大模型在 LIBERO-Spatial 等具身智能数据集上的全链路微调与物理仿真闭环部署代码。

- **硬件极限突围**：在单张 NVIDIA RTX 5060 (8GB VRAM) 上成功跑通 4.5 亿参数模型的端到端训练与 3D 物理仿真。
- **OOM 显存优化**：针对多任务联合渲染导致的严重显存溢出（OOM）问题，实施“训练与评估管线彻底分离”策略，通过 `task_ids` 单任务队列测试，成功将 EGL 后台渲染显存峰值压缩至硬件极限内。
- **网络与工程排障**：使用 `env -u` 彻底重置系统底层代理流，解决 Hugging Face 隐形 `socks://` 代理报错，实现离线纯净训练流。
- **Zero-shot 评估结果**：在极具挑战的 3D 复杂空间关系推理（Spatial Grounding）任务中取得最高 80% 的操控成功率。

## 📂 仓库结构
- `scripts/00_setup_env.sh`: 环境依赖初始化与账号配置。
- `scripts/01_train_libero.sh`: 解决网络代理与显存泄露的纯净版训练脚本。
- `scripts/02_eval_libero.sh`: 隔离无头渲染环境的单并发评估脚本。

## 🛠️ 快速开始
```bash
chmod +x scripts/*.sh
./scripts/01_train_libero.sh




