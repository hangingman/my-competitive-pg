import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

import std.array;

// STDINから数値を読み取ってintの配列にする
auto readInts() {
  return array(map!(to!int)(readln().strip().split()));
}
// STDINから数値を読み取ってintの配列の最初だけとる
auto readInt() {
  return readInts()[0];
}
// STDINから数値を読み取ってlongの配列にする
auto readLongs() {
  return array(map!(to!long)(readln().strip().split()));
}
// STDINから数値を読み取ってlongの配列の最初だけとる
auto readLong() {
  return readLongs()[0];
}

// 以下のようなファイルを作って
// 標準入力にしてバイナリに食わせるとテストできる。
// 一回のreadInt()で１行だけ取得できるはず
// -----------------------------------------------
// $ cat ints.txt
// 1 2
// 2 3
// 4 5
// -----------------------------------------------
// $ dmd read_nu.d && cat ints.txt | ./read_nu
// [1, 2]
// [2, 3]
// [4, 5]
void main() {
  for (int i = 0; i < 3; i++) {
    writeln(readInts().to!string);
  }
}
