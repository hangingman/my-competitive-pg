# ref: https://qiita.com/superrino130/items/6c8d56203ff4379f5267
class Heap
  attr_reader :size, :heap
  def initialize(up = false)
    @up = up
    @heap = []
    @size = 0
    @s = 0
  end
  def sum
    @s
  end
  def push(prio, obj)
    prio = -prio if @up
    i = @size
    while i > 0
      pid = (i - 1) / 2
      break if prio >= @heap[pid][0]
      @heap[i] = @heap[pid]
      i = pid
    end
    @heap[i] = [prio, obj]
    @size += 1
    @s += prio
  end
  def pop
    return nil if @size == 0
    top = @heap[0]
    @s -= top[0]
    @size -= 1
    prio = @heap[@size][0]
    obj = @heap[@size][1]
    i = 0
    while i * 2 + 1 < @size
      cid1 = i * 2 + 1
      cid2 = cid1 + 1
      if cid2 < @size && @heap[cid2][0] < @heap[cid1][0]
        cid1 = cid2
      end
      break if @heap[cid1][0] >= prio
      @heap[i] = @heap[cid1]
      i = cid1
    end
    @heap[i] = [prio, obj]
    if @up
      return -top[0],top[1]
    else
      return top[0],top[1]
    end
  end
end

lines = <<'EOS'
10 10 10 20
7467038376 5724769290 292794712 2843504496 3381970101 8402252870 249131806 6310293640 6690322794 6082257488
1873977926 2576529623 1144842195 1379118507 6003234687 4925540914 3902539811 3326692703 484657758 2877436338
4975681328 8974383988 2882263257 7690203955 514305523 6679823484 4263279310 585966808 3752282379 620585736
EOS

#lines = $stdin.read
array = lines.split("\n")
X,Y,Z,K = array[0].split(" ").map(&:to_i)

A = array[1].split(" ").map(&:to_i).sort_by { |a| -a }
B = array[2].split(" ").map(&:to_i).sort_by { |b| -b }
C = array[3].split(" ").map(&:to_i).sort_by { |c| -c }

require 'set'
@set = Set.new

@heap = Heap.new(up: true)
i,j,k = 0,0,0
@heap.push(A[i]+B[j]+C[k], "#{i}-#{j}-#{k}")
@set.add("#{i}-#{j}-#{k}")

1.upto(K) do |_|
  n,obj = @heap.pop
  puts n
  i,j,k = obj.split("-").map(&:to_i)

  # puts "#{i}-#{j}-#{k}"
  # p @heap
  # p @set

  if not A[i+1].nil? and not @set.include?("#{i+1}-#{j}-#{k}")
    #puts "push #{i+1}-#{j}-#{k} => #{A[i+1]+B[j]+C[k]}"
    @set.add("#{i+1}-#{j}-#{k}")
    @heap.push(A[i+1]+B[j]+C[k], "#{i+1}-#{j}-#{k}")
  end
  if not B[j+1].nil? and not @set.include?("#{i}-#{j+1}-#{k}")
    #puts "push #{i}-#{j+1}-#{k} => #{A[i]+B[j+1]+C[k]}"
    @set.add("#{i}-#{j+1}-#{k}")
    @heap.push(A[i]+B[j+1]+C[k], "#{i}-#{j+1}-#{k}")
  end
  if not C[k+1].nil? and not @set.include?("#{i}-#{j}-#{k+1}")
    #puts "push #{i}-#{j}-#{k+1} => #{A[i]+B[j]+C[k+1]}"
    @set.add("#{i}-#{j}-#{k+1}")
    @heap.push(A[i]+B[j]+C[k+1], "#{i}-#{j}-#{k+1}")
  end
end
