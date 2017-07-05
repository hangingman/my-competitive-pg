import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

void compare(int a, int b, int c) {

  int[] array = [a, b, c];
  sort!("a < b")(array);
  write(array[0]);
  write(" ");
  write(array[1]);
  write(" ");
  writeln(array[2]);
}

void main()
{
  string s = chomp(readln());
  int a = to!int(s.split(" ")[0]);
  int b = to!int(s.split(" ")[1]);
  int c = to!int(s.split(" ")[2]);
  compare(a, b, c);
}
