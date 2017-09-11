#!/bin/bash

if [ $# -ne 2 ]; then
    echo "usage: ./begin.sh [contest] [number]"
    exit 1
else
    echo "contest: ${1}, number: ${2}"
    contest=${1}
    number=${2}
fi

mkdir -p "${contest}/${number}/"

cat << EOT > ${contest}/${number}/template.rb
lines = <<'EOS'
2 4
EOS

#lines = \$stdin.read
array = lines.split("\n")
EOT
