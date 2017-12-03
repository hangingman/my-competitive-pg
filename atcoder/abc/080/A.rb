lines = <<'EOS'
6 18 100
EOS

#lines = $stdin.read
array = lines.split("\n")

N,A,B = array[0].split(" ").map(&:to_i)

puts [A*N, B].min
