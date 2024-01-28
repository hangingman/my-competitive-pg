class TreeDP
  attr_reader :dp

  def initialize(size, edges)
    @dp = Array.new(size, 0)
    @graph = Array.new(size) { [] } # 隣接リスト
    edges.each do |u, v|
      @graph[u - 1] << v - 1
      @graph[v - 1] << u - 1
    end
  end

  def merge(children_dp)
    children_dp.max
  end

  def add_root(d)
    d + 1
  end

  def dfs(v, pi = -1)
    deg = @graph[v].size
    if deg == 1 # 末端にいる時
      @dp[v] = 0
      return
    end

    children_dp = @graph[v].reject { |u| u == pi }.map do |u|
      dfs(u, v)  # dp[u] の計算
      @dp[u]  # 子のDP値をリストに追加
    end

    dp_cum = merge(children_dp)  # 子ノードのDP値の最大値を計算
    @dp[v] = add_root(dp_cum)  # 2.の計算
  end
end

require 'minitest/autorun'

class TestTreeDP < MiniTest::Test
  def test_dp_max
    edges = [[1, 2], [1, 3], [1, 4], [3, 5], [3, 6], [4, 7]]
    tree_dp = TreeDP.new(7, edges)
    tree_dp.dfs(0)  # 根はノード0 (1-indexedで1)
    assert_equal 2, tree_dp.dp.max
  end
end
