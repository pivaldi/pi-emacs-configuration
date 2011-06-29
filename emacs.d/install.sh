#!/bin/bash

DIR=$(dirname $0)
cd $DIR

find ./*/ -iname 'makefile' -exec sh -c 'cd "$(dirname $0)" && make' "{}" ";"

echo '!!=='
echo '  You must set your identity and customize some parameters in the file !!'
echo "  $(pwd)/my-parameters.el"
echo '==!!'

