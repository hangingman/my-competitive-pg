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

  attr :nodes

  def initialize(n)
    @nodes = Array.new(n){ Node.new }
  end

  def add_graph_node(u, v)
    #puts "add_graph_node(#{u}, #{v})" if not u.nil? and not v.nil?
    @nodes[u-1].u = u
    if not v.nil?
      (@nodes[u-1].v ||= []).push(v)
      @nodes[u-1].v = @nodes[u-1].v.uniq
      @nodes[u-1].k = @nodes[u-1].v.length ||= 0
    else
      @nodes[u-1].v = [] if @nodes[u-1].v.nil?
      @nodes[u-1].k = 0
    end
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

# lines = <<'EOS'
# 5 4
# 1 2 2000
# 2 3 2004
# 3 4 1999
# 4 5 2001
# 3
# 1 2000
# 1 1999
# 3 1995
# EOS

lines = $stdin.read
array = lines.split("\n")
N,M   = array[0].split(" ").map(&:to_i)
a = []
b = []
y = []

array[1..M].each do |s|
  a << s.split(" ")[0].to_i
  b << s.split(" ")[1].to_i
  y << s.split(" ")[2].to_i
end

Q = array[M+1].to_i
v = []
w = []

array[M+2..M+1+Q].each do |s|
  v << s.split(" ")[0].to_i
  w << s.split(" ")[1].to_i
end


v.each_with_index do |vertex, idx|
  # number of nodes => N
  graph = Graph.new(N)
  (1..N).each {|n| graph.add_graph_node(n, nil)}
  # max year for the man
  max_y = w[idx]

  y.each_with_index do |year, y_idx|
    #puts "max_y = #{max_y}: compare with #{year}"
    graph.add_graph_node(a[y_idx], b[y_idx]) if max_y < year
    graph.add_graph_node(b[y_idx], a[y_idx]) if max_y < year
  end
  #graph.nodes.each{|n| puts n.to_s}

  #puts "from #{vertex} ==> "
  graph.bfs(vertex, [])
  puts graph.nodes.count{|n| n.c == :black}
  #graph.nodes.each_with_index do |elem, idx|
  #  puts "#{idx+1} #{graph.nodes[idx].c}"
  #end
  #puts "---"
end
