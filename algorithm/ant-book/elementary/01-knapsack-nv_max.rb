#!/usr/bin/ruby

require 'minitest/autorun'


def solve(n, w, wv_h, dp)
  dp[0] = 0

  for i in 0...n
    vi,wi = wv_h[i].values.first,wv_h[i].keys.first
    (1...($MAX_N*$MAX_V)).reverse_each do |j|
      dp[j] = [dp[j], dp[j-vi] + wi].min
    end
  end

  #p dp.take(30)
  ans = dp.index(w)
  puts ans
  ans
end

MiniTest.autorun

$MAX_N=100 # 0
$MAX_V=100 # 0
INF=10**5

class Test01Knapsack < MiniTest::Test
  def test_simple

    dp = Array.new($MAX_N*$MAX_V+1, INF)

    # n = 4
    # w = 5
    wv_h = [ {2=>3}, {1=>2}, {3=>4}, {2=>2} ]
    # {w, v} = {2=>3}, {3=>4} ==> {5=>7}
    assert_equal  7, solve(4, 5, wv_h, dp)
    # {w, v} = {2=>3}, {1=>2} ==> {3=>5}
    assert_equal  5, solve(4, 3, wv_h, dp)
  end
end
