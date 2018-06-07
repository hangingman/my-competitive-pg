# coding: utf-8
MOD = 1_000_000_007

class Combination
  def initialize
    @fact = (1..10**5+1).to_a
    @fact.each_with_index do |e, idx|
      @fact[idx] = @fact[idx] * @fact[idx-1] % MOD if idx > 0
    end
  end

  def choose(n, r)
    return 0 if not (0 <= r and r <= n)
    return 1 if r == 0 or r == n
    fact(n) * inverse( fact(r) * fact(n-r) )
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

lines = <<'EOS'
32
29 19 7 10 26 32 27 4 11 20 2 8 16 23 5 14 6 12 17 22 18 30 28 24 15 1 25 3 13 21 19 31 9
EOS
#lines = $stdin.read
array = lines.split("\n")

N  = array[0].to_i
A  = array[1].split(" ").map(&:to_i)

DUPL = A.group_by{|i| i}.reject{|k,v| v.one?}.keys.first

LEFT, RIGHT = A.index(DUPL), A.rindex(DUPL)
DUPL_N = LEFT + (A.length - RIGHT - 1)

@comb = Combination.new

A.each_with_index do |elem, idx|
  puts (@comb.choose(A.length, idx+1) % MOD - @comb.choose(DUPL_N, idx) % MOD)
end
