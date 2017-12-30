# coding: utf-8
lines = <<'EOS'
100 6
1 72 93 34 24 37
EOS

#lines = $stdin.read
array = lines.split("\n")

INF = 1 << 25

def coin(amount,kind,coins)
  dp = Array.new(amount+1, INF)
  dp[0] = 0
  for i in 0...kind
    for j in coins[i]..amount
      dp[j] = [dp[j], dp[j - coins[i]] + 1].min
    end
  end
  dp
end

N,M = array[0].split(" ").map(&:to_i)
coins = array[1].split(" ").map(&:to_i)

dp = coin(N,M,coins)
puts dp[N]
