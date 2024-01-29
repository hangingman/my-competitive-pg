class TreeDP
  attr_reader :dp

  def initialize(size, edges, counter={})
    @dp = Array.new(size, 0)
    @graph = Array.new(size) { [] } # 隣接リスト
    edges.each do |u, v, c|
      @graph[u - 1] << v - 1
      @graph[v - 1] << u - 1
    end
    @counter = counter
  end

  def merge(children_dp)
    #children_dp.max
  end

  def add_root(d, w)
    d + w
  end

  def dfs(v, pi = -1)

    w = @counter[v].to_i
    @dp[v] = add_root(@dp[pi].to_i, w)

    @graph[v].reject{|u| u==pi}.each do |u|
      dfs(u, v)
    end
  end
end

lines = <<'EOS'
4 3
1 2
2 3
2 4
2 10
1 100
3 1
EOS

#lines = $stdin.read
array = lines.split("\n")
N,Q = array[0].split(" ").map(&:to_i)


edges = array[1..N-1].map do |e|
  e.split(" ").map(&:to_i)
end
counter = {}
array[N..N+Q].each do |c|
  u, c = c.split(" ").map(&:to_i)
  counter[u-1] = counter[u-1].to_i + c
end

tree_dp = TreeDP.new(N, edges, counter)
tree_dp.dfs(0)

puts tree_dp.dp.join(" ")
