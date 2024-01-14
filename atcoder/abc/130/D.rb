class FenwickTree
  attr_accessor :n, :n2, :array, :bit

  def initialize(n, array)
    @n = n
    n2 = 1
    while n2 < n
      n2 <<= 1
    end
    @n2 = n2 >>= 1
    @bit = Array.new(@n+1, 0)
    @array = array.dup
    for i in 0..n
      add(i, @array[i])
    end
  end

  def sum(idx)
    ans = 0
    idx += 1
    while not idx.zero?
      ans += @bit[idx]
      least = idx&-idx
      idx -= least
    end
    ans
  end

  def range(left, right)
    if left > right
      0
    else
      sum(right)-sum(left)
    end
  end

  def add(idx, x)
    idx += 1
    while idx <= @n
      @bit[idx] += x
      least = idx&-idx
      idx += least
    end
  end

  def lower_bound(w)
    return 0 if w <= 0

    x = 0
    k = @n2
    while k > 0
      if x + k <= @n and @bit[x+k] < w
        w -= @bit[x+k]
        x += k
      end
      k /= 2
    end

    return nil if x+1>@array.size
    return nil if @array[x]<w

    x
  end
end

lines = <<'EOS'
10 53462
103 35322 232 342 21099 90000 18843 9010 35221 19352
EOS
#lines = $stdin.read
array = lines.split("\n")
N,K = array[0].split(" ").map(&:to_i)
A = array[1].split(" ").map(&:to_i)
@ft = FenwickTree.new(A.length, A)

ans = 0
s = K
ft_max = @ft.sum(N-1)

1.upto(N) do |n|
  if s > ft_max
    next
  end
  idx = @ft.lower_bound(s)

  unless idx.nil?
    ans += (N-idx)
  end

  s += A[n-1]
end

puts ans
