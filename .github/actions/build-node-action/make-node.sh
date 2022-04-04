#!/bin/sh

set -e
set -x

NODE_VERSION=$1

NODE_DIR=node-${NODE_VERSION}
NODE_TARBALL=node-${NODE_VERSION}.tar.gz

cd ${GITHUB_WORKSPACE}
curl https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARBALL} > ${NODE_TARBALL}
tar xzf ${NODE_TARBALL}
cd ${NODE_DIR}

# These flags are required for CentOS 6, and are the whole
# reason for doing our own builds
export CPPFLAGS=-D__STDC_FORMAT_MACROS
export LDFLAGS=-lrt

scl enable devtoolset-9 rh-python36 "./configure --fully-static --enable-static"
scl enable devtoolset-9 rh-python36 "ARCH=x64 make -j$(nproc) binary"

cd ${GITHUB_WORKSPACE}

mkdir centos_patch
cd centos_patch

wget https://github.com/NixOS/patchelf/releases/download/0.14.5/patchelf-0.14.5-x86_64.tar.gz
## this unpacks in the current folder
tar -xvzf patchelf-0.14.5-x86_64.tar.gz

tar -xvzf ${GITHUB_WORKSPACE}/${NODE_DIR}/node-${NODE_VERSION}-linux-x64.tar.gz

cd node-${NODE_VERSION}-linux-x64
cp -R /lib64 ./lib64
cd bin
../../bin/patchelf --set-interpreter ../lib64/ld-linux-x86-64.so.2 --set-rpath ../lib64 node 

## now repack
cd ${GITHUB_WORKSPACE}/centos_patch
tar -cf node-${NODE_VERSION}-linux-x64.tar node-${NODE_VERSION}-linux-x64
rm -f -r node-${NODE_VERSION}-linux-x64
gzip -c -f -9 node-${NODE_VERSION}-linux-x64.tar > node-${NODE_VERSION}-linux-x64.tar.gz
xz -c -f -9e node-${NODE_VERSION}-linux-x64.tar > node-${NODE_VERSION}-linux-x64.tar.xz
rm -f node-${NODE_VERSION}-linux-x64.tar
sha256sum node-${NODE_VERSION}-linux-x64.tar.xz node-${NODE_VERSION}-linux-x64.tar.gz > SHASUMS256.txt
