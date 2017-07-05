import std.stdio;
import std.conv;
import std.string;
import std.format;

void main()
{
  //string s = chomp(readln());
  //long l = to!long(s);

  string line;
  int count = 0;
  bool loop = true;

  while (loop) {

    line = readln();
    string s = chomp(line);

    int t = to!int(s);

    if (t == 0)
      break;

    count++;
    //if (count == 10000) {
    //  writef("Case %d: %s", count, s);
    //} else {
      writefln("Case %d: %s", count, s);
    //}
  }
}
