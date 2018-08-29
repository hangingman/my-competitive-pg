#!/usr/bin/env rdmd

import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;
import std.typecons;
import std.array;
import std.math;

alias Tuple!(long, long) pair;

void stringsTo(string, T...)(string str, ref T t) {
  auto s = str.split();
  assert(s.length == t.length);
  foreach(ref ti; t) {
    ti = s[0].to!(typeof(ti));
    s = s[1..$];
  }
}

void meet_in_the_mid(int n, int w, pair[] vw)
{
  int s = 0;
  pair[] s1 = vw[0..n/2];
  pair[] s2 = vw[n/2..n];
  pair[] tmp_a;

  for (int bit = 0; bit < (1<<s1.length); bit++) {
    pair tmp_pair = pair(0,0);
    foreach (i; 0..s1.length) {
      if (bit & (1<<i)) {
	tmp_pair[0] += s1[i][0];
	tmp_pair[1] += s1[i][1];
      }
    }
    if (tmp_pair[1] <= w) {
      tmp_a ~= tmp_pair;
    }
  }

  sort!( (a,b) => a[0] > b[0] )(tmp_a);

  ulong ans = 0;
  for (int bit = 0; bit < (1<<s2.length); bit++) {
    pair tmp_pair = pair(0,0);
    foreach (i; 0..s2.length) {
      if (bit & (1<<i)) {
	tmp_pair[0] += s2[i][0];
	tmp_pair[1] += s2[i][1];
      }
    }

    if (tmp_pair[1] <= w) {
      pair[] x = tmp_a.find!( (e) => tmp_pair[1] + e[1] <= w );
      if (! x.empty) {
	ans = reduce!(max)([ans, x[0][0] + tmp_pair[0]]);
      }
    }
  }
  writefln("%d", ans);
}

void solve_sigma_v(int n, int w, pair[] vw, int max_v)
{
  //writef("sigma_v");
  int max_n = n;
  long INF = pow(10, 9);
  long[] dp = new long[](max_n*max_v+1);
  fill(dp, INF);
  dp[0] = 0;

  long ans = 0;

  for (int i = 0; i < n; i++) {
    long vi = vw[i][0];
    long wi = vw[i][1];
    for (long j=max_n * max_v; j>1; j--) {
      if (j-vi >= 0) {
        //writefln("j=%d,vi=%d ",j,vi);
        dp[j] = [dp[j], dp[j-vi] + wi].reduce!(min);

        if (dp[i] <= w && dp[i] < dp[ans]) {
          ans = j;
        }
      }
    }
  }

  //for (long i = 0; i < dp.length; i++) {
  //writefln("[%d] %s dp=%d, w=%d", i, ((dp[i]<w) ? "t" : "f"), dp[i], w);
  //}
  writeln(ans);
}

void solve_sigma_w(int n, int w, pair[] vw, int max_w)
{
  writef("sigma_w");
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

  int N, W;
  stringsTo(array[0], N, W);
  pair[] vw = new pair[N];
  int max_v, max_w;

  foreach (i; 1..N+1) {
    int v, w;
    stringsTo(array[i], v, w);
    max_v = reduce!(max)([v, max_v]);
    max_w = reduce!(max)([w, max_w]);
    pair p = pair(v, w);
    //writef("v:%d, w:%d\n", p[0], p[1]);
    vw[i-1] = p;
  }

  if (N <= 30) {
    // meet in the mid
    meet_in_the_mid(N, W, vw);
  } else {
    // 01 knapsack
    if (max_v <= 1000) {
      solve_sigma_v(N, W, vw, max_v);
    } else {
      solve_sigma_w(N, W, vw, max_w);
    }
  }
}
