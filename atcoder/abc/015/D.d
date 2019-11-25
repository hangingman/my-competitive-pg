import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

//string lines = q"[
//abcdeffg]";

void main()
{

  string lines;
  string buf;

  while (!stdin.eof) {
    buf = stdin.readln();
    lines ~= buf;
  }

  string[] array = splitLines(lines);

  int W = array[0].to!int;
  int N,K;
  N = array[1].split(" ")[0].to!int;
  K = array[1].split(" ")[1].to!int;

  int[] A = [0];
  int[] B = [0];
  for (int i=2; i<array.length; i++) {
    string s = array[i];
    A ~= s.split(" ")[0].to!int;
    B ~= s.split(" ")[1].to!int;
  }

  int[][][] dp = new int[][][](N+1, K+1, W+1);
  for (int i=1; i<N+1; i++) {
    for (int j=1; j<K+1; j++) {
      for (int k=1; k<W+1; k++) {
        if (k >= A[i]) {
          dp[i][j][k] = max(
            dp[i-1][j][k],
            dp[i-1][j-1][k-A[i]] + B[i]
          );
        } else {
          dp[i][j][k] = max(
            dp[i-1][j][k],
            dp[i][j][k-1]
          );
        }
      }
    }
  }

  writeln(dp[N][K][W]);
}
