MOD = 1_000_000_007

class Combination
  def initialize
    @fact = (1..10**5*2+1).to_a
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

#lines = <<'EOS'
#2 3 1 1
#EOS
lines = <<'EOS'
100000 100000 44444 55555
EOS

#lines = $stdin.read
array = lines.split("\n")
H,W,A,B = array[0].split(" ").map(&:to_i)

@comb = Combination.new
ans = 0

max_n1,max_n2 = 0,0

for i in B...W
  n1,r1 = H-A-1+i,i
  #max_n1 = [n1,max_n1].max
  #puts max_n1
  ans1  = @comb.choose(n1,r1) % MOD

  h,w   = A-1,W-1-i
  n2,r2 = h+w,w
  #max_n2 = [n2,max_n2].max
  #puts max_n2
  ans2  = @comb.choose(n2,r2) % MOD

  ans += ans1*ans2%MOD
end

puts ans%MOD
