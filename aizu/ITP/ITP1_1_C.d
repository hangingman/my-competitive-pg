import std.stdio;
import std.conv;
import std.string;

void main()
{
  string s = chomp(readln()); // ??????????????????
  int x = to!int(s.split(" ")[0]);
  int y = to!int(s.split(" ")[1]);
  write(x*y);
  write(" ");
  writeln(2*x+2*y);
}
