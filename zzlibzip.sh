#!/bin/bash
# install libzip
set -e

ROOTDIR=${ZZROOT:-$HOME/app}
NAME="libzip"
TYPE=".tar.gz"
FILE="$NAME$TYPE"
DOWNLOADURL="https://libzip.org/download/libzip-1.5.2.tar.gz"
echo $NAME will be installed in $ROOTDIR

mkdir -p $ROOTDIR/downloads
cd $ROOTDIR

if [ -f "downloads/$FILE" ]; then
    echo "downloads/$FILE exist"
else
    echo "$FILE does not exist, downloading from $DOWNLOADURL"
    wget $DOWNLOADURL -O $FILE
    mv $FILE downloads/
fi

mkdir -p src/$NAME
tar xf downloads/$FILE -C src/$NAME --strip-components 1

cd src/$NAME

mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$ROOTDIR ..
./configure --prefix=$ROOTDIR
make -j$(nproc) && make install

echo $NAME installed on $ROOTDIR
