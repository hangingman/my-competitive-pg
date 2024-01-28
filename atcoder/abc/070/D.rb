class TreeDP
  attr_reader :dp

  def initialize(size, edges)
    @dp = Array.new(size, 0)
    @graph = Array.new(size) { [] } # 隣接リスト
    @cost = {}
    edges.each do |u, v, c|
      @graph[u - 1] << v - 1
      @graph[v - 1] << u - 1
      @cost[[u - 1, v - 1]] = c
      @cost[[v - 1, u - 1]] = c
    end
  end

  def merge(children_dp)
    #children_dp.max
  end

  def add_root(d, w)
    d + w
  end

  def dfs(v, pi = -1)
    cost = @cost[[pi, v]].to_i
    #@dp[v] = cost unless pi == -1
    @dp[v] = add_root(@dp[pi].to_i, cost) unless pi == -1

    @graph[v].reject{|u| u==pi}.each do |u|
      dfs(u, v)
    end

    #@dp[v] = add_root(@dp[pi].to_i, cost) unless pi == -1
  end
end

lines = <<'EOS'
5
1 2 1
1 3 1
2 4 1
3 5 1
3 1
2 4
2 3
4 5
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
edges = array[1..N-1].map do |e|
  e.split(" ").map(&:to_i)
end
Q, K = array[N].split(" ").map(&:to_i)

tree_dp = TreeDP.new(N, edges)
tree_dp.dfs(K-1)

array[N+1..N+1+Q].each do |line|
  u, v = line.split(" ").map(&:to_i)
  puts tree_dp.dp[u-1] + tree_dp.dp[v-1]
end
