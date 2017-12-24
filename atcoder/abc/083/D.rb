lines = <<'EOS'
1111
EOS

#lines = $stdin.read
array = lines.split("\n")
S = array[0]
N = S.length

ans = [N-1]

for i in 1...N
  first, second = S[i-1], S[i]
  if first != second
    ans << [i-1, N-i-1].max
  end
  # p ans
end

puts (ans.min).to_i + 1
