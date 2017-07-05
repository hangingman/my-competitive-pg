lines = $stdin.read
array = lines.split("\n").map(&:to_i).sort.reverse

puts array[0]
puts array[1]
puts array[2]
