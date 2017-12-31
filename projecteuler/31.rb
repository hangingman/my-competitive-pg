# coding: utf-8
#
# There are 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
#
# -------------------------------------------------------------
#
# ...If you use linear processing program
# $ time ruby 31.rb
# 73682
#
# real    0m3.901s
# user    0m0.000s
# sys     0m0.015s
#
# ...If you use dynamic programming !
# $ time ruby 31.rb
# real	0m0.097s
# user	0m0.052s
# sys	0m0.012s
# -------------------------------------------------------------

COINS = [1, 2, 5, 10, 20, 50, 100, 200]
INF   = 1 << 25

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
p dp
puts dp[N]
