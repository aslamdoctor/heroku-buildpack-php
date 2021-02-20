#!/bin/bash
# Build Path: /app/.heroku/php/
dep_url=git://github.com/grpc/grpc.git
grpc_root="$(pwd)"
echo "-----> Building Grpc..."

### Groc
echo "[LOG] Downloading Grpc"
git clone $dep_url -q
if [ ! -d "$grpc_dir" ]; then
  echo "[ERROR] Failed to find grpc directory $grpc_dir"
  exit
fi
cd src/php/ext/grpc
phpize
GRPC_LIB_SUBDIR=libs/opt ./configure --enable-grpc="${grpc_root}"
#cd $grpc_dir/build

# /app/php/bin/phpize
# ./configure --enable-grpc --with-php-config=$PHP_ROOT/bin/php-config
# make
# make install
BUILD_DIR=$1
ln -s $BUILD_DIR/.heroku /app/.heroku
export PATH=/app/.heroku/php/bin:$PATH
bash ./install
cd
echo "important extension grpc into php.ini"
echo "extension=grpc.so" >> /app/.heroku/php/etc/php/php.ini
