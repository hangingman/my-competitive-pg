$MAX_N=100
$MAX_V=100
INF=10**5
dp = Array.new($MAX_N+1).map{Array.new($MAX_N*$MAX_V+1, INF)}

n = 4
w = 5
wv_h = [ {2=>3}, {1=>2}, {3=>4}, {2=>2} ]

def solve(n, w, wv_h, dp)
  dp[0][0] = 0
  for i in 0...n
    for j in 0..($MAX_N*$MAX_V)
      if j < wv_h[i].keys.first
        dp[i+1][j] = dp[i][j]
      else
        dp[i+1][j] = [dp[i][j], dp[i][j-wv_h[i].values.first] + wv_h[i].keys.first].min
      end
    end
  end
  ans = 0
  for i in 0..$MAX_N*$MAX_V
    ans = i if dp[n][i] <= w
  end
  puts ans
end

solve(n, w, wv_h, dp)
