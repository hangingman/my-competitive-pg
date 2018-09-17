#!/usr/bin/env rdmd

import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;
import std.array;
import std.math;
import std.range : iota;

long INF = pow(10, 9);
long MOD = pow(10, 9)+7;

class Combination {
  long[] factorial;

  this(int n) {
    factorial = iota(cast(long) 1, cast(long) n).array;
    foreach (idx, e; factorial) {
      if (idx > 0) {
        factorial[idx] = factorial[idx] * factorial[idx-1] % MOD;
      }
    }
  }

  long choose(int n, int r) {
    if (!(0 <= r && r <= n)) {
      return 0;
    } else if (r==0 || r==n) {
      return 1;
    } else {
      return fact(n) * inverse( fact(r) * fact(n-r) % MOD ) % MOD;
    }
  }

  long fact(long n) {
    return factorial[n-1];
  }

  long inverse(long x) {
    return mod_pow(x, MOD-2);
  }

  long mod_pow(long x, long n) {
    long ans = 1;
    while (n > 0) {
      if (n%2 != 0) {
        ans = ans * x % MOD;
      }
      x = x * x % MOD;
      n >>= 1;
    }
    return ans;
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

void main()
{

  string lines;
  string buf;

  while (!stdin.eof) {
    buf = stdin.readln();
    lines ~= buf;
  }

  string[] array = splitLines(lines);
  int N,D,X,Y;
  stringsTo(array[0], N, D);
  stringsTo(array[1], X, Y);

  if ((X%D)!=0 || (Y%D)!=0) {
    writeln(0.0);
  } else {
    Combination comb = new Combination(N*D);
    long shortest = comb.choose(N, X/D);
    long ans = 0;

    foreach (int k; 0..N+1) {
      int lr_move_k = k*D;
      int ud_move_k = (N-k)*D;

      if (lr_move_k < X || ud_move_k < Y) {
        continue;
      } else {
        int lr_r = (lr_move_k+X)/2;
        int ud_r = (ud_move_k+Y)/2;
        long lr = comb.choose(lr_move_k, lr_r);
        long ud = comb.choose(ud_move_k, ud_r);
        long tmp = (shortest*lr*ud);

        writefln("%d * %dC%d=%d * %dC%d=%d = %d",
                 shortest,
                 lr_move_k, lr_r, lr,
                 ud_move_k, ud_r, ud,
                 tmp);
        ans += tmp;
      }

      writefln("%f", cast(float) ans/pow(4,N));
    }
  }
}
