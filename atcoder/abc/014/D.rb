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

#lines = $stdin.read
array = lines.split("\n")

# Queue
class Array
  alias_method :enqueue, :push
  alias_method :dequeue, :shift
end

Node = Struct.new(:u, :k, :v, :visited)

class Graph

  attr :nodes, :dist

  def initialize(n)
    @nodes = Array.new(n){ Node.new }
    @dist = Array.new(n)
  end

  def add_graph_node(u, v)
    @nodes[u-1].u = u
    (@nodes[u-1].v ||= []).push(v)
    @nodes[u-1].k = @nodes[u-1].v.length
    @nodes[u-1].visited = false
  end

  def reset()
    @nodes.each do |node|
      node.visited = false if not node.visited.nil?
    end
  end

  def bfs(start = 0, queue)

    @nodes[start].visited = true
    #puts "visit = #{@nodes[start].u}, queue = #{queue.to_s}"
    @dist[start] = 0
    #puts "dist: @dist[#{start}] = 0"
    queue.enqueue(@nodes[start])
    #puts "enq = #{@nodes[start].u}, queue = #{queue.to_s}"

    while not queue.empty?

      node = queue.dequeue
      break if node.v.nil?

      #puts "deq = #{node.u}, queue = #{queue.to_s}"
      for i in node.v
        unless @nodes[i-1].visited
          @nodes[i-1].visited  = true
          queue.enqueue(@nodes[i-1])
          #puts "enq = #{@nodes[i-1].u}, queue = #{queue.to_s}"
          if not @nodes[i-1].u.nil?
            @dist[@nodes[i-1].u-1] = @dist[node.u-1] + 1
            #puts "dist: @dist[#{@nodes[i-1].u-1}] = #{@dist[node.u - 1] + 1}"
          end
        end
      end
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
  u = i
  v = seps[1].to_i
  graph.add_graph_node(u, v)
  graph.add_graph_node(v, u)
end

#puts graph.nodes.to_s

for j in N+1...N+Q+1
  src,dst = array[j].split(" ").map(&:to_i)
  puts "#{src} to #{dst}"
  graph.reset()
  graph.bfs(src - 1, [])
  puts graph.dist.to_s
  puts graph.dist[dst-1].to_i + 1
end

#graph.bfs(start = 0, [])
#
#1.upto(N).each do |n|
#  if graph.dist[n-1].nil?
#    puts "#{n} -1"
#  else
#    puts "#{n} #{graph.dist[n-1]}"
#  end
#end
