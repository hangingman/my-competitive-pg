#*******************************************************************/
#* This program demonstrates the speedup for a Fenwick tree vs a   */
#* flat array for performing multiple prefix sums.  It generates a */
#* sequence of random numbers, then performs 1000 summations,      */
#* each of which starts and ends at random indices.                */
#*******************************************************************/
class FenwickTree
  attr_accessor :n, :array, :bit

  def initialize(n, array = nil)
    @n = n
    @bit = Array.new(@n+1, 0)
    if array.nil?
      @array = Array.new(@n,0)
    else
      @array = array.dup
    end
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

lines = <<'EOS'
3 5
0 1 1
0 2 2
0 3 3
1 1 2
1 2 2
EOS

#lines = $stdin.read
array = lines.split("\n")
n,q = array[0].split(" ").map(&:to_i)
ft = FenwickTree.new(n, Array.new(n,0))

array[1..1+q].each do |s|
  com,x,y = s.split(" ").map(&:to_i)
  if com == 0
    ft.add(x-1,y)
  else
    puts ft.range(x-1,y-1)
  end
end
