lines = <<'EOS'
5 8
2 2
2 4
########
#.#....#
#.###..#
#......#
########
EOS

#lines = $stdin.read
array = lines.split("\n")

class Array
  alias_method :enqueue, :push
  alias_method :dequeue, :shift
end

Node = Struct.new(:u, :k, :v, :c, :d, :pi)

class Graph

  attr :nodes, true

  def initialize(n)
    @nodes = Array.new(n){ Node.new }
  end

  def add_graph_node(u, v)
    #puts "add_graph_node(#{u}, #{v})"
    @nodes[u-1].u = u
    if not v.nil?
      (@nodes[u-1].v ||= []).push(v)
      @nodes[u-1].k = @nodes[u-1].v.length ||= 0
    else
      @nodes[u-1].v = []
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

R,C = array[0].split(" ").map(&:to_i)
SRC = C * (array[1].split(" ")[0].to_i-1) + array[1].split(" ")[1].to_i
DST = C * (array[2].split(" ")[0].to_i-1) + array[2].split(" ")[1].to_i

graph   = Graph.new(R*C)
u_count = 0

for row in 3...R+3
  for col in 0...C
    u_count += 1
    #puts "u_count=#{u_count}"
    if array[row][col] == '.'
      # left, right
      if col > 1 and array[row][col-1] == '.'
        graph.add_graph_node(u_count, u_count-1)
      end
      if col < C and array[row][col+1] == '.'
        graph.add_graph_node(u_count, u_count+1)
      end
      # up,down
      if row > 1 and array[row-1][col] == '.'
        graph.add_graph_node(u_count, u_count-C)
      end
      if array[row+1][col] == '.'
        #puts "u_count=#{u_count} !!!" if u_count == 35
        graph.add_graph_node(u_count, u_count+C)
      end
    else
      graph.add_graph_node(u_count, nil)
    end
  end
end

#puts graph.nodes.each{|n| puts n.to_s if not n.v.nil? }
#puts "#{SRC} to #{DST}"
graph.bfs(SRC, [])
puts graph.nodes.find{|n| n.u == DST}.d
