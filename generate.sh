#!/bin/zsh
REPO_DIR=$(dirname $(realpath "$0"))
LLVM_DIR=$(realpath "$REPO_DIR/../llvm-project")
echo $LLVM_DIR
if [ ! -d "$LLVM_DIR" ]; then
  echo "[ERROR] LLVM expected in $LLVM_DIR"
  exit 1
fi

pushd "$LLVM_DIR"
for i in {13..19}; do
    echo "[INFO] Processing LLVM $i.x..."
    git checkout "release/$i.x"
    DEST="$REPO_DIR/$i.x"
    rm -rf $DEST
    mkdir -p $DEST
    echo "[INFO] Copying files for LLVM $i..."
    cp -r llvm/include/llvm $DEST
    cp -r llvm/include/llvm-c $DEST
    rm -f $DEST/llvm/module.*
    find $DEST -name "CMakeLists.txt" -type f -delete
done
popd
