Node = Struct.new(:u, :k, :v, :visited)

class Graph

  attr :nodes, :d, :f

  def initialize(n)
    @nodes = Array.new(n){ Node.new }
    @d = Array.new(n)
    @f = Array.new(n)
  end

  def add_graph_node(u, k, v)
    @nodes[u-1].u = u
    if not v.nil?
      (@nodes[u-1].v ||= []).push(v)
      @nodes[u-1].k = @nodes[u-1].v.length ||= 0
    else
      @nodes[u-1].v = [] if @nodes[u-1].v.nil?
      @nodes[u-1].k = 0
    end
    @nodes[u-1].visited = false
  end

  def dfs(start = 0, count = 1)

    # puts "visit = #{@nodes[start].to_s}, count = #{count}"
    @nodes[start].visited = true
    @d[start] = count
    count = count + 1

    for i in @nodes[start].v
      count = dfs(i-1, count) unless @nodes[i-1].visited
    end
    # puts "visited = #{@nodes[start].to_s}, count = #{count}"

    @f[start] = count
    count = count + 1
    count
  end
end

# start
lines = <<'EOS'
7
1 7
8
1 2
1 3
4 2
4 3
4 5
4 6
7 5
7 6
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
A,B = array[1].split(" ").map(&:to_i)
M = array[2].to_i
graph = Graph.new(N)

for i in (3...M+3)
  u,v = array[i].split(" ").map(&:to_i)
  k = 1
  graph.add_graph_node(u, k, v)
end

# puts "Trace all nodes !"
# graph.nodes.each do |node|
#   puts node.to_s
# end

# puts ""
# puts "any? ==> #{graph.nodes.any?{|n| n.visited == false }}"

# start, count = 0, 1

# while graph.nodes.any?{|n| n.visited == false}
#   start = graph.nodes.find_index{|n| n.visited == false }
#   count = graph.dfs(start, count)
# end

graph.dfs(A)

1.upto(N).each do |n|
  puts "#{n} #{graph.d[n-1]} #{graph.f[n-1]}"
end
