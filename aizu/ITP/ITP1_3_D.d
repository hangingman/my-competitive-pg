import std.stdio;
import std.conv;
import std.string;
import std.format;

void main()
{
  string s = chomp(readln());
  int min = to!int(s.split(" ")[0]);
  int max = to!int(s.split(" ")[1]);
  int val = to!int(s.split(" ")[2]);

  int result = 0;

  for (int i = min; i <= max; i++ ) {
    if (val % i == 0) {
      result++;
    }
  }

  writeln(result);
}
