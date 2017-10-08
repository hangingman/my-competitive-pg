lines = <<'EOS'
1 2 4 0
EOS

#lines = $stdin.read
array = lines.split("\n")

A,B,C,D = array[0].split(" ").map(&:to_i)

puts 1728*A+144*B+12*C+D
