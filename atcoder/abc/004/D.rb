# coding: utf-8
lines = <<'EOS'
17 2 34
EOS

#lines = $stdin.read
array = lines.split("\n")

R,G,B = array[0].split(" ").map(&:to_i)
INF   = 1 << 25
dp    = Array.new(1000).map{ Array.new(1000, 0) }
total = R+G+B

def cost(pos, remain)
  if remain >= G+B
    (400-pos).abs
  elsif remain >= B
    (500-pos).abs
  else
    (600-pos).abs
  end
end

for i in 0...1000
  for j in 0...1000
    dp[i][j] = INF
  end
end
for i in 0...1000
  dp[i][total] = 0
end

for i in 1...1000
  for j in 0...total
    dp[i][j] = [ dp[i-1][j], dp[i-1][j+1] + cost(i,j) ].min
  end
  t = dp[i].take(total).map do |e|
    e = if e == INF
          "I"
        else
          e
        end
    e
  end
  p t
end

ans = INF
for i in 0...1000
  ans = [ans, dp[i][0]].min
end

puts ans
