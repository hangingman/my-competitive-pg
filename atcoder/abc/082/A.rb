lines = <<'EOS'
1 3
EOS

#lines = $stdin.read
array = lines.split("\n")

A,B = array[0].split(" ").map(&:to_f)
puts ((A+B)/2).ceil
