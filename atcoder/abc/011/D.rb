MOD = 1_000_000_007

class Combination
  def initialize(n)
    @fact = (1..n).to_a
    @fact.each_with_index do |e, idx|
      @fact[idx] = @fact[idx] * @fact[idx-1] % MOD if idx > 0
    end
  end

  def choose(n, r)
    puts "#{n}C#{r}"
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

lines = <<'EOS'
11 8562174
25686522 17124348
EOS

#lines = $stdin.read
array = lines.split("\n")
N,D = array[0].split(" ").map(&:to_i)
X,Y = array[1].split(" ").map(&:to_i)

ans  = 0
comb = Combination.new(N*D)

for k in 1..N
  # p k
  lr_move_k = k*D
  ud_move_k = (N-k)*D
  #p ud_move_k

  lr_r = (lr_move_k+X)/2
  ud_r = (ud_move_k+Y)/2
  #p ud_r

  lr = comb.choose(lr_move_k, lr_r)
  ud = comb.choose(ud_move_k, ud_r)
  # puts "#{lr_move_k}C#{lr_r}=#{left} + #{ud_move_k}C#{ud_r}=#{right}"
  ans += (lr*ud)
end

puts ans.quo(4**N).to_f
