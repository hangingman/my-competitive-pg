# coding: utf-8
lines = <<'EOS'
6
1 2 2 4
2 1 5
3 2 5 6
4 0
5 1 4
6 1 6
EOS

# Queue
class Array
  alias_method :enqueue, :push
  alias_method :dequeue, :shift
end

#lines = $stdin.read
array = lines.split("\n")

Node = Struct.new(:u, :k, :v, :visited)

class Graph

  attr :nodes, :dist

  def initialize(n)
    @nodes = Array.new(n){ Node.new }
    @dist = Array.new(n)
  end

  def set_graph_node(u, k, v)
    @nodes[u-1].u = u
    @nodes[u-1].k = k
    @nodes[u-1].v = v
    @nodes[u-1].visited = false
  end

  def bfs(start = 0, queue)

    @nodes[start].visited = true
    # puts "visit = #{@nodes[start].u}, queue = #{queue.to_s}"
    @dist[start] = 0
    # puts "dist: @dist[#{start}] = 0"
    queue.enqueue(@nodes[start])

    while not queue.empty?

      node = queue.dequeue
      #puts "deq = #{node.u}, queue = #{queue.to_s}"

      for i in node.v
        unless @nodes[i-1].visited
          @nodes[i-1].visited  = true
          queue.enqueue(@nodes[i-1])
          #puts "enq = #{@nodes[i-1].u}, queue = #{queue.to_s}"
          @dist[@nodes[i-1].u - 1] = @dist[node.u-1] + 1
          #puts "dist: @dist[#{@nodes[i-1].u-1}] = #{@dist[node.u - 1] + 1}"
        end
      end
    end
  end
end

N     = array[0].to_i
graph = Graph.new(N)

for i in 1...array.length
  seps = array[i].split(" ")
  u = seps.drop(0).first.to_i
  k = seps.drop(1).first.to_i
  v = seps.drop(2).map(&:to_i)
  graph.set_graph_node(u, k, v)
end

# puts graph.nodes.to_s
graph.bfs(start = 0, [])

# puts "distances #{graph.dist.to_s}"

1.upto(N).each do |n|
  if graph.dist[n-1].nil?
    puts "#{n} -1"
  else
    puts "#{n} #{graph.dist[n-1]}"
  end
end
