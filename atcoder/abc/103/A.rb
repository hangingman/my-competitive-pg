lines = <<'EOS'
100 100 100
EOS

#lines = $stdin.read
array = lines.split("\n")
A = array[0].split(" ").map(&:to_i).sort

ans = A.each_cons(2).map do |arr|
  (arr.first-arr.last).abs
end.inject(&:+)

puts ans
