# coding: utf-8
#*******************************************************************/
#* Add binary search method
#*******************************************************************/
class FenwickTree
  attr_accessor :n, :n2, :array, :bit

  def initialize(n, array)
    @n = n
    n2 = 1
    while n2 < n
      # prepare smallest exponent of 2 larger than N
      # With the 16-element table of the examples here,
      # the initial value of Mask would be 8
      n2 <<= 1
    end
    @n2 = n2 >>= 1
    @bit = Array.new(@n+1, 0)
    @array = array.dup
    for i in 0..n
      add(i,@array[i])
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
      sum(right)-sum(left-1)
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
    idx,mask = 0,@n2
    while mask != 0
      tidx = idx + mask
      if w >= @bit[tidx]
        idx = tidx
        w = w - @bit[idx]
      end
      mask = mask / 2
    end
    idx
  end

  def lsb(n)
    n&-n
  end

  # left
  def parent_l(n)
    n -= lsb(n)
    n
  end

  # right
  def parent_r(n)
    n += lsb(n)
    n
  end

  def min(l,r)
    puts "#{l} to #{r}"
    val = Float::INFINITY
    i = l
    while parent_r(i) <= r
      val = [val, @bit[i]].min
      i = parent_r(i)
    end
    i = r
    while parent_l(i) >= l
      val = [val, @bit[i]].min
      i = parent_l(i)
    end
    val = [val, @array[i]].min
    val
  end
end

array = [1,0,2,1,1,3,0,4,2,5,2,2,3,1,0]
ft = FenwickTree.new(array.length, array)

b = [0].concat(ft.array).dup

tree_v = <<EOS
                           ８(#{b[8]})
                         ／  ＼
                       ／      ＼
                     ／          ＼
                   ／              ＼
                 ／                  ＼
               ４(#{b[4]})                 12(#{b[12]})
             ／  ＼                  ／  ＼
           ／      ＼              ／      ＼
         ２(#{b[2]})       ６(#{b[6]})      10(#{b[10]})      14(#{b[14]})
       ／  ＼      ／  ＼      ／  ＼      ／  ＼
 ０  １      ３  ５      ７  ９      11  13      15
(#{b[0]}) (#{b[1]})     (#{b[3]}) (#{b[5]})    (#{b[7]}) (#{b[9]})     (#{b[11]}) (#{b[13]})     (#{b[5]})
EOS

#puts tree_v

#         1,2,3,4,5,6,7,8,9,a,b,c,d,e,f
#array = [1,0,2,1,1,3,0,4,2,5,2,2,3,1,0]

# 1-indexed
#l,r = 2,7
#l,r = 3,6
l,r = 9,11
puts "min = #{ft.min(l,r)}"
puts "summary = #{ft.array[l-1,r-l+1]}"

puts tree_v
