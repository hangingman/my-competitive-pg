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
    #puts "add idx=#{idx} := #{x}"
    idx += 1
    while idx <= @n
      @bit[idx] += x
      #puts "@bit[#{idx}] += #{x} == #{@bit[idx]}"
      #p @bit
      least = idx&-idx
      idx += least
    end
  end

  def lower_bound(w)
    idx,mask = 0,@n2
    while mask != 0
      #puts "idx=#{idx},mask=#{mask}"
      tidx = idx + mask
      if w >= @bit[tidx]
        idx = tidx
        w = w - @bit[idx]
      end
      mask = mask / 2
    end
    idx
  end
end

array  = [5,3,7,9,6,4,1,2,0,0,0,0,0,0,0,0]
#array = [0,2,0,1,1,1,0,4,4,0,1,0,1,2,3,0]
ft = FenwickTree.new(array.length, array)

b = ft.bit.dup

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

puts tree_v
