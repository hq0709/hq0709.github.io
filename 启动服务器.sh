#!/bin/bash

# 网站本地预览启动脚本

echo "=========================================="
echo "  Hanqi Jiang 的学术网站本地预览"
echo "=========================================="
echo ""
echo "正在启动 Jekyll 服务器..."
echo ""

# 检查是否安装了 bundle
if ! command -v bundle &> /dev/null
then
    echo "❌ 错误: 未检测到 bundle 命令"
    echo "请先安装 Jekyll 和 Bundler:"
    echo "  gem install jekyll bundler"
    exit 1
fi

# 安装依赖（如果需要）
if [ ! -d "vendor/bundle" ]; then
    echo "📦 首次运行，正在安装依赖..."
    bundle install
    echo ""
fi

# 启动 Jekyll 服务器
echo "🚀 启动服务器..."
echo "📝 网站将在以下地址打开："
echo "   http://localhost:4000"
echo ""
echo "💡 提示："
echo "   - 按 Ctrl+C 停止服务器"
echo "   - 修改文件后会自动重新生成网站"
echo "   - 修改 _config.yml 后需要重启服务器"
echo ""
echo "=========================================="
echo ""

bundle exec jekyll serve --livereload
