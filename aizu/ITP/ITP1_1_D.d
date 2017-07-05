import std.stdio;
import std.conv;
import std.string;

void main()
{
  string s = chomp(readln());
  long sec = to!long(s);

  string hh = to!string(sec / 3600);
  string mm = to!string((sec % 3600) / 60);
  string ss = to!string(sec % 3600 % 60);

  write(hh);
  write(":");
  write(mm);
  write(":");
  writeln(ss);
}
