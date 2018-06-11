MOD = 1_000_000_007

class Combination
  def initialize(size)
    @fact = (1..size).to_a
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

lines = $stdin.read
array = lines.split("\n")
$n = array[0].to_i
$k = array[1].to_i
@comb = Combination.new($n+$k)

# nHr => n+r-1Cr
# puts "#{$n}H#{$k}"
ans = @comb.choose($n+$k-1, $n-1)
puts ans
