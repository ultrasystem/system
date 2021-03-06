#!/bin/sh
export KERNELDIR=`greadlink -f .`
export PARENT_DIR=`greadlink -f ..`
export USE_SEC_FIPS_MODE=true
export CROSS_COMPILE=/usr/tools/arm-linux-eabi/bin/arm-none-linux-gnueabi-
export PATH=/usr/local/bin:$PATH
export ARCH=arm

if [ "${1}" != "" ];then
  export KERNELDIR=`greadlink -f ${1}`
fi

if [ ! -f $KERNELDIR/.config ];
then
  make -j4 uav_defconfig
fi

. $KERNELDIR/.config

cd $KERNELDIR/
make HOSTCFLAGS="-I /usr/include" nconfig || exit 1
