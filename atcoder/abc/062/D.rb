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
#2
#1 3 3 6 1 7
#EOS

#lines = <<'EOS'
#1
#6 2 10
#EOS
#lines = <<'EOS'
#2
#2 5 9 7 5 3
#EOS
#lines = <<'EOS'
#1
#370204096 966452716 888323438
#EOS

lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
A = array[1].split(" ").map(&:to_i)

max_heap = Heap.new(up: false)
min_heap = Heap.new(up: true)

1.upto(N) do |i|
  max_heap.push(A[i-1])
end
(3*N).downto(2*N+1) do |i|
  min_heap.push(A[i-1])
end

max_heap_tmp = {}
min_heap_tmp = {}

max_heap_tmp[N] = max_heap.sum
min_heap_tmp[2*N] = min_heap.sum

# max_heap
(N+1).upto(2*N) do |k|
  max_heap.push(A[k-1])
  max_heap.pop

  max_heap_tmp[k] = max_heap.sum
end

(2*N).downto(N+1) do |dk|
  min_heap.push(A[dk-1])
  min_heap.pop

  k = dk - 1
  min_heap_tmp[k] = min_heap.sum
end

ans = []
max_heap_tmp.each do |k,v|
  ans << v + min_heap_tmp[k]
end

puts ans.max
