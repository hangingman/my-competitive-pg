class FenwickTree
  attr_accessor :n, :n2, :array, :left, :right

  def initialize(n, array)
    @n = n
    n2 = 1
    while n2 < n
      n2 <<= 1
    end
    @n2 = n2
    @left = Array.new(@n2, 0)
    @right = Array.new(@n2, 0)
    @array = array.dup
    for i in 0...n
      add(i+1,@array[i])
    end
  end

  def G(x)
    ans = x - (x & (x-1))
    #puts "G(#{x}) = #{ans}"
    ans
  end

  def add(idx, x)
    @array[idx-1]=x
    i=idx
    while i<=@n2 and i<@left.length
      @left[i] = [@left[i],x].max
      i=i+G(i)
    end
    i=idx
    while i>0 and i<@right.length
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
5
8 8
5 3
2 2
4 2
2 1
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
dp[0]=1

fw = FenwickTree.new(N, Array.new(N,0))
fw.add(1, boxes[0])

for i in 1...N
  #puts "fw.max(1,#{i}) (=#{fw.max(1, i)})<= boxes[#{i}](=#{boxes[i]})"
  if fw.max(1, i) <= boxes[i]
    dp[i] += dp[i-1] + 1
  else
    dp[i] = dp[i-1]
  end
  fw.add(i+1, boxes[i])
end

puts dp.max
