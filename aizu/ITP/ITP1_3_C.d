import std.stdio;
import std.conv;
import std.string;
import std.format;

void main()
{
  //string s = chomp(readln());
  //long l = to!long

  while (true) {

    string s = chomp(readln());

    int l = to!int(s.split(" ")[0]);
    int r = to!int(s.split(" ")[1]);

    if (l == 0 && r == 0)
      break;

    if ( l > r ) {
      writefln("%d %d", r, l);
    } else {
      writefln("%d %d", l, r);
    }
  }
}
