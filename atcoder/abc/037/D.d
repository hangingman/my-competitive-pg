import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;
import std.math;

int MOD = pow(10,9) + 7;
int H = 0;
int W = 0;

int[][] A;
int[][] dp;

int[] dy = [1,0,-1,0];
int[] dx = [0,1,0,-1];

void stringsTo(string, T...)(string str, ref T t) {
  auto s = str.split();
  assert(s.length == t.length);
  foreach(ref ti; t) {
    ti = s[0].to!(typeof(ti));
    s = s[1..$];
  }
}

int dfs(int y, int x) {
  if (dp[y][x] != -1) {
    return dp[y][x];
  } else {
    int ans = 1;
    for (int i=0;i<4;i++) {
      int ny = y + dy[i];
      int nx = x + dx[i];

      if (!(0 <= ny && ny < H && 0 <= nx && nx < W)) {
	continue;
      }

      if (A[y][x] < A[ny][nx]) {
	ans += dfs(ny, nx);
	ans %= MOD;
      }
    }
    dp[y][x] = ans;
    return ans;
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

//  string lines = q"[6 6
//1 3 4 6 7 5
//1 2 4 8 8 7
//2 7 9 2 7 2
//9 4 2 7 6 5
//2 8 4 6 7 6
//3 7 9 1 2 7]";

  string[] array = splitLines(lines);

  H = array[0].split(" ")[0].to!int;
  W = array[0].split(" ")[1].to!int;

  A  = new int[][](H,W);
  dp = new int[][](H,W);

  for (int i = 0; i < H; i++) {
    for (int j = 0; j < W; j++) {
      A[i][j] = array[i+1].split(" ")[j].to!int;
      dp[i][j] = -1;
    }
  }

  int ans = 0;

  for (int i = 0; i < H; i++) {
    for (int j = 0; j < W; j++) {
      ans += dfs(i,j);
      ans = ans % MOD;
    }
  }

  writeln(ans);
}
