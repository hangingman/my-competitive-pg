lines = <<'EOS'
6 6
1 3 4 6 7 5
1 2 4 8 8 7
2 7 9 2 7 2
9 4 2 7 6 5
2 8 4 6 7 6
3 7 9 1 2 7
EOS

#
# very sorry, hatovalley
# https://beta.atcoder.jp/contests/abc037/submissions/1497549

lines = $stdin.read
array = lines.split("\n")
H,W   = array[0].split(" ").map(&:to_i)

# add empty areas around the matrix
A = [Array.new(W+2, 0)]
H.times do |r|
  A << [0] + array[1+r].split(" ").map(&:to_i) + [0]
end
A << Array.new(W+2, 0)

MOD = 10**9+7

dp = Array.new(H + 2) do |i|
  Hash.new do |h, j|
    v = A[i][j]
    u = A[i + 1][j] > v ? dp[i + 1][j] : 0
    d = A[i - 1][j] > v ? dp[i - 1][j] : 0
    r = A[i][j + 1] > v ? dp[i][j + 1] : 0
    l = A[i][j - 1] > v ? dp[i][j - 1] : 0
    h[j] = (u + d + r + l + 1) % MOD
  end
end

ans = 0

for i in 1..H
  for j in 1..W
    #puts "dp[#{i}][#{j}] = #{dp[i][j]}"
    ans += dp[i][j]
  end
  ans %= MOD
end

puts ans
