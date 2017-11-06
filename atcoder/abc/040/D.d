import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

import std.range : iota;
import std.array;

int root(int i, int[] id)
{
  //writef("root: int i = %d, int[] id = %s\n", i, id.to!string);
  while (i != id[i]) {
    i = id[i];
  }
  return i;
}

// find, check if p and q has the same root
bool is_same(int p, int q, int[] id)
{

  int root_p = root(p, id);
  int root_q = root(q, id);
  //writef("is_same: int p = %d, int q = %d\n", p, q);
  //writef(" => root_p = %d, root_q = %d\n", root_p, root_q);
  return root_p == root_q;
}

// union, to merge components containing p and q
// set id of p's root to the id of q's root
void unite(int p, int q, int[] id)
{
  //writef("unite: int p = %d, int q = %d\n", p, q);
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

  string lines = q"[5 4
1 2 2000
2 3 2004
3 4 1999
4 5 2001
3
1 2000
1 1999
3 1995]";

  string[] array = splitLines(lines);

  int N = array[0].split(" ")[0].to!int;
  int M = array[0].split(" ")[1].to!int;
  int Q = array[M+1].to!int;

  //writeln("hello?");
  //writef("N:%d, M:%d, Q:%d\n", N, M, Q);

  int[] a = new int[M];
  int[] b = new int[M];
  int[] y = new int[M];

  int[] v = new int[Q];
  int[] w = new int[Q];

  //writef("v length: %d\n", v.length);
  //writef("a length: %d\n", a.length);

  foreach (int i, string s ; array[M+2..M+2+Q]) {
    //writef("v&w => [%d] %s\n", i, s);
    v[i] = s.split(" ")[0].to!int;
    w[i] = s.split(" ")[1].to!int;
  }

  foreach (int i, string s ; array[1..M+1]) {
    //writef("a,b,y => [%d] %s\n", i, s);
    a[i] = s.split(" ")[0].to!int;
    b[i] = s.split(" ")[1].to!int;
    y[i] = s.split(" ")[2].to!int;
  }

  for (int i = 0; i < Q; i++) {
    int[] id = M.iota.array;
    int[] sn = M.iota.array;
    //writeln(id.to!string);

    int max_y = w[i];

    foreach (int idx, int year; y) {
      //writef("compare: max_y = %d, year = %d\n", max_y, year);
      if (max_y < year) {
	//writef("max_y %d < year %d\n", max_y, year);

	int max = max(a[idx]-1, b[idx]-1);
	int min = min(a[idx]-1, b[idx]-1);

	//writef("unite: int p = %d, int q = %d\n", min-1, max-1);
        unite(min, max, id);
      }
    }

    int count = 0;
    foreach (int idx, int s; sn) {
      //writef("union find string => %s \n", id.to!string);
      //writef("s = %d, v[i]-1 = %d, is same? ", s, v[i]-1);
      if (is_same(s, v[i]-1, id)) {
	//writeln("true");
        count++;
      } else {
	//writeln("false");
      }
    }
    writeln(count);
    //writeln("------");
  }
}
