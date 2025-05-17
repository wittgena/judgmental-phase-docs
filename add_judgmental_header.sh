#!/bin/bash

HEADER="<!-- Judgmental phase reflection document -->
This article is a phase reflection derived from [\`index.md\`](../index.md) and [\`@나.dsl\`](../dsl/나.dsl).
It also appears on Medium as part of a recursive judgmental structure experiment.

"

# 대상 디렉토리
TARGET_DIR="./medium"

# 모든 .md 파일에 대해 반복
for file in "$TARGET_DIR"/*.md; do
  # 이미 헤더가 삽입되었는지 검사 (idempotent 처리)
  if grep -q "Judgmental phase reflection document" "$file"; then
    echo "✔ Already has header: $file"
  else
    echo "➕ Adding header to: $file"
    temp_file=$(mktemp)
    echo "$HEADER" > "$temp_file"
    cat "$file" >> "$temp_file"
    mv "$temp_file" "$file"
  fi
done
