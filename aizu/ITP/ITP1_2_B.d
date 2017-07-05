import std.stdio;
import std.conv;
import std.string;
import std.format;

void main()
{
  string s = chomp(readln());
  int a = to!int(s.split(" ")[0]);
  int b = to!int(s.split(" ")[1]);
  int c = to!int(s.split(" ")[2]);

  if ( a < b && b < c ) {
    writeln("Yes");
  } else {
    writeln("No");
  }
}
