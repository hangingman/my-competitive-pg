#!/usr/bin/ruby

require 'minitest/autorun'

class Combination
  def choose(n, r)
    fact(n) / (fact(r) * fact(n-r))
  end

  def fact(n)
    if n == 0
      1
    else
      n * fact(n-1)
    end
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
end
