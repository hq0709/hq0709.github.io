# Hanqi Jiang 的学术个人主页

这是 Hanqi Jiang（蒋瀚祺）的学术个人主页，基于优秀的 Jekyll 模版构建。

## 🎓 关于我

- 🏫 博士生 @ University of Georgia
- 👨‍🏫 导师：Distinguished Research Professor [Tianming Liu](https://cobweb.cs.uga.edu/~tliu/)
- 🔬 研究方向：Multi-modal Large Language Models, Medical Image Analysis
- 📍 实习：Harvard Medical School & Massachusetts General Hospital

## 🚀 快速开始

### 本地预览

#### 方法一：使用启动脚本（推荐）

```bash
./启动服务器.sh
```

#### 方法二：手动启动

```bash
# 首次运行需要安装依赖
bundle install

# 启动服务器
bundle exec jekyll serve
```

然后在浏览器访问：`http://localhost:4000`

## 📁 项目结构

```
hanqi-new-site/
├── 📄 index.html                 # 主页
├── 📄 publications.html          # 论文列表页
├── 📄 _config.yml               # Jekyll 配置
│
├── 📂 _data/                    # 数据配置
│   ├── profile.yml              # 👤 个人信息（重要！）
│   ├── navigation.yml           # 导航栏配置
│   └── display.yml              # 显示设置
│
├── 📂 _publications/            # 📚 论文文件
│   └── 2025/                   # 按年份组织
│       ├── egma.md             # NeurIPS 2024
│       ├── echopulse.md        # ICLR 2025
│       └── ...                 # 其他论文
│
├── 📂 _news/                    # 📰 新闻动态
│   ├── 2025-news1.md
│   ├── 2024-news1.md
│   └── ...
│
├── 📂 assets/                   # 静态资源
│   ├── images/
│   │   ├── covers/             # 📷 论文配图
│   │   ├── photos/             # 🖼️ 个人照片
│   │   └── badges/             # 🏛️ 学校徽章
│   ├── css/                    # 样式文件
│   └── js/                     # JavaScript 文件
│
└── 📂 _includes/                # 页面组件
    └── widgets/                # 各种小部件
```

## 📝 内容更新指南

### 更新个人信息

编辑 `_data/profile.yml` 文件：

```yaml
primary_name: "Your Name"
email: "your.email@domain.com"
short_bio: >-
  Your biography here...
education:
  - name: University Name
    position: Degree
    date: Start - End
```

### 添加新论文

1. 在 `_publications/2025/` 目录下创建新的 `.md` 文件
2. 使用以下模版：

```yaml
---
title:          Paper Title
date:           2025-01-01 00:00:00 -0400
selected:       true  # 是否在主页显示
pub:            "Conference/Journal Name"
pub_last:       ' <span class="badge">Conference</span>'
pub_date:       "2025"

abstract: >-
  Your abstract here...
  
cover:          assets/images/covers/your-image.png
authors:
  - Author 1
  - Author 2†
links:
  Paper: https://arxiv.org/...
  Code: https://github.com/...
---
```

### 添加新闻

在 `_news/` 目录下创建新的 `.md` 文件：

```yaml
---
title: >-
    🎉 Your news here!
date: 2025-01-01 00:00:00 -0400
---
```

### 添加论文配图

1. 将图片放到 `assets/images/covers/` 目录
2. 在论文的 `.md` 文件中更新 `cover:` 字段
3. 推荐尺寸：800x600 或更大

## 📋 待办事项

查看 `TODO.md` 和 `IMAGES_NEEDED.md` 了解还需要补充的内容。

### 主要待补充内容：

- [ ] 11篇论文的配图
- [ ] 4个学校/机构的徽章
- [ ] CV/简历文件

详细信息请查看 `IMAGES_NEEDED.md` 文件。

## 📚 当前统计

- ✅ **14篇论文**（包括 NeurIPS, ICLR, ECCV 等顶会和 IEEE TNNLS, IEEE TBME 等顶刊）
- ✅ **17条新闻**（从2022年至今）
- ✅ **3个教育背景**
- ✅ **4段工作经历**
- ✅ **5项荣誉奖项**

## 🎨 自定义样式

如需修改网站外观：

- 全局样式：`assets/css/global.css`
- 颜色主题：在 `_data/profile.yml` 或 CSS 文件中修改
- 字体：编辑 CSS 文件中的 `font-family`

## 📖 重要文档

| 文档 | 说明 |
|------|------|
| `迁移完成说明.md` | ✅ 迁移工作总结 |
| `README_MIGRATION.md` | 📖 详细迁移文档 |
| `IMAGES_NEEDED.md` | 🖼️ 图片补充清单 |
| `TODO.md` | ☑️ 待办事项 |

## 🔧 技术栈

- **静态网站生成器**: [Jekyll](https://jekyllrb.com/)
- **前端框架**: Bootstrap
- **图标**: Font Awesome
- **托管**: GitHub Pages

## 📞 联系方式

- 📧 Email: hanqi.jiang@uga.edu
- 📧 Email (MGH): hjiang81@mgh.harvard.edu
- 🔬 Google Scholar: [Profile](https://scholar.google.com/citations?user=adC1a0IAAAAJ)
- 💻 GitHub: [@hq0709](https://github.com/hq0709)
- 🔗 LinkedIn: [hanqi-jiang-024b622b6](https://www.linkedin.com/in/hanqi-jiang-024b622b6)

## 📄 许可证

本项目基于开源模版修改，遵循相应的开源协议。

---

**最后更新**: 2024年10月4日  
**模版来源**: yPanStupidog.github.io  
**内容来源**: hq0709.github.io

Made with ❤️ by Hanqi Jiang