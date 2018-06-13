#*******************************************************************/
#* This program demonstrates the speedup for a Fenwick tree vs a   */
#* flat array for performing multiple prefix sums.  It generates a */
#* sequence of random numbers, then performs 1000 summations,      */
#* each of which starts and ends at random indices.                */
#*******************************************************************/
class FenwickTree
  attr_accessor :n, :array, :bit

  def initialize(n, array)
    @n = n
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
end

array = [2, 1, 1, 3, 2, 3, 4, 5, 6, 7, 8, 9]
ft = FenwickTree.new(array.length, array)

p ft.bit
puts ft.sum(5)
