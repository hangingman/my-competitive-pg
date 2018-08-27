MAX_N=100
MAX_W=10**4
dp = Array.new(MAX_N+1).map{Array.new(MAX_W+1, 0)}
n = 4
w = 5
wv_h = [ {2=>3}, {1=>2}, {3=>4}, {2=>2} ]

def solve(n, w, wv_h, dp)
  for i in 0...n
    for j in 0..w
      if j < wv_h[i].keys.first
        dp[i+1][j] = dp[i][j]
      else
        dp[i+1][j] = [dp[i][j], dp[i][j-wv_h[i].keys.first]+wv_h[i].values.first].max
      end
    end
  end
  puts "%d" % dp[n][w]
end

solve(n, w, wv_h, dp)
