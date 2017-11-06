import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

import std.traits : AliasSeq;
import std.meta : Repeat;
import std.typecons : Tuple, tuple;
import std.range;

auto tuplify(size_t n, R)(R r) if (isInputRange!R) {
  Tuple!(Repeat!(n, ElementType!R)) result;
  static foreach (i; 0..n) {
    result[i] = r.front;
    r.popFront();
  }
  assert(r.empty);
  return result;
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
  AliasSeq!(N,M) = array[0].split(" ").map!(x => x.to!int).tuplify!2;

  writeln(N);
  writeln(M);
}
