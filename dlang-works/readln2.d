import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

import std.array;

// STDINから数値を読み取って
// 複数ある型に合わせた配列にする
void readlnTo(T...)(ref T t) {
  auto s = readln().split();
  assert(s.length == t.length);
  foreach(ref ti; t) {
    ti = s[0].to!(typeof(ti));
    s = s[1..$];
  }
}

// 以下のようなファイルを作って
// 標準入力にしてバイナリに食わせるとテストできる。
// 一回のreadlnTo()で１行だけ取得できるはず
// 複数の引数が許容されるので、一度に複数の変数が初期化できる。
// -----------------------------------------------
// $ cat ints.txt
// 1 2 100
// 2 3 110
// 4 5 120
// -----------------------------------------------
// $ dmd readln2.d && cat readln2.txt | ./readln2
// v = 1, k = 2, w = 100
// v = 2, k = 3, w = 110
// v = 4, k = 5, w = 120
void main() {
  for (int i = 0; i < 3; i++) {
    int v,k,w;
    readlnTo(v,k,w);
    writef("v = %d, k = %d, w = %d\n", v, k, w);
  }
}
