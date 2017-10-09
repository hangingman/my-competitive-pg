lines = <<'EOS'
6 5
1 2
2 3
3 4
4 5
5 6
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

  def add_graph_node(u, v)
    @nodes[u-1].u = u

    @nodes[u-1].k = if @nodes[u-1].k.nil?
                      1
                    else
                      @nodes[u-1].k + 1
                    end

    if @nodes[u-1].v.nil?
      @nodes[u-1].v = []
    end
    @nodes[u-1].v << v

    @nodes[u-1].visited = false
  end

  def dfs(start = 0, count = 0)

    puts "visit = #{@nodes[start].to_s}, count = #{count}"

    #@nodes[start].visited = true
    #@d[start] = count
    count = count + 1

    if count == 3
      puts "visited = #{@nodes[start].to_s}, count = #{count}"
      [count, @nodes[start].u]

    elsif @nodes[start].v.nil?
      puts "visited = #{@nodes[start].to_s}, count = #{count}"
      [count, -1]

    else
      for i in @nodes[start].v
        count = dfs(i-1, count) unless @nodes[i-1].visited
      end
      puts "visited = #{@nodes[start].to_s}, count = #{count}"
      [count, @nodes[start].u]
    end
  end
end

N,M   = array[0].split(" ").map(&:to_i)
graph = Graph.new(N)

for i in 1...array.length
  seps = array[i].split(" ")
  u = seps.drop(0).first.to_i
  v = seps.drop(1).first.to_i
  # puts "#{u}, #{v}"
  graph.add_graph_node(u, v)
end

puts ""
puts "add nodes for answer!"
puts ""

ans = 0
graph.nodes.each_with_index do |node, idx|
  if node.u.nil? or node.k.nil? or node.v.nil?
    puts "skip node: ##{idx+1}"
    #graph.dfs(node.u - 1)
  else
    puts "check node: ##{node.u}"
    t = graph.dfs(node.u - 1).flatten
    if t.first == 3 and not t[1].nil? and not t.last.nil?
      start = t.last
      endno = t[1]

      if not graph.nodes.any?{|node| node.u == start and node.v.include? endno }
        ans += 1
        puts "add graph_node(#{start}, #{endno})"
        graph.add_graph_node(start, endno)
      end
    end
  end
end

puts ""
puts "calc answer!"
puts ""

count = 0
graph.nodes.each_with_index do |node, idx|
  if node.u.nil? or node.k.nil? or node.v.nil?
    puts "skip node: ##{idx+1}"
    #graph.dfs(node.u - 1)
  else
    puts "check node: ##{node.u}"
    t = graph.dfs(node.u - 1).flatten
    if t.first == 3 and not t[1].nil? and not t.last.nil?
      start = t.last
      endno = t[1]
      # ans += 1 if not graph.nodes.any?{|node| node.u == start and node.v.include? endno }
      if not graph.nodes.any?{|node| node.u == start and node.v.include? endno }
        ans =+ 1
      end
    end
  end
end

puts ans
