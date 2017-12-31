# coding: utf-8
COINS = [1, 2, 3]

def coin(amount,kind,coins)

  coins = [0].concat(coins)
  dp = Array.new(kind+1).map{Array.new(amount+1, 0)}

  dp.each{|row| row[0] = 1}

  for i in 1..kind
    for j in 1..amount
      if i == 1
        dp[i][j] = (j % coins[i] == 0) ? 1 : 0
      else
        # coins[i]を１枚使う方法
        first = dp[i][j - coins[i]]
        # coins[i]を０枚使う方法
        second = dp[i-1][j]

        puts "N = #{j}"
        puts "#{coins[i]} を１枚使う方法 => #{first}"
        puts "#{coins[i]} を０枚使う方法 => #{second}"
        dp[i][j] = first + second
      end
    end
  end
  dp
end

N,M = 5,COINS.length
dp = coin(N,M,COINS)

puts dp.max.max
