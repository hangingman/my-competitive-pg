# ref: https://qiita.com/superrino130/items/6c8d56203ff4379f5267
class Heap
  attr_reader :size
  def initialize(up: false)
    @up = up
    @heap = []
    @size = 0
  end
  def sum
    x = 0
    @size.times do |i|
      x += @heap[i]
    end
    x
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
  end
  def pop
    return nil if @size == 0
    top = @heap[0]
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

lines = <<'EOS'
10 1
1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000
EOS

#lines = $stdin.read
array = lines.split("\n")
N,M = array[0].split(" ").map(&:to_i)

heap = Heap.new(up: true)
array[1].split(" ").map(&:to_i).each do |e|
  heap.push(e)
end

1.upto(M) do |m|
  most_expensive = heap.pop
  discount_cost = most_expensive/2

  #puts "expensive=#{most_expensive}, cost=#{discount_cost}"
  heap.push(discount_cost)
end

puts heap.sum.abs
