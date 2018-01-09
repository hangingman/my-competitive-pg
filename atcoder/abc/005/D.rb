lines = <<'EOS'
3
3 2 1
2 2 1
1 1 1
3
1
4
9
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
D = array[1..N].map{|s| s.split(" ").map(&:to_i)}
Q = array[N+1].to_i
P = array[N+2..Q+N+1].map(&:to_i)

I = J = W = H = N

dp = Array.new(I).map{
  Array.new(J).map{
    Array.new(W).map{
      Array.new(H, 0)
    }
  }
}

max_v = {}

for i in 0..N-1
  for j in 0..N-1
    dp[i][j][0][0] = D[i][j]
    max_v[1] = dp[i][j][0][0] if max_v[1].to_i < dp[i][j][0][0]
  end
end

for i in 0..N-1
  for j in 0..N-1
    for h in 1..N-1
      dp[i][j][0][h] = dp[i][j][0][h-1] + dp[i+h][j][0][0] rescue 0
      # puts "dp[#{i}][#{j}][0][#{h}] = #{dp[i][j][0][h]}"
    end
  end
end


for i in 0..N-1
  for j in 0..N-1
    for h in 1..N-1
      for w in 1..N-1
        dp[i][j][w][h] = dp[i][j][w-1][h] + dp[i][j+w][0][h] rescue 0
        # max_v[w*h] = dp[i][j][w][h] if max_v[w*h].to_i < dp[i][j][w][h]
        # puts "dp[#{i}][#{j}][#{w}][#{h}] = #{dp[i][j][w][h]}"
      end
    end
  end
end
