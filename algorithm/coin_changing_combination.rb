# coding: utf-8
COINS = [1, 2, 5, 10, 20, 50, 100, 200]

def coin(amount,kind,coins)

  coins = [0].concat(coins)
  dp = Array.new(kind+1).map{Array.new(amount+1, 0)}
  dp.each{|row| row[0] = 1}

  for i in 1..kind
    for j in 1..amount
      dp[i][j] = dp[i][j - coins[i]] + dp[i-1][j]
    end
  end
  dp
end

N,M = 200,COINS.length
dp = coin(N,M,COINS)
p dp.max.max
