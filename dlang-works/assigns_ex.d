import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

void stringsTo(string, T...)(string str, ref T t) {
  auto s = str.split();
  assert(s.length == t.length);
  foreach(ref ti; t) {
    ti = s[0].to!(typeof(ti));
    s = s[1..$];
  }
}

void main()
{

  //string lines;
  //string buf;
  //
  //while (!stdin.eof) {
  //  buf = stdin.readln();
  //  lines ~= buf;
  //}

  string lines = q"[4 5
]";

  string[] array = splitLines(lines);

  int N, M;
  stringsTo(array[0], N, M);
  writef("N = %d, M = %d\n", N, M);
}
