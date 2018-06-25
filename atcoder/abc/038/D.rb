class FenwickTree
  attr_accessor :n, :n2, :array, :left, :right

  def initialize(n, array)
    @n = n
    n2 = 1
    while n2 < n
      n2 <<= 1
    end
    @n2 = n2
    @left = Array.new(@n+1, 0)
    @right = Array.new(@n+1, 0)

    @array = array.dup
    for i in 0...n
      add(i+1,@array[i])
    end
  end

  def G(x)
    x - (x & (x-1))
  end

  def add(idx, x)
    @array[idx-1]=x
    i=idx
    while i<=@n2
      break if i>@n
      @left[i] = [@left[i],x].max
      i=i+G(i)
    end
    i=idx
    while i>0
      @right[i] = [@right[i],x].max
      i=i-G(i)
    end
  end

  # 1-indexed
  def max(l, r)
    ans=0
    i=l
    while i+G(i) <= r
      ans=[ans,right[i]].max
      i=i+G(i)
    end

    ans = i if @array[i-1] > ans
    ans = [ans,@array[i-1]].max
    i=r

    while i-G(i) >= l
      ans=[ans,left[i]].max
      i=i-G(i)
    end
    ans
  end
end

lines = <<'EOS'
3
3 3
1 1
2 2
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
boxes = array[1..N].map do |str|
  arr = str.split(" ").map(&:to_i)
  Hash[*arr]
end.sort_by do |e|
  key,val = e.first
  [key,-val]
end.map{|m| m.values}.flatten

dp = Array.new(N, 0)
fw = FenwickTree.new(N, Array.new(N,0))

for i in 1...N
  dp[i] = fw.max(1, i-1) + 1
  fw.add(i, dp[i])
  p dp
end

p dp.max
