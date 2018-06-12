#*******************************************************************/
#* This program demonstrates the speedup for a Fenwick tree vs a   */
#* flat array for performing multiple prefix sums.  It generates a */
#* sequence of random numbers, then performs 1000 summations,      */
#* each of which starts and ends at random indices.                */
#*******************************************************************/
class FenwickTree
  attr_accessor :size, :array, :bit

  def initialize()
    @size = 1<<10
    @array = (1..@size+1).to_a
    @bit = Array.new(@size+1, 0)
    @array.each_with_index{|e,i| add(i+1, e)}
  end

  def sum(a)
    # return the sum of the first i elements, 0 through i-1.
    ans = 0
    while a
      ans += @bit[a]
      least = a&-a
      a-=least
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

  def add(a, x)
    while a <= @size
      @bit[a] += x
      least = a&-a
      a += least
    end
  end
end

# start
lines = <<'EOS'
3 5
0 1 1
0 2 2
0 3 3
1 1 2
1 2 2
EOS

ft = FenwickTree.new

#lines = $stdin.read
array = lines.split("\n")

array.drop(1).each do |line|
  q,x,y = line.split(" ").map(&:to_i)
  if q == 0
    ft.add(x, y)
  else
    puts ft.range(x, y)
  end
end
