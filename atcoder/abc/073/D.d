#!/usr/bin/env rdmd

import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;
import std.array;
import std.math;

void stringsTo(string, T...)(string str, ref T t) {
  auto s = str.split();
  assert(s.length == t.length);
  foreach(ref ti; t) {
    ti = s[0].to!(typeof(ti));
    s = s[1..$];
  }
}

long INF = pow(10, 9);

struct Node {
  int   u; // :u ノードのインデックス
  ulong k; // :k u の出次数
  int[] v; // :v u に隣接する頂点の番号
  int[int] w; // :w 隣接する頂点への重み
};

class Graph {
  public int n;
  public Node[] nodes;
  public long[][] dist;

  this(int n) {
    this.n = n;
    this.nodes = new Node[n];
    foreach (int i, ref node; this.nodes) {
      node.u = i;
    }
    this.dist = new long [][](n,n);
  }

  void addGraphEdge(int u, int v, int w) {
    this.nodes[u].v ~= v;
    this.nodes[u].w[v] = w;
    this.nodes[u].k = this.nodes[u].v.length;
  }

  void warshallFloyd() {
    for (int i = 0; i < this.nodes.length; i++ ) {
      for (int j = 0; j < this.nodes.length; j++ ) {
	int* val = j in this.nodes[i].w;
	if (val != null) {
	  this.dist[i][j] = *val;
	} else {
	  this.dist[i][j] = INF;
	}
      }
      this.dist[i][i] = 0;
    }

    for (int k = 0; k < this.nodes.length; k++) {
      for (int i = 0; i < this.nodes.length; i++) {
	for (int j = 0; j < this.nodes.length; j++) {
	  if (this.dist[i][k] != INF && this.dist[k][j] != INF) {
	    this.dist[i][j] = min(this.dist[i][j], this.dist[i][k] + this.dist[k][j]);
	  }
	}
      }
    }
  }
}

void main()
{

  string lines;
  string buf;

  while (!stdin.eof) {
    buf = stdin.readln();
    lines ~= buf;
  }

  string[] array = splitLines(lines);
  //writeln(to!string(array));
  int N,M,R;
  stringsTo(array[0], N, M, R);
  Graph graph = new Graph(N);
  int[] rarr = array[1].split(" ").map!( (s) => s.to!int ).array;
  sort(rarr); // １行で書きたいんやが…

  foreach (str; array[2..M+2]) {
    int s,t,d;
    stringsTo(str,s,t,d);
    s = s - 1;
    t = t - 1;
    graph.addGraphEdge(s,t,d);
    graph.addGraphEdge(t,s,d);
  }

  graph.warshallFloyd();
  long ans = INF;

  // Rから2つ選ぶ全探索
  //writeln(join(rarr.map!(s => s.to!string), ","));

  import std.algorithm : nextPermutation;

  do
    {
      long s = 0;
      for (int i = 1; i < rarr.length; i++) {
        //writeln(rarr[i-1]-1, ",", rarr[i]-1);
        s += graph.dist[rarr[i-1] - 1][rarr[i] - 1];
      }
      //writeln(s);
      ans = min(s, ans);
    }
  while(nextPermutation(rarr));

  writeln(ans);

  //writeln(graph.dist);
  //cat in2.txt | ./D.d
  //[[0, 2, 4],
  // [2, 0, 2],
  // [4, 2, 0]]
}
