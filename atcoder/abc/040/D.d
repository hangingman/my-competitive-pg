import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

import std.range : iota;
import std.array;

class UnionFind {

  int root(int i, int[] id) {
    //writef("root: int i = %d, int[] id = %s\n", i, id.to!string);
    while (i != id[i]) {
      i = id[i];
    }
    return i;
  }

  // find, check if p and q has the same root
  bool isSame(int p, int q, int[] id) {
    int rootP = root(p, id);
    int rootQ = root(q, id);
    //writef("isSame: int p = %d, int q = %d\n", p, q);
    //writef(" => rootP = %d, rootQ = %d\n", rootP, rootQ);
    return rootP == rootQ;
  }

  // union, to merge components containing p and q
  // set id of p's root to the id of q's root
  void unite(int p, int q, int[] id) {
    //writef("unite: int p = %d, int q = %d\n", p, q);
    int i = root(p, id);
    int j = root(q, id);
    id[i] = j;
  }
}

void main() {
  string lines;
  string buf;

  while (!stdin.eof) {
    buf = stdin.readln();
    lines ~= buf;
  }

//  string lines = q"[4 5
//1 2 10
//1 2 1000
//2 3 10000
//2 3 100000
//3 1 200000
//4
//1 0
//2 10000
//3 100000
//4 0]";

  string[] array = splitLines(lines);

  int N = array[0].split(" ")[0].to!int;
  int M = array[0].split(" ")[1].to!int;
  int Q = array[M+1].to!int;

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

  auto uf = new UnionFind;

  for (int i = 0; i < Q; i++) {
    int[] id = N.iota.array;
    int[] sn = N.iota.array;
    //writef("%d times \n", i);

    int maxY = w[i];

    foreach (int idx, int year; y) {
      //writef("compare: maxY = %d, year = %d\n", maxY, year);
      if (maxY < year) {
	//writef("maxY %d < year %d\n", maxY, year);

	int max = max(a[idx], b[idx]) - 1;
	int min = min(a[idx], b[idx]) - 1;

	//writef("unite: int p = %d, int q = %d\n", min, max);
        uf.unite(min, max, id);
      }
    }

    int count = 0;
    foreach (int idx, int s; sn) {
      //writef("union find string => %s \n", id.to!string);
      //writef("s = %d, v[i]-1 = %d, is same? ", s, v[i]-1);
      if (uf.isSame(s, v[i]-1, id)) {
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
