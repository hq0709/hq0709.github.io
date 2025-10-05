# 需要补充的图片清单

## 论文配图

所有论文配图应保存到：`assets/images/covers/`

建议图片尺寸：至少 800x600 像素，推荐 1200x800 像素
格式：PNG 或 JPG

### 需要添加的论文配图（11篇）

1. **aqcf.png**
   - 论文：Bridging Classical and Quantum Computing for Next-Generation Language Models
   - 会议：AAAI QIML 2025
   - 对应文件：`_publications/2025/aqcf.md`

2. **chatradio-valuer.png**
   - 论文：Chatradio-valuer
   - 期刊：IEEE Transactions on Biomedical Engineering
   - 对应文件：`_publications/2025/chatradio-valuer.md`

3. **molqae.png**
   - 论文：MolQAE: Quantum Autoencoder for Molecular Representation Learning
   - 会议：QAI 2025
   - 对应文件：`_publications/2025/molqae.md`

4. **argus.png**
   - 论文：Argus: Leveraging Multi-View Images for Improved 3D Scene Understanding
   - 期刊：IEEE Transactions on Neural Networks and Learning Systems
   - 对应文件：`_publications/2025/argus.md`

5. **eg-spikeformer.png**
   - 论文：EG-SpikeFormer
   - 会议：ISBI 2025 (Oral)
   - 对应文件：`_publications/2025/eg-spikeformer.md`

6. **geodreamer.png**
   - 论文：GeoDreamer
   - 会议：AAAI 2025
   - 对应文件：`_publications/2025/geodreamer.md`

7. **depth-neus.png**
   - 论文：Depth-NeuS
   - 会议：ICIC 2024 (Oral)
   - 对应文件：`_publications/2025/depth-neus.md`

8. **agi-medical.png**
   - 论文：Artificial General Intelligence for Medical Imaging Analysis
   - 期刊：IEEE Reviews in Biomedical Engineering (Feature Article)
   - 对应文件：`_publications/2025/agi-medical.md`

9. **radiology-gpt.png**
   - 论文：Radiology-GPT
   - 会议：MICCAI 2024 Workshop
   - 对应文件：`_publications/2025/radiology-gpt.md`

10. **llm-robotics.png**
    - 论文：Large Language Models for Robotics
    - 期刊：Journal of Automation and Intelligence
    - 对应文件：`_publications/2025/llm-robotics.md`

11. **mfe-ssnet.png**
    - 论文：MFE-SSNet
    - 期刊：Automotive Innovation
    - 对应文件：`_publications/2025/mfe-ssnet.md`

---

## 学校/机构徽章

所有徽章应保存到：`assets/images/badges/`

建议尺寸：200x200 像素（正方形）
格式：PNG（推荐透明背景）

### 需要添加的徽章（4个）

1. **lancaster.png**
   - 学校：Lancaster University
   - 用途：教育背景

2. **bjtu.png**
   - 学校：Beijing Jiaotong University
   - 用途：教育背景

3. **cuhk.png**
   - 学校：Chinese University of Hong Kong (Shenzhen)
   - 用途：工作经历

4. **ictcas.png**
   - 机构：Institute of Computing Technology, Chinese Academy of Sciences
   - 用途：工作经历

---

## 如何添加图片

### 添加论文配图

1. 将图片文件复制到 `assets/images/covers/` 目录
2. 打开对应的论文 markdown 文件（在 `_publications/2025/` 目录）
3. 找到 `cover:` 这一行
4. 将 `placeholder.png` 替换为你的图片文件名

例如：
```yaml
# 修改前
cover: assets/images/covers/placeholder.png

# 修改后
cover: assets/images/covers/aqcf.png
```

### 添加学校徽章

1. 将徽章文件复制到 `assets/images/badges/` 目录
2. 打开 `_data/profile.yml`
3. 在 `education:` 或 `experience:` 部分找到对应条目
4. 确认 `logo:` 字段指向正确的文件路径

例如：
```yaml
education:
- name: Lancaster University
  logo: assets/images/badges/lancaster.png  # 确保这个路径正确
  position: B.S. in Computer Science
  date: Sep. 2019 - Jul. 2023
```

---

## 图片来源建议

1. **论文配图**：
   - 从论文 PDF 中截取关键示意图
   - 使用论文的架构图、流程图或主要结果图
   - 确保图片清晰，文字可读

2. **学校徽章**：
   - 从学校官网下载官方 Logo
   - 使用维基百科的学校徽章
   - 搜索 "学校名称 + logo png transparent"

---

## 当前已有的图片

✅ **已添加的论文配图：**
- eye.png (NeurIPS 2024)
- hybrid.png (ECCV 2024)
- pipeline_EchoPulse.png (ICLR 2025)

✅ **已添加的徽章：**
- uga.png (University of Georgia)
- hms.jpg (Harvard Medical School)

✅ **其他图片：**
- hanqi.jpg (个人头像)
- placeholder.png (占位符)
