import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

import std.range : iota;
import std.array;

import std.container;
import std.typetuple, std.typecons;

class UnionFind {

  int[] id;
  int[] rank;
  int[] countNodes;

  this(int n) {
    id           = n.iota.array;
    rank         = new int[n];
    rank[]       = 0;
    countNodes   = new int[n];
    countNodes[] = 1;
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

    if (i == j) {
      return;
    }

    if (countNodes[i] > countNodes[j]) {
      countNodes[i] = countNodes[j] + countNodes[i];
      id[j] = i;
    } else {
      countNodes[j] = countNodes[j] + countNodes[i];
      id[i] = j;
    }
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

alias Edge   = Tuple!(int, "index", int, "a", int, "b", int, "y");
alias Person = Tuple!(int, "index", int, "v", int, "w", int, "count");

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
  auto edges   = new BinaryHeap!(Array!Edge, "a.y < b.y")();
  auto persons = new BinaryHeap!(Array!Person, "a.w < b.w")();

  foreach (int i, string s ; array[1..M+1]) {
    int a,b,y;
    stringsTo(s, a, b, y);
    edges.insert(Edge(i, a, b, y));
  }

  foreach (int i, string s ; array[M+2..M+2+Q]) {
    int v,w;
    stringsTo(s, v, w);
    persons.insert(Person(i, v, w, -1));
  }

  auto uf   = new UnionFind(N);
  int[] ans = new int[Q];
  ans[]     = 1;

  while (!persons.empty) {
    Person p = persons.front();

    while(!edges.empty && edges.front.y > p.w) {
      auto e = edges.front();
      int max = max(e.a, e.b) - 1;
      int min = min(e.a, e.b) - 1;
      uf.unite(min, max);
      edges.removeFront();
      if (edges.empty()) {break;}
    }
    // union-by-size
    int count    = uf.countNodes[uf.findSet(p.v-1)];
    ans[p.index] = count;
    persons.removeFront();
    //writef("check count %d\n", p.count);
  }
  ans.each!(a => writeln(a));
}
