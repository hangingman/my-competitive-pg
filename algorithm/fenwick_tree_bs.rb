# coding: utf-8
#*******************************************************************/
#* Add binary search method
#*******************************************************************/
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
    while i<= @n2
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

#        1,2,3,4,5,6,7,8,9,a,b,c,d,e,f
#array = [1,0,2,1,1,3,0,4,2,5,2,2,3,1,0]
ft = FenwickTree.new(array.length, array)
