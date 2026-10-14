#!/bin/bash
# ═════════════════════════════════════════════
#  经验知识库 · 从 GitHub 更新
#  功能：把其他设备的改动拉取到本地（git pull）
#  双击运行即可
# ═════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KB_DIR="$SCRIPT_DIR"
for _ in 1 2 3 4; do
  if [ -d "$KB_DIR/.git" ]; then break; fi
  KB_DIR="$(dirname "$KB_DIR")"
done
if [ ! -d "$KB_DIR/.git" ]; then
  KB_DIR="/Users/xi/Documents/deepseek-harness/default-workspace/经验知识库"
fi

cd "$KB_DIR" || { echo "❌ 找不到知识库目录"; exit 1; }

echo "════════════════════════════════════════"
echo "  经验知识库 · 从 GitHub 更新"
echo "════════════════════════════════════════"
echo ""

echo "▶ 拉取远程最新内容..."
git pull origin main 2>&1 | tail -5
echo ""

echo "════════════════════════════════════════"
echo "  ✅ 更新完成！本地内容已是最新"
echo "════════════════════════════════════════"
echo ""
echo "  按任意键关闭窗口..."
read -n 1 -s
