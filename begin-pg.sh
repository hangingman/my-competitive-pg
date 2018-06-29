#!/bin/bash

if [ $# -ne 2 ]; then
    echo "usage: ./begin-pg.sh [type] [number]"
    exit 1
else
    echo "type: ${1}, number: ${2}"
    type=${1}
    number=${2}
fi

# create ruby template files
cat << EOT > ${type}-${number}.rb
lines = <<'EOS'
2 4
EOS

#lines = \$stdin.read
array = lines.split("\n")
EOT
