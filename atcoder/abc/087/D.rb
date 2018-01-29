# Queue
class Array
  alias_method :enqueue, :push
  alias_method :dequeue, :shift
end

# u : Index of nodes starting from 1...N
# k : degree of this node
# v : array of vertices connected with this node
# c : :white(=undiscovered), :gray(=frontier), :black(finished searching)
# d : distance when the vertex is first discovered
# pi: predecessor vertex
Node = Struct.new(:u, :k, :v, :c, :d, :pi)

class Graph

  attr :nodes, true

  def initialize(n)
    @nodes = Array.new(n){ Node.new }
  end

  def add_graph_node(u, v, d = 0)
    @nodes[u-1].u = u
    if not v.nil?
      (@nodes[u-1].v ||= []).push(v)
      @nodes[u-1].k = @nodes[u-1].v.length ||= 0
    else
      @nodes[u-1].v = [] if @nodes[u-1].v.nil?
      @nodes[u-1].k = 0
    end
    @nodes[u-1].c = :white
    @nodes[u-1].d = d
    @nodes[u-1].pi = nil
  end

  def reset()
    @nodes.each do |node|
      node.c  = :white
      node.d  = -1
      node.pi = nil
    end
  end

  def bfs(start, queue)

    start_idx = (start - 1).to_i
    @nodes[start_idx].c  = :gray
    @nodes[start_idx].d  = 0
    @nodes[start_idx].pi = nil
    queue.enqueue(@nodes[start_idx])

    while not queue.empty?

      u = queue.dequeue
      break if u.v.nil?

      u.v.each do |label|
        v = @nodes[label-1]
        if v.c == :white
          v.c  = :gray
          v.d  = u.d.to_i + 1
          v.pi = u
          queue.enqueue(v)
        end
      end
      u.c = :black
    end
  end
end

lines = <<'EOS'
3 3
1 2 1
2 3 1
1 3 2
EOS

#lines = $stdin.read
array = lines.split("\n")
N,M   = array[0].split(" ").map(&:to_i)
graph = Graph.new(N)

for i in 1...M+1
  l,r,d = array[i].split(" ").map(&:to_i)
  graph.add_graph_node(l,r,d)
end



for i in 1...M+1
  l,r,d = array[i].split(" ").map(&:to_i)
  graph.reset
  graph.bfs(l,[])

  bfs_d = (graph.nodes[l-1].d.to_i - graph.nodes[r-1].d.to_i).abs
  puts "#{l} to #{r} ... #{d} and #{bfs_d}"
  # if d != bfs_d
  #   puts "No"
  #   exit 0
  # end
end

puts "Yes"
