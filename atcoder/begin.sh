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

# create ruby template files
cat << EOT > ${contest}/${number}/A.rb
lines = <<'EOS'
2 4
EOS

#lines = \$stdin.read
array = lines.split("\n")
EOT

cp ${contest}/${number}/A.rb ${contest}/${number}/B.rb
cp ${contest}/${number}/A.rb ${contest}/${number}/C.rb

# create dlang template files
cat << EOT > ${contest}/${number}/D.d
import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

void main()
{

  //string lines;
  //string buf;
  //
  //while (!stdin.eof) {
  //  buf = stdin.readln();
  //  lines ~= buf;
  //}

  string lines = q"[
  ]";

  string[] array = splitLines(lines);
  writeln(to!string(array));
}
EOT
