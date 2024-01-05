# ref: https://qiita.com/superrino130/items/6c8d56203ff4379f5267
require 'set'

class Heap
  attr_reader :size, :heap, :set
  def initialize(up = false)
    @up = up
    @heap = []
    @size = 0
    @s = 0
    @set = Set.new
  end
  def has?(obj)
    @set.include?(obj)
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
    @set.add(obj)
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
    @set.delete(obj)
    if @up
      return -top[0],top[1]
    else
      return top[0],top[1]
    end
  end
end


require 'minitest/autorun'

class TestHeap < MiniTest::Test
  def test_push_and_pop_with_default_priority
    @heap = Heap.new()

    @heap.push(5, "apple")
    @heap.push(3, "banana")
    @heap.push(7, "cherry")

    assert_equal 15, @heap.sum
    assert_equal 'banana', @heap.pop[1]
    assert_equal 'apple' , @heap.pop[1]
    assert_equal 'cherry', @heap.pop[1]
    assert_equal 0, @heap.sum
  end

  def test_push_and_pop_with_up_flag
    @heap = Heap.new(true)
    @heap.push(5, 'apple')
    @heap.push(3, 'banana')
    @heap.push(7, 'cherry')

    assert_equal (-15), @heap.sum
    assert_equal 'cherry', @heap.pop[1]
    assert_equal 'apple' , @heap.pop[1]
    assert_equal 'banana', @heap.pop[1]
    assert_equal 0, @heap.sum
  end

  def test_empty_heap_pop
    @heap = Heap.new
    assert_nil @heap.pop
  end
end
