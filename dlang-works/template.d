import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

void main()
{

  //string lines;
  //string buf;
  //
  //while (!stdin.eof) {
  //  buf = stdin.readln();
  //  lines ~= buf;
  //}

  string lines = q"[
  ]";

  string[] array = splitLines(lines);
  writeln(to!string(array));
}
