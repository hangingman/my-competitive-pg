COINS = [1, 2, 5, 10, 20, 50, 100, 200]

def coin(amount,kind,coins)
  dp = Array.new(amount+1, 0)
  dp[0] = 1
  for i in 0...kind
    for j in coins[i]..amount
      dp[j] += dp[j - coins[i]]
    end
  end
  dp
end

N,M = 200,COINS.length
dp = coin(N,M,COINS)
puts dp[N]
