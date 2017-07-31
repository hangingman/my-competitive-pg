#lines = <<-EOS
#3
#1
#2
#3
#EOS
#array = lines.split("\n")

array = STDIN.each_line.map(&.to_s).to_a

n = array[0].to_i
array.shift
t = array.map(&.to_i).to_a

puts t.min
