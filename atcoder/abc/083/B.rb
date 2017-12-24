lines = <<'EOS'
20 2 5
EOS

#lines = $stdin.read
array = lines.split("\n")
N,A,B = array[0].split(" ").map(&:to_i)

sum = 1.upto(N).map do |n|
  s = n.to_s.split("").map(&:to_i).inject(&:+)
  [n,s]
end.select do |e|
  A <= e.last and e.last <= B
end.map do |m|
  m.first
end

puts sum.inject(&:+)
