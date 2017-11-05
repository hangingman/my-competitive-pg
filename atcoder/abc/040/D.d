import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

import std.range : iota;
import std.array;

int root(int i, int[] id)
{
  while (i != id[i]) {
    i = id[i];
  }
  return i;
}

// find, check if p and q has the same root
bool is_same(int p, int q, int[] id)
{
  return root(p, id) == root(q, id);
}

// union, to merge components containing p and q
// set id of p's root to the id of q's root
void unite(int p, int q, int[] id)
{
  int i = root(p, id);
  int j = root(q, id);
  id[i] = j;
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
1 2 2005
3 1 2001
3 4 2002
1 4 2004
4 2 2003
5
1 2003
2 2003
1 2001
3 2003
4 2004]";

  string[] array = splitLines(lines);

  int N = array[0].split(" ")[0].to!int;
  int M = array[0].split(" ")[1].to!int;
  int Q = array[M+1].to!int;

  //writeln("hello?");
  writef("N:%d, M:%d, Q:%d\n", N, M, Q);

  int[] a = new int[M];
  int[] b = new int[M];
  int[] y = new int[M];
  int[] v = new int[Q];
  int[] w = new int[Q];

  foreach (int i, string s ; array[M+2..M+1+Q]) {
    v[i] = s.split(" ")[0].to!int;
    w[i] = s.split(" ")[1].to!int;
  }

  foreach (int i, string s ; array[1..M]) {
    a[i] = s.split(" ")[0].to!int;
    b[i] = s.split(" ")[1].to!int;
    y[i] = s.split(" ")[2].to!int;
  }

  for (int i = 0; i < Q-1; i++) {
    int[] id = N.iota.array;
    int[] sn = N.iota.array;

    int max_y = w[i];

    foreach (int idx, int year; y) {
      if (max_y < year) {
        unite(a[idx], b[idx], id);
      }
    }

    int count = 0;
    foreach (int idx, int s; sn) {
      if (is_same(s, v[idx]-1, id)) {
        count++;
      }
    }
    writeln(count);
    //writeln("hello");
  }

  writeln(to!string(array));
}
