import std.stdio;
import std.conv;
import std.string;
import std.format;
import std.algorithm;

import std.range : iota;
import std.array;

void main()
{
    int[] array = iota(0, 5).array;
    assert([0, 1, 2, 3, 4] == array);
    writeln(array.map!(s => s.to!string).join(","));
}
