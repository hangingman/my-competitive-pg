lines = <<'EOS'
5
1 2
1 3
1 4
4 5
3
2 3
2 5
2 4
EOS

#lines = <<'EOS'
7
3 1
2 1
2 4
2 5
3 6
3 7
5
4 5
1 6
5 6
4 7
5 3
EOS

#lines = $stdin.read
array = lines.split("\n")

# Queue
class Array
  alias_method :enqueue, :push
  alias_method :dequeue, :shift
end

#
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

  def add_graph_node(u, v)
    @nodes[u-1].u = u
    (@nodes[u-1].v ||= []).push(v)
    @nodes[u-1].k = @nodes[u-1].v.length
    @nodes[u-1].c = :white
    @nodes[u-1].d = -1
    @nodes[u-1].pi = nil
  end

  def reset()
    @nodes.each do |node|
      node.c  = :white
      node.d  = -1
      node.pi = nil
    end
  end

  def dist()
    puts "d : #{@nodes.map{|node| node.d}.to_a.to_s}"
    puts "pi: #{@nodes.map{|node| node.pi}.to_a.to_s}"
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

# start
#lines = $stdin.read
array = lines.split("\n")

N     = array[0].to_i
Q     = array[N].to_i
graph = Graph.new(N)

for i in 1...N
  seps = array[i].split(" ")
  u,v  = seps.map(&:to_i) # .map{|n| n-1}
  #puts "add_graph_node(#{u} <--> #{v})"
  graph.add_graph_node(u, v)
  graph.add_graph_node(v, u)
end

# graph.nodes.each do |node|
#     puts node.to_s
# end

for j in N+1...N+Q+1
  src,dst = array[j].split(" ").map(&:to_i)
  # puts "#{src} to #{dst}"
  graph.reset()
  graph.bfs(src, [])
  #puts graph.dist
  puts graph.nodes[dst.to_i-1].d.to_i + 1
end
