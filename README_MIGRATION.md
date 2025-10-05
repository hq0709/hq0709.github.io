# 网站迁移说明

这是从 hq0709.github.io 迁移到新模版的网站。

## 已完成的迁移内容

### 1. 个人信息
- ✅ 基本信息（姓名、邮箱、社交媒体链接等）
- ✅ 个人简介
- ✅ 教育背景
- ✅ 工作经历
- ✅ 荣誉奖项
- ✅ 学术服务

### 2. 论文列表
已迁移的论文：
- ✅ Eye-gaze Guided Multi-modal Alignment (NeurIPS 2024) - 有配图
- ✅ HybridMED (ECCV 2024 Workshop) - 有配图
- ✅ ECHOPulse (ICLR 2025) - 有配图
- ✅ Bridging Classical and Quantum Computing (AAAI QIML)
- ✅ ChatRadio-Valuer (IEEE TBME)
- ✅ MolQAE (QAI 2025)
- ✅ Argus (IEEE TNNLS)
- ✅ EG-SpikeFormer (ISBI 2025)
- ✅ GeoDreamer (AAAI 2025)
- ✅ Depth-NeuS (ICIC 2024)
- ✅ AGI for Medical Imaging (IEEE RBME)
- ✅ Radiology-GPT (MICCAI 2024 Workshop)
- ✅ LLM for Robotics (Journal of Automation and Intelligence)
- ✅ MFE-SSNet (Automotive Innovation)

### 3. 新闻动态
- ✅ 2025年新闻 (8条)
- ✅ 2024年新闻 (6条)
- ✅ 2023年新闻 (2条)
- ✅ 2022年新闻 (1条)

### 4. 图片资源
已复制的图片：
- ✅ eye.png (NeurIPS 2024 论文配图)
- ✅ hybrid.png (ECCV 2024 论文配图)
- ✅ pipeline_EchoPulse.png (ICLR 2025 论文配图)
- ✅ hanqi.jpg (个人头像)
- ✅ placeholder.png (占位符图片)

## 待补充内容

### 论文配图
以下论文目前使用占位符图片 (placeholder.png)，需要后续添加实际配图：

1. **Bridging Classical and Quantum Computing** (AAAI QIML)
   - 文件位置：`_publications/2025/aqcf.md`
   - 需要图片：建议命名为 `aqcf.png`

2. **ChatRadio-Valuer** (IEEE TBME)
   - 文件位置：`_publications/2025/chatradio-valuer.md`
   - 需要图片：建议命名为 `chatradio-valuer.png`

3. **MolQAE** (QAI 2025)
   - 文件位置：`_publications/2025/molqae.md`
   - 需要图片：建议命名为 `molqae.png`

4. **Argus** (IEEE TNNLS)
   - 文件位置：`_publications/2025/argus.md`
   - 需要图片：建议命名为 `argus.png`

5. **EG-SpikeFormer** (ISBI 2025)
   - 文件位置：`_publications/2025/eg-spikeformer.md`
   - 需要图片：建议命名为 `eg-spikeformer.png`

6. **GeoDreamer** (AAAI 2025)
   - 文件位置：`_publications/2025/geodreamer.md`
   - 需要图片：建议命名为 `geodreamer.png`

7. **Depth-NeuS** (ICIC 2024)
   - 文件位置：`_publications/2025/depth-neus.md`
   - 需要图片：建议命名为 `depth-neus.png`

8. **AGI for Medical Imaging** (IEEE RBME)
   - 文件位置：`_publications/2025/agi-medical.md`
   - 需要图片：建议命名为 `agi-medical.png`

9. **Radiology-GPT** (MICCAI 2024 Workshop)
   - 文件位置：`_publications/2025/radiology-gpt.md`
   - 需要图片：建议命名为 `radiology-gpt.png`

10. **LLM for Robotics** (Journal of Automation and Intelligence)
    - 文件位置：`_publications/2025/llm-robotics.md`
    - 需要图片：建议命名为 `llm-robotics.png`

11. **MFE-SSNet** (Automotive Innovation)
    - 文件位置：`_publications/2025/mfe-ssnet.md`
    - 需要图片：建议命名为 `mfe-ssnet.png`

### 学校/机构徽章
可能还需要添加的徽章图片（放在 `assets/images/badges/` 目录）：
- Lancaster University (lancaster.png)
- Beijing Jiaotong University (bjtu.png)
- CUHK(SZ) (cuhk.png)
- ICTCAS (ictcas.png)

## 添加论文配图的步骤

1. 将图片文件复制到 `assets/images/covers/` 目录
2. 编辑对应的论文 markdown 文件（在 `_publications/2025/` 目录下）
3. 修改 `cover:` 字段，将 `placeholder.png` 替换为实际图片文件名
   ```yaml
   cover: assets/images/covers/your-image.png
   ```

## 如何运行网站

1. 确保安装了 Jekyll 和相关依赖：
   ```bash
   bundle install
   ```

2. 本地运行：
   ```bash
   bundle exec jekyll serve
   ```

3. 在浏览器中访问：`http://localhost:4000`

## 目录结构

```
hanqi-new-site/
├── _config.yml           # Jekyll 配置文件
├── _data/
│   └── profile.yml       # 个人信息配置
├── _publications/        # 论文文件夹
│   └── 2025/            # 按年份组织
├── _news/               # 新闻动态文件夹
├── assets/
│   └── images/
│       ├── covers/      # 论文配图
│       ├── photos/      # 个人照片
│       └── badges/      # 学校/机构徽章
└── index.html           # 主页

```

## 注意事项

- 所有论文配图建议尺寸：至少 800x600 像素
- 图片格式：PNG 或 JPG
- 个人头像建议为正方形
- 徽章图片建议为透明背景的 PNG 文件
