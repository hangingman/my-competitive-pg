lines = <<'EOS'
8 6 20
EOS

#lines = $stdin.read
array = lines.split("\n")
A,B,C = array[0].split(" ").map(&:to_i)

count_a1 = C / A
count_b1 = (C - count_a1 * A) / B
p1 = count_a1 + count_b1

count_a2 = C / B
count_b2 = (C - count_a2 * B) / A
p2 = count_a2 + count_b2

puts [p1,p2].max
