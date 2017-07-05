import std.stdio;
import std.conv;
import std.string;
import std.format;

void compare(int a, int b) {

  if ( a == b ) {
    writefln("a == b");
  } else if (a > b) {
    writefln("a > b");
  } else {
    writefln("a < b");
  }
}

void main()
{
  string s = chomp(readln());
  int a = to!int(s.split(" ")[0]);
  int b = to!int(s.split(" ")[1]);
  compare(a, b);
}
