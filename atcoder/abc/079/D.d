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

  int H,W;
  stringsTo(array[0], H, W);
  Graph graph = new Graph(10);

  foreach ( int i, str; array[1..10+1]) {
    foreach ( int j, int w; str.split(" ").map!(s => s.to!int).array ) {
      graph.addGraphEdge(i, j, w);
    }
  }

  graph.warshallFloyd();

  int ans = 0;

  foreach ( str; array[11..12+H-1] ) {
    //writeln(str);
    foreach ( int a; str.split(" ").map!(s => s.to!int).array ) {
      if (a != 1 && a != -1) {
	ans += graph.dist[a][1];
	//writeln(graph.dist[a][1]);
      }
    }
  }

  writeln(ans);
}
