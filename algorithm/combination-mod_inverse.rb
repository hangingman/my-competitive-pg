#!/usr/bin/ruby

require 'minitest/autorun'

MOD = 1_000_000_007

class Combination
  def initialize
    @fact = (1..10000).to_a
    @fact.each_with_index do |e, idx|
      @fact[idx] = @fact[idx] * @fact[idx-1] % MOD if idx > 0
    end
  end

  def choose(n, r)
    fact(n) * inverse( fact(r) * fact(n-r) % MOD ) % MOD
  end

  def fact(n)
    @fact[n-1]
  end

  def inverse(x)
    pow(x, MOD-2)
  end

  def pow(x, n)
    ans = 1
    while n > 0
      ans = ans * x % MOD if n.odd?
      x = x * x % MOD
      n >>= 1
    end
    ans
  end
end

MiniTest.autorun

class TestCombination < MiniTest::Test
  def setup
    @comb = Combination.new
  end
  def test_choose_simple
    assert_equal 2, @comb.choose(2, 1)
    assert_equal 3, @comb.choose(3, 2)
    assert_equal 10, @comb.choose(5, 2)
  end

  def test_choose_medium
    assert_equal 45, @comb.choose(10, 2)
    assert_equal 435, @comb.choose(30, 2)
    assert_equal 15504, @comb.choose(20, 5)
  end

  def test_choose_large
    assert_equal 142506, @comb.choose(30, 5)
    assert_equal 169911, @comb.choose(31, 5)
    assert_equal 294109729200 % MOD, @comb.choose(150, 7)
  end
end
