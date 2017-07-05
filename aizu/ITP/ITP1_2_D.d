import std.stdio;
import std.conv;
import std.string;
import std.format;
  
void main()
{
  string s = chomp(readln());
  string[] array = s.split(" ");
  
  int W = to!int(array[0]);
  int H = to!int(array[1]);
  int x = to!int(array[2]);
  int y = to!int(array[3]);
  int r = to!int(array[4]);
  
  // (0, 0) <= (x, y) <= (W, H)
  int left   = x - r;
  int right  = x + r;
  if ( (0 <= left && left <= W) &&
       (0 <= right && right <= W)) {
  
  } else {
    writeln("No");
    return;
  }
  
  int upper  = y + r;
  int bottom = y - r;
  
  if ( (0 <= upper && upper <= H) &&
       (0 <= bottom && bottom <= H)) {
    writeln("Yes");
  } else {
    writeln("No");
  }
}
