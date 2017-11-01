lines = <<'EOS'
4
1 1/1
2 1/3
3 5/2
4 2178309/1346269
EOS

class Array
  alias_method :enq, :push
  alias_method :deq, :shift
end

def follow_parents(l, r, depth, queue)
  #puts "#{l}, #{r}, d = #{depth}"

  return depth if l == 1 and r == 1

  depth += 1

  if l > r
    q = r
    p = l - q
    queue.enq(1)
    follow_parents(p, q, depth, queue)
  else
    p = l
    q = r - p
    queue.enq(0)
    follow_parents(p, q, depth, queue)
  end
end

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

#
# left  = p / ( p + q )
# right = (p + q) / q
#
for i in 1...array.size
  l,r   = array[i].split(" ")[1].split("/").map(&:to_i)
  depth = 1
  queue = []

  depth = follow_parents(l, r, depth, queue)
  depth_min = 2**(depth-1)
  depth_max = 2**(depth)-1

  sib = queue.reverse.join.to_i(2)
  #puts "input #{l}/#{r}, depth: #{depth}, no: #{depth_min}~#{depth_max}, queue: #{queue.to_s} => #{sib}"

  no = sib + 2**(depth-1)
  puts "#{i} #{no}"
end
