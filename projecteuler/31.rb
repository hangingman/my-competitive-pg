# coding: utf-8
#
# There are 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
#

COINS    = [1, 2, 5, 10, 20, 50, 100, 200]
# N      = COINS.length

DP_COINS = COINS.map do |c|
  Array.new(c, 200/c)
end.flatten.sort

DP_COINS
N = DP_COINS.length

def knapsack(i, j, array)
  if i == N
    array
  elsif j < DP_COINS[i]
    knapsack(i+1, j, array)
  else
    array << DP_COINS[i]
    knapsack(i+1, j-DP_COINS[i], array)
    #knapsack(i+1, j-COINS[i], array)
  end
end

ans = []

#for idx in 0..COINS.length
for idx in 0..DP_COINS.length
  coin = knapsack(idx, 200, [])

  if coin.inject(&:+) == 200
    puts coin.map{|c| coin.count{|n| n == c}}.to_s
  end

  #puts "#{coin.inject(&:+)} = #{coin.uniq.to_}" if coin.inject(&:+) == 200
  ans << coin if coin.inject(&:+) == 200
end

puts ans.length
