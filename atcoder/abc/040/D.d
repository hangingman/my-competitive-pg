import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

import std.range : iota;
import std.array;

class UnionFind {

  int[] id;
  int[] rank;

  this(int n) {
    id   = n.iota.array;
    rank = new int[n];
    rank[] = 0;
  }

  int findSet(int i) {
    //writef("findSet: int i = %d, int[] id = %s\n", i, id.to!string);
    if (i != id[i]) {
      id[i] = findSet(id[i]);
    }
    return id[i];
  }

  // find, check if p and q has the same root
  bool isSame(int p, int q) {
    int rootP = findSet(p);
    int rootQ = findSet(q);
    //writef("isSame: int p = %d, int q = %d\n", p, q);
    //writef(" => rootP = %d, rootQ = %d\n", rootP, rootQ);
    return rootP == rootQ;
  }

  // union, to merge components containing p and q
  // set id of p's root to the id of q's root
  void unite(int p, int q) {
    //writef("unite: int p = %d, int q = %d\n", p, q);
    int i = findSet(p);
    int j = findSet(q);
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

  int N,M;
  stringsTo(array[0], N, M);

  int Q = array[M+1].to!int;

  class Edge {
    int index;
    int a;
    int b;
    int y;
    bool append;

    override string toString() {
      return format("index = %d, a = %d, b = %d, y = %d, append = %s", index, a, b, y, append);
    }
  }

  auto edges = new Edge[M];

  foreach (int i, string s ; array[1..M+1]) {
    auto e = new Edge;
    e.index = i;
    stringsTo(s, e.a, e.b, e.y);
    edges[i] = e;
  }

  class Person {
    int index;
    int v;
    int w;
    int count;

    override string toString() {
      return format("index = %d, v = %d, w = %d, count = %d", index, v, w, count);
    }
  }

  auto persons = new Person[Q];
  foreach (int i, string s ; array[M+2..M+2+Q]) {
    auto p = new Person;
    p.index = i;
    p.count = -1;
    stringsTo(s, p.v, p.w);
    persons[i] = p;
  }

  sort!((Edge e1, Edge e2){ return e1.y > e2.y; })(edges);
  sort!((Person p1, Person p2){ return p1.w > p2.w; })(persons);

  auto uf = new UnionFind(N);
  int[] sn = N.iota.array;

  foreach (ref Person p; persons) {
    if ( edges.count!(e => e.y > p.w) == 0 ) {
      continue;
    } else {
      auto es = edges.filter!(e => p.w < e.y && !e.append);
      foreach (ref Edge e; es) {
	//writef("add edge %d\n", e.y);
	int max = max(e.a, e.b) - 1;
	int min = min(e.a, e.b) - 1;
	uf.unite(min, max);
	e.append = true;
      }
      int count = 0;
      foreach (int idx, int s; sn) {
        if (uf.isSame(s, p.v-1)) {
          count++;
        }
      }
      p.count = count;
      //writef("check count %d\n", p.count);
    }
  }

  sort!((Person p1, Person p2){ return p1.index < p2.index; })(persons);
  foreach (Person p; persons) {
    if (p.count == -1) {
      writeln(1);
    } else {
      writeln(p.count);
    }
  }
}
