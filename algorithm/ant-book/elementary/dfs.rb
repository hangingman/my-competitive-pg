#!/usr/bin/ruby
# coding: utf-8

# テスト用
require 'minitest/autorun'

class PartialSum
  attr :a,:n,:k

  def initialize(a,n,k)
    @a,@n,@k=a,n,k.dup
  end

  def dfs(i, sum)
    return sum==@k if i==@n
    return true if dfs(i+1,sum)
    return true if dfs(i+1,sum+@a[i])
    return false
  end
end

#
# ここからテスト
#
MiniTest.autorun

class TestCombination < MiniTest::Test
  def test_dfs_partial_sum
    # 数列 [1,2,4,7] を使って
    # 13 を作ることができる？
    # => true
    ps1 = PartialSum.new([1,2,4,7],4,13)
    assert_equal true, ps1.dfs(0,0)
    # 数列 [1,2,4,7] を使って
    # 15 を作ることができる？
    # => false
    ps2 = PartialSum.new([1,2,4,7],4,15)
    assert_equal false, ps2.dfs(0,0)
  end
end
