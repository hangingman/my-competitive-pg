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

void stringsTo(string, T...)(string str, ref T t) {
  auto s = str.split();
  assert(s.length == t.length);
  foreach(ref ti; t) {
    ti = s[0].to!(typeof(ti));
    s = s[1..$];
  }
}

void main() {
  //string lines;
  //string buf;
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

  int N,M;
  stringsTo(array[0], N, M);

  int Q = array[M+1].to!int;

  class Edge {
    int a;
    int b;
    int y;

    override string toString() {
      return format("a = %d, b = %d, y = %d", a, b, y);
    }
  }

  auto edges = new Edge[M];

  foreach (int i, string s ; array[1..M+1]) {
    auto e = new Edge;
    stringsTo(s, e.a, e.b, e.y);
    edges[i] = e;
  }

  class Person {
    int v;
    int w;
    int count;

    override string toString() {
      return format("v = %d, w = %d, count = %d", v, w, count);
    }
  }

  auto persons = new Person[Q];
  foreach (int i, string s ; array[M+2..M+2+Q]) {
    auto p = new Person;
    stringsTo(s, p.v, p.w);
    persons[i] = p;
  }

  // ソートしておく
  //foreach (Person p; persons) {
  //  writeln(p.to!string);
  //}

  sort!((Person p1, Person p2){ return p1.w > p2.w; })(persons);

  //foreach (Person p; persons) {
  //  writeln(p.to!string);
  //}

  auto uf = new UnionFind;

  // for (int i = 0; i < Q; i++) {
  //   int[] id = N.iota.array;
  //   int[] sn = N.iota.array;
  //   //writef("%d times \n", i);
  //
  //   int maxY = w[i];
  //
  //   foreach (int idx, int year; y) {
  //     //writef("compare: maxY = %d, year = %d\n", maxY, year);
  //     if (maxY < year) {
  //       //writef("maxY %d < year %d\n", maxY, year);
  //
  //       int max = max(a[idx], b[idx]) - 1;
  //       int min = min(a[idx], b[idx]) - 1;
  //
  //       //writef("unite: int p = %d, int q = %d\n", min, max);
  //       uf.unite(min, max, id);
  //     }
  //   }
  //
  //   int count = 0;
  //   foreach (int idx, int s; sn) {
  //     //writef("union find string => %s \n", id.to!string);
  //     //writef("s = %d, v[i]-1 = %d, is same? ", s, v[i]-1);
  //     if (uf.isSame(s, v[i]-1, id)) {
  //       //writeln("true");
  //       count++;
  //     } else {
  //       //writeln("false");
  //     }
  //   }
  //   writeln(count);
  // }
}
