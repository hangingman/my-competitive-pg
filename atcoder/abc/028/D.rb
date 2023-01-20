lines = <<'EOS'
765 573
EOS

#lines = $stdin.read
array = lines.split("\n")

N,K = array[0].split(" ").map(&:to_i)
MAX_N = 10**6
MOD = 1_000_000_007

class Combination
  def initialize
    @fact = (1..MAX_N).to_a
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

@c = Combination.new

all_comb = N**3
# puts "Kx3 = 1"
# puts "Kx2 = #{(3 * @c.choose(N-K,1))}"
# puts "Kx2 = #{(3 * @c.choose(K-1,1))}"
# puts "Kx3 = "

comb = 1 \
       + (3 * @c.choose(N-K,1)) \
       + (3 * @c.choose(K-1,1)) \
       + @c.choose(K-1,1) * @c.choose(N-K,1) * 6

printf("%.10f\n", comb.quo(all_comb).to_f)
