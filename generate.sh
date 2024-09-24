#!/bin/zsh
# NOTE: Put this script in ../llvm-project
rm -rf ../llvm-headers
for i in {13..19}; do
    git checkout "release/$i.x"
    DEST="../llvm-headers/$i.x"
    mkdir -p $DEST
    echo "Copying files for LLVM $i..."
    cp -r llvm/include/llvm $DEST
    rm $DEST/llvm/module.*
    find $DEST -name "CMakeLists.txt" -type f -delete
done