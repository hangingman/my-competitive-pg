# coding: utf-8
lines = <<'EOS'
4 5
4 2
5 2
2 1
8 3
EOS

#lines = $stdin.read
array = lines.split("\n")

def knapsack(n,w,items)

  dp = Array.new(N+1).map{Array.new(W+1, 0)}

  for i in 1...N+1
    for w in 1...W+1
      if items[i].w <= w
        dp[i][w] = [items[i].v + dp[i-1][w - items[i].w], dp[i-1][w]].max
      else
        dp[i][w] = dp[i-1][w]
      end
    end
  end

  dp
end

Item  = Struct.new(:v, :w)
N,W   = array[0].split(" ").map(&:to_i)

items = [Item.new(0,0)]
array[1..array.length].each do |s|
  item = Item.new
  item.v, item.w = s.split(" ").map(&:to_i)
  items << item
end

dp = knapsack(N,W,items)
puts dp.max.max
