class Array
  alias_method :enqueue, :push
  alias_method :dequeue, :shift
end

Node = Struct.new(:u, :k, :v, :c, :d, :w, :pi)

class Graph

  attr :nodes

  def initialize(n)
    @nodes = Array.new(n){ Node.new }
  end

  def add_graph_node(u, v, w)
    puts "add_graph_node(#{u}, #{v}, #{w})"
    @nodes[u-1].u = u
    if not v.nil?
      (@nodes[u-1].v ||= []).push(v)
      @nodes[u-1].k = @nodes[u-1].v.length ||= 0
    else
      @nodes[u-1].v = [] if @nodes[u-1].v.nil?
      @nodes[u-1].k = 0
    end
    @nodes[u-1].c = :white
    @nodes[u-1].d = -1
    @nodes[u-1].w = w
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
          v.d  = u.d.to_i + u.w
          v.pi = u
          queue.enqueue(v)
        end
      end
      u.c = :black
    end
  end
end

lines = <<'EOS'
5 5
1 2 12
2 3 14
3 4 7
4 5 9
5 1 18
EOS

#lines = $stdin.read
array = lines.split("\n")

N,M   = array[0].split(" ").map(&:to_i)
graph = Graph.new(N)

array[1..M].each do |str|
  a,b,t = str.split(" ").map(&:to_i)
  graph.add_graph_node(a, b, t)
  graph.add_graph_node(b, a, t)
end

graph.nodes.each{|n| puts n.to_s}

puts ""

graph.bfs(1, [])

graph.nodes.each{|n| puts n.to_s}

puts graph.nodes.find{|n| n.u == N}.d
