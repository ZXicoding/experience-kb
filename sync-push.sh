#!/bin/bash
# ═════════════════════════════════════════════
#  经验知识库 · 同步到 GitHub
#  功能：把本地改动 自动 add → commit → push 到线上
#  双击运行即可，无需懂 git 命令
# ═════════════════════════════════════════════

# 定位知识库目录（脚本可能放在目录里，或 App 的 Resources 里）
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KB_DIR="$SCRIPT_DIR"
# 如果脚本在 App 的 Contents/Resources 里，向上找知识库目录
for _ in 1 2 3 4; do
  if [ -d "$KB_DIR/.git" ]; then break; fi
  KB_DIR="$(dirname "$KB_DIR")"
done
if [ ! -d "$KB_DIR/.git" ]; then
  KB_DIR="/Users/xi/Documents/deepseek-harness/default-workspace/经验知识库"
fi

cd "$KB_DIR" || { echo "❌ 找不到知识库目录"; exit 1; }

echo "════════════════════════════════════════"
echo "  经验知识库 · 同步到 GitHub"
echo "  目录: $KB_DIR"
echo "════════════════════════════════════════"
echo ""

# 1. 拉取远程最新（先同步下来，避免冲突）
echo "▶ 第 1 步：拉取远程最新内容..."
git pull --rebase origin main 2>&1 | tail -3
echo ""

# 2. 看看有没有改动
CHANGES=$(git status --porcelain)
if [ -z "$CHANGES" ]; then
  echo "✓ 没有需要同步的改动，内容已是最新"
  echo ""
  echo "════════════════════════════════════════"
  echo "  完成！无需推送。"
  echo "════════════════════════════════════════"
  exit 0
fi

echo "▶ 检测到以下改动："
echo "$CHANGES" | sed 's/^/   /'
echo ""

# 3. 添加 + 提交
echo "▶ 第 2 步：提交改动..."
git add -A
git commit -m "同步更新 $(date '+%Y-%m-%d %H:%M')" 2>&1 | tail -2
echo ""

# 4. 推送到 GitHub
echo "▶ 第 3 步：推送到 GitHub..."
git push origin main 2>&1 | tail -3
echo ""

echo "════════════════════════════════════════"
echo "  ✅ 同步完成！已上传到 GitHub 私有仓库"
echo "  仓库地址: https://github.com/ZXicoding/experience-kb"
echo "════════════════════════════════════════"
echo ""
echo "  按任意键关闭窗口..."
read -n 1 -s
