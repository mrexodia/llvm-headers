#!/bin/zsh
REPO_DIR=$(dirname $(realpath "$0"))
LLVM_DIR=$(realpath "$REPO_DIR/../llvm-project")
if [ ! -d "$LLVM_DIR" ]; then
  echo "[ERROR] LLVM expected in $LLVM_DIR"
  exit 1
fi

pushd "$LLVM_DIR"
git fetch
for i in {13..19}; do
    echo "[INFO] Processing LLVM $i.x..."
    git checkout -f "origin/release/$i.x"
    DEST="$REPO_DIR/$i.x"
    rm -rf $DEST
    mkdir -p $DEST
    cp -r llvm/include/llvm $DEST
    cp -r llvm/include/llvm-c $DEST
    find $DEST -name "module.*" -type f -delete > /dev/null 2>&1
    find $DEST -name "CMakeLists.txt" -type f -delete > /dev/null 2>&1
done
popd
