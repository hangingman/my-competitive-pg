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

#lines = $stdin.read
array = lines.split("\n")

Node = Struct.new(:u, :k, :v, :visited)

class Graph

  attr :nodes, :d, :f

  def initialize(n)
    @nodes = Array.new(n){ Node.new }
    @d = Array.new(n)
    @f = Array.new(n)
  end

  def set_graph_node(u, k, v)
    @nodes[u-1].u = u
    @nodes[u-1].k = k
    @nodes[u-1].v = v
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

N     = array[0].to_i
graph = Graph.new(N)

for i in 1...array.length
  seps = array[i].split(" ")
  u = seps.drop(0).first.to_i
  k = seps.drop(1).first.to_i
  v = seps.drop(2).map(&:to_i)
  graph.set_graph_node(u, k, v)
end

# puts "Trace all nodes !"
# graph.nodes.each do |node|
#   puts node.to_s
# end

# puts ""
# puts "any? ==> #{graph.nodes.any?{|n| n.visited == false }}"

start, count = 0, 1

while graph.nodes.any?{|n| n.visited == false}
  start = graph.nodes.find_index{|n| n.visited == false }
  count = graph.dfs(start, count)
end

# puts "d #{graph.d.to_s}"
# puts "f #{graph.f.to_s}"

1.upto(N).each do |n|
  puts "#{n} #{graph.d[n-1]} #{graph.f[n-1]}"
end
