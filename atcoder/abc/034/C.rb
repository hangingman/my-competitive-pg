MOD = 1_000_000_007

class Combination
  def initialize
    @fact = (1..10**5*2).to_a
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

lines = <<'EOS'
123 456
EOS

#lines = $stdin.read
array = lines.split("\n")
W,H   = array[0].split(" ").map(&:to_i)
comb  = Combination.new
#puts "W=#{W-1},H=#{H-1}"
puts comb.choose(H+W-2,W-1) % MOD
