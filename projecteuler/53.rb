MOD = 1_000_000_007

class Combination
  def initialize(n)
    @fact = (1..n).to_a
    @fact.each_with_index do |e, idx|
      @fact[idx] = @fact[idx] * @fact[idx-1] % MOD if idx > 0
    end
  end

  def choose(n, r)
    return 0 if not (0 <= r and r <= n)
    return 1 if r == 0 or r == n
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

ans  = 0
comb = Combination.new(100)
for n in 1..100
  for r in 1..n
    ncr = comb.choose(n,r)
    if ncr > 10**6
      puts "#{n}C#{r} = #{ncr}"
      ans += 1
    end
  end
end
puts ans
