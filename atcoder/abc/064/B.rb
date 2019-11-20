
lines = $stdin.read
array = lines.split("\n")

intarr = array[1].split(" ").map(&:to_i)

puts intarr.max - intarr.min
