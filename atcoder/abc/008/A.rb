lines = <<'EOS'
1 1
EOS

#lines = $stdin.read
array = lines.split("\n")

S,T = array[0].split(" ").map(&:to_i)
puts T-S+1
