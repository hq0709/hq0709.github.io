#!/bin/bash

echo "=========================================="
echo "  快速部署到 GitHub Pages"
echo "=========================================="
echo ""

# 检查是否在正确的目录
if [ ! -f "_config.yml" ]; then
    echo "❌ 错误：请在项目根目录运行此脚本"
    exit 1
fi

echo "📝 当前目录："
pwd
echo ""

# 检查 git 是否已初始化
if [ ! -d ".git" ]; then
    echo "🔧 初始化 Git 仓库..."
    git init
    echo "✅ Git 初始化完成"
    echo ""
fi

# 添加所有文件
echo "📦 添加文件到 Git..."
git add .
echo ""

# 提交
echo "💾 提交更改..."
git commit -m "Migrate website to new template" 2>/dev/null || git commit -m "Update website"
echo ""

# 检查是否已有远程仓库
if git remote get-url origin &>/dev/null; then
    echo "✅ 远程仓库已配置"
    echo ""
else
    echo "⚠️  需要配置远程仓库"
    echo ""
    echo "请输入您的 GitHub 仓库地址（例如：https://github.com/hq0709/hq0709.github.io.git）："
    read -r repo_url
    
    if [ -z "$repo_url" ]; then
        echo "❌ 未输入仓库地址，退出"
        exit 1
    fi
    
    git remote add origin "$repo_url"
    echo "✅ 远程仓库已添加"
    echo ""
fi

# 创建 main 分支（如果需要）
current_branch=$(git branch --show-current 2>/dev/null)
if [ "$current_branch" != "main" ]; then
    echo "🔄 切换到 main 分支..."
    git branch -M main
    echo ""
fi

# 推送
echo "🚀 推送到 GitHub..."
echo ""
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "  ✅ 部署成功！"
    echo "=========================================="
    echo ""
    echo "📍 下一步："
    echo ""
    echo "1. 访问您的 GitHub 仓库"
    echo "2. 进入 Settings → Pages"
    echo "3. 选择："
    echo "   - Source: Deploy from branch"
    echo "   - Branch: main"
    echo "   - Folder: / (root)"
    echo "4. 点击 Save"
    echo "5. 等待 1-3 分钟"
    echo "6. 访问您的网站！"
    echo ""
    echo "=========================================="
else
    echo ""
    echo "❌ 推送失败"
    echo ""
    echo "可能的原因："
    echo "1. 需要先在 GitHub 创建仓库"
    echo "2. 需要配置 Git 认证"
    echo "3. 仓库地址不正确"
    echo ""
    echo "请手动执行："
    echo "  git push -u origin main"
    echo ""
fi
