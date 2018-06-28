# coding: utf-8
lines = <<'EOS'
4275631
EOS

#lines = $stdin.read
array = lines.split("\n")
A = array[0].split("").map(&:to_i)
N = array[0].to_s.length

MOD = 1_000_000_007
dp = Array.new(101010).map do
  Array.new(2).map do
    Array.new(2, 0)
  end
end # pos, less, has3
dp[0][0][0] = 1

for i in 0...N
  for j in 0...2
    for k in 0...2
      lim = j.zero? ? A[i] : 9
      for d in 0...lim+1
        less = if not j.zero? or d<lim
                 1
               else
                 0
               end
        has3 = if not k.zero? or d == 3
                 1
               else
                 0
               end
        dp[i+1][less][has3] += dp[i][j][k]
      end
    end
  end
end

ans = 0
for j in 0...2
  ans += dp[N][j][1]
end

puts ans
