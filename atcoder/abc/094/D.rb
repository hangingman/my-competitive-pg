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

@comb = Combination.new

lines = $stdin.read
array = lines.split("\n")

# https://detail.chiebukuro.yahoo.co.jp/qa/question_detail/q1155016236
# nが偶数のときはr=n/2
# nが奇数のときはr=(n-1)/2,(n+1)/2
# で最大値をとることになります．

N = array[0].to_i
A = array[1].split(" ").map(&:to_i).sort.reverse

ans = [0,0,0]

A.each do |n|
  r = A.select{|e| e<n}
  next if r.empty?

  max_r_idx = r.map.with_index{|e,idx| [(n/2-e).abs,idx]}.min_by{|arr| arr.first}.last
  max_r = r[max_r_idx]
  max_comb = @comb.choose(n,max_r)%MOD
  #puts "n=#{n}, r=#{r}, max_r=#{max_r}, max_comb=#{max_comb}"
  ans = [n,max_r,max_comb] if max_comb > ans[2]
  break
end

puts "#{ans[0]} #{ans[1]}"
