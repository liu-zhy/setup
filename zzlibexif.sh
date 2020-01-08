#!/bin/bash
# install libexif
set -e

ROOTDIR=${ZZROOT:-$HOME/app}
NAME="libexif"
TYPE=".tar.gz"
FILE="$NAME$TYPE"
DOWNLOADURL="https://jaist.dl.sourceforge.net/project/libexif/libexif/0.6.21/libexif-0.6.21.tar.gz"
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

update_configure_scripts  # the config.sub is too old
./configure --prefix=$ROOTDIR
make -j$(nproc) && make install

echo $NAME installed on $ROOTDIR