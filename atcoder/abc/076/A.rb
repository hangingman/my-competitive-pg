lines = <<'EOS'
4500
0
EOS

#lines = $stdin.read
array = lines.split("\n")

R = array[0].to_i
G = array[1].to_i

p = 2 * G - R

puts p
