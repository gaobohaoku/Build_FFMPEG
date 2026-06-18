#!/bin/bash

ABI=$1
PROFILE=$2
NDK=$3
FFMPEG=$4
MEDIA3=$5

echo "ABI=$ABI"
echo "PROFILE=$PROFILE"

CONFIG_FILE=$(pwd)/config/${PROFILE}.sh

source $CONFIG_FILE

TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

case $ABI in
  arm64-v8a)
    TARGET=aarch64-linux-android
    ;;
  armeabi-v7a)
    TARGET=armv7a-linux-androideabi
    ;;
  x86_64)
    TARGET=x86_64-linux-android
    ;;
esac

API=21

cd $FFMPEG

./configure \
  --prefix=$PWD/out/$ABI \
  --target-os=android \
  --arch=$ABI \
  --cpu=$ABI \
  --enable-cross-compile \
  --sysroot=$TOOLCHAIN/sysroot \
  --cc=$TOOLCHAIN/bin/${TARGET}${API}-clang \
  --cxx=$TOOLCHAIN/bin/${TARGET}${API}-clang++ \
  --strip=$TOOLCHAIN/bin/llvm-strip \
  --enable-pic \
  --disable-static \
  --enable-shared \
  --disable-doc \
  --disable-programs \
  $FFMPEG_FLAGS

make -j$(nproc)
make install

# copy to Media3 module
mkdir -p $MEDIA3/jniLibs/$ABI
cp $PWD/out/$ABI/lib/*.so $MEDIA3/jniLibs/$ABI/

mkdir -p ../../out/$ABI
cp -r $PWD/out/$ABI/lib ../../out/$ABI/
