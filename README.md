# Embodied-VLA-Pipeline: Training SmolVLA on Consumer GPUs

本仓库包含了基于端到端视觉-语言-动作（VLA）架构，在受限算力环境（单卡 8GB 显存）下，完成 SmolVLA 大模型在 LIBERO-Spatial 等具身智能数据集上的全链路微调与物理仿真闭环部署代码。

## 🚀 核心亮点
- **硬件极限突围**：在单张 NVIDIA RTX 5060 (8GB VRAM) 上成功跑通 4.5 亿参数模型的端到端训练与 3D 物理仿真。
- **OOM 显存优化**：针对多任务联合渲染导致的严重显存溢出（OOM）问题，实施“训练与评估管线彻底分离”策略，通过 `task_ids` 单任务队列测试，成功将 EGL 后台渲染显存峰值压缩至硬件极限内。
- **网络与工程排障**：使用 `env -u` 彻底重置系统底层代理流，解决 Hugging Face 隐形 `socks://` 代理报错，实现离线纯净训练流。
- **Zero-shot 评估结果**：在极具挑战的 3D 复杂空间关系推理（Spatial Grounding）任务中取得最高 80% 的操控成功率。

---

## 🎬 抓取评估演示 (Evaluation Demos)
*以下视频均为模型在零样本初始化场景下，基于自然语言指令实时推理生成的连续动作控制录像。*

**Task 1: PushT 数据集 (2D 精细轨迹规划)**
> 🤖 **Task Description:** *Push the T-shaped block to the target zone (2D Spatial Planning)*

https://github.com/user-attachments/assets/a0682eaa-ebce-41d9-88c6-5dcd5113a451

**Task 2: 抓取靠近盘子的黑碗 (Spatial Reasoning: Proximity)**
> 🗣️ **Language Instruction:** *"pick up the black bowl next to the plate and place it on the plate"*

https://github.com/user-attachments/assets/3f56add5-e58d-4ab3-a005-e93a8f479258

**Task 3: 抓取饼干盒旁的黑碗 (Spatial Reasoning: Object Reference)**
> 🗣️ **Language Instruction:** *"pick up the black bowl next to the cookie box and place it on the plate"*

https://github.com/user-attachments/assets/13cd07a0-90d7-4f1a-bcf9-b61b5030ff5a

<details>
<summary><b>点击展开查看更多复杂空间抓取任务测试 (Click to expand more demos)</b></summary>
<br>

**Task 4: 抓取顶层抽屉的黑碗 (Spatial Reasoning: Inside)**
> 🗣️ **Language Instruction:** *"pick up the black bowl in the top drawer of the wooden cabinet and place it on the plate"*

https://github.com/user-attachments/assets/8429a8b6-be75-4f81-ae20-ad27b78c83a9

**Task 5: 抓取烤钵上的黑碗 (Spatial Reasoning: On top of)**
> 🗣️ **Language Instruction:** *"pick up the black bowl on the ramekin and place it on the plate"*

https://github.com/user-attachments/assets/dcb37b34-cea7-4605-ade3-dae530978f4d

**Task 6: 抓取柜子顶层的黑碗 (Spatial Reasoning: Height Reference)**
> 🗣️ **Language Instruction:** *"pick up the black bowl on the wooden cabinet and place it on the plate"*

https://github.com/user-attachments/assets/8b4a5536-f3ee-4a9f-b3f1-b1bdcb29b11a

</details>

---

## 📂 仓库结构
- `scripts/00_setup_env.sh`: 环境依赖初始化与账号配置。
- `scripts/01_train_libero.sh`: 解决网络代理与显存泄露的纯净版训练脚本。
- `scripts/02_eval_libero.sh`: 隔离无头渲染环境的单并发评估脚本。

## 🛠️ 快速开始
```bash
# 赋予脚本执行权限
chmod +x scripts/*.sh

# 执行训练管线
./scripts/01_train_libero.sh

# 执行评估管线
./scripts/02_eval_libero.sh
