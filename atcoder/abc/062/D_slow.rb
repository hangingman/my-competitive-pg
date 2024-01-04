# 062 Dを優先度つきキューで愚直に実装したもの

# ref: https://qiita.com/superrino130/items/6c8d56203ff4379f5267
class Heap
  attr_reader :size, :heap
  def initialize(up: false)
    @up = up
    @heap = []
    @size = 0
    @s = 0
  end
  def sum
    @s
  end
  def push(n)
    n = -n if @up
    i = @size
    while i > 0
      pid = (i - 1) / 2
      break if n >= @heap[pid]
      @heap[i] = @heap[pid]
      i = pid
    end
    @heap[i] = n
    @size += 1
    @s += n
  end
  def pop
    return nil if @size == 0
    top = @heap[0]
    @s -= top
    @size -= 1
    n = @heap[@size]
    i = 0
    while i * 2 + 1 < @size
      cid1 = i * 2 + 1
      cid2 = cid1 + 1
      if cid2 < @size && @heap[cid2] < @heap[cid1]
        cid1 = cid2
      end
      break if @heap[cid1] >= n
      @heap[i] = @heap[cid1]
      i = cid1
    end
    @heap[i] = n
    if @up
      -top
    else
      top
    end
  end
end

#lines = <<'EOS'
#3
#8 2 2 7 4 6 5 3 8
#EOS
#lines = <<'EOS'
#1
#1 2 3
#EOS

lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

max_heap = Heap.new(up: false)
A = array[1].split(" ").map(&:to_i)


ans = 0

1.upto(N) do |i|
  max_heap.push(A[i-1])
end
min_heap = Heap.new(up: true)
(N+1).upto(3*N) do |i|
  min_heap.push(A[i-1])
end
while min_heap.size != N
  min_heap.pop
end

#puts "max #{max_heap.sum}, min #{min_heap.sum.abs}"
ans = max_heap.sum - min_heap.sum.abs

(N+1).upto(2*N) do |k|

  max_heap.push(A[k-1])
  max_heap.pop

  min_heap = Heap.new(up: true)
  (k+1).upto(3*N) do |i|
    min_heap.push(A[i-1])
  end
  while min_heap.size != N
    min_heap.pop
  end
  #puts "max #{max_heap.sum}, min #{min_heap.sum.abs}"
  ans = [ans, max_heap.sum - min_heap.sum.abs].max
end

puts ans
