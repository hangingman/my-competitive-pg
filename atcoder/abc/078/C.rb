lines = <<'EOS'
10 2
EOS

#lines = $stdin.read
array = lines.split("\n")

N,M = array[0].split(" ").map(&:to_i)

time = 0

time += 1900*2*M

puts time

time += 100*(N-M)

puts 100*(N-M)

puts "+---"
puts time
