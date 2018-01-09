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

for i in 0..N-1
  for j in 0..N-1
    dp[i][j][0][0] = D[i][j]
  end
end

for i in 0..N-1
  for j in 0..N-1
    for h in 1..N-1
      # p dp[i][j][0][h-1]
      # p dp[i+h][j][0][0]
      dp[i][j][0][h] = dp[i][j][0][h-1] + dp[i+h][j][0][0] rescue 0
      puts "dp[#{i}][#{j}][0][#{h}] = #{dp[i][j][0][h]}"
    end
  end
end
