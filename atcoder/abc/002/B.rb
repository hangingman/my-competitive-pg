lines = $stdin.read
array = lines.split("\n")

name = array[0]

puts name.gsub(/(a|i|u|e|o)/) {|c| ""}
