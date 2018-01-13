lines = <<'EOS'
2 4
EOS

#lines = $stdin.read
array = lines.split("\n")

H1 = array[0].to_i
H2 = array[1].to_i

puts H1 - H2
