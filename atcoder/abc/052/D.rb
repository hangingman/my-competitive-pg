lines = <<'EOS'
7 1 100
40 43 45 105 108 115 124
EOS

#lines = $stdin.read
array = lines.split("\n")
N,A,B = array[0].split(" ").map(&:to_i)
X = array[1].split(" ").map(&:to_i)

ans = 0
for i in 0...N-1
  ans += [(X[i+1] - X[i])*A, B].min
end
puts ans
