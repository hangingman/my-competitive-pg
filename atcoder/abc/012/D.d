import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

int INF = 999999999;

enum Color {
  WHITE = 0
  , GRAY
  , BLACK
}

struct Node {
  int u;
  int d;
  Color c;
  int p;
}

class Graph {
  Node[] nodes;
  int[][] mat;
  int u_start;

  this(int n, int[][] matrix, int u_start_with) {
    this.nodes = new Node[n];
    foreach (int i, ref Node node; nodes) {
      node.u = i + u_start_with;
      node.p = -1;
      node.c = Color.WHITE;
      node.d = INF;
    }
    this.u_start = u_start_with;
    this.mat     = matrix;
  }

  bool edge_exists(int row, int col) {
    row -= this.u_start;
    col -= this.u_start;
    if (this.mat[row][col] != -1) {
      return true;
    } else {
      return false;
    }
  }

  void dijkstra(int start) {

    this.nodes[start].d = 0;
    this.nodes[start].p = -1;

    while (true) {
      int mincost = INF;
      int next_u  = -1;

      foreach (ref Node node; this.nodes) {
        if (node.c != Color.BLACK && node.d < mincost) {
          mincost = node.d;
          next_u  = node.u;
          //writef("mincost = %d, next_u = %d\n", mincost, next_u);
        }
      }

      if (mincost==INF) {
        break;
      }

      this.nodes[next_u].c = Color.BLACK;

      foreach (int v, ref Node node; this.nodes) {
        if (node.c != Color.BLACK && edge_exists(next_u, v) && this.nodes[next_u].d + mat[next_u][v] < node.d) {
          node.d = this.nodes[next_u].d + mat[next_u][v];
          node.p = next_u;
          node.c = Color.GRAY;
          //writef("index: %d, node.u: %d\n", v, node.u);
        }
      }

      // end
    }
  }
}

void main()
{

  // START
  string lines;
  string buf;
  while (!stdin.eof) {
    buf = stdin.readln();
    lines ~= buf;
  }
  // END

//string lines = q"[5 5
//1 2 12
//2 3 14
//3 4 7
//4 5 9
//5 1 18]";
  string[] array = splitLines(lines);
  //writeln(to!string(array));

  int N = array[0].split(" ")[0].to!int;
  int M = array[0].split(" ")[1].to!int;
  int[][] mat = new int[][](N, N);

  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      mat[i][j] = -1;
    }
  }

  for (int i = 1; i < M+1; i++) {
    int u = array[i].split(" ")[0].to!int;
    int v = array[i].split(" ")[1].to!int;
    int w = array[i].split(" ")[2].to!int;
    mat[u-1][v-1] = w;
    mat[v-1][u-1] = w;
  }

  Graph graph = new Graph(N, mat, 0);
  int[] max_array = new int[](N);

  foreach (int n, ref int elem; max_array) {
    Graph g = new Graph(N, mat, 0);
    g.dijkstra(n);
    elem = g.nodes.map!(node => node.d).reduce!(max);
  }

  writeln(reduce!(min)(max_array));
}
