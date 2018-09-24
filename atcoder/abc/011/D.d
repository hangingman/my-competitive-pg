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
    writefln("%f", cast(float) 0);
  } else {
    Combination comb = new Combination(N+7);
    long ans = 0;

    int short_lr = X/D;
    int short_ud = Y/D;

    // writefln("Goal (%d, %d), movable %d", X, Y, D);
    // writefln("shortest move left/right: %d, up/down:%d", X/D, Y/D);
    // writefln("is there any mod ? left/right: %d, up/down:%d", X%D, Y%D);

    long shortest = comb.choose(short_lr+short_ud, short_lr);

    foreach (int k; 0..N+1) {
      int lr_move_k = k;
      int ud_move_k = (N-k);

      int lr_r = (lr_move_k*D+X)/2/D;
      int ud_r = (ud_move_k*D+Y)/2/D;

      if (lr_move_k < short_lr || ud_move_k < short_ud) {
        //writefln("lr_r=%d, ud_r=%d, N=%d", lr_r, ud_r, N);
        continue;
      } else {

        // if (short_lr%2==0 && lr_move_k%2!=0 || short_lr%2!=0 && lr_move_k%2==0) {
        //   continue;
        // }
        // if (short_ud%2==0 && ud_move_k%2!=0 || short_ud%2!=0 && ud_move_k%2==0) {
        //   continue;
        // }

        // writefln("lr_move_k=%d, ud_move_k=%d, N=%d", lr_move_k, ud_move_k,N);
        // writefln("lr_r=%d, ud_r=%d, N=%d", lr_r, ud_r, N);

        long lr = comb.choose(lr_move_k, lr_r);
        long ud = comb.choose(ud_move_k, ud_r);
        long tmp = (shortest*lr*ud);

        // writefln("%d * %dC%d=%d * %dC%d=%d = %d",
        //          shortest,
        //          lr_move_k, lr_r, lr,
        //          ud_move_k, ud_r, ud,
        //          tmp);

        ans += tmp;
      }

      writefln("%9f", cast(float) ans/pow(4,N));
    }
  }
}
