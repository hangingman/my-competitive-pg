Node = Struct.new(:u, :v)

class Graph
  attr_accessor :nodes
  attr_accessor :visited

  def initialize(n)
    @nodes = Array.new(n).map.with_index do |_,i|
      Node.new(i, [])
    end
    @visited = Array.new(n, 0)
  end

  def append_graph_node(u, v)
    @nodes[u].v.push(v) #unless @nodes[u].v.include?(v)
  end

  def bfs(start_idx)
    k = 0 # depthの最大値
    queue = []
    @visited[start_idx] = 1
    queue.push(@nodes[start_idx])

    colors = Array.new(@nodes.size, 0)
    ans = {}

    while !queue.empty?
      v = queue.shift
      k = [k, v.v.size].max
      cur = 1

      v.v.each do |u|
        if @visited[u] == 0
          cur +=1 if cur==colors[v.u]

          colors[u] = cur
          ans[[u,v.u]] = cur
          ans[[v.u,u]] = cur
          cur+=1

          @visited[u] = 1
          queue.push(@nodes[u])
        end
      end
    end

    puts k
    ans
  end
end

lines = <<'EOS'
8
1 2
2 3
2 4
2 5
4 7
5 6
6 8
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
graph = Graph.new(N)
v_pair = []

array[1..N].each do |s|
  a,b = s.split(" ").map(&:to_i)

  graph.append_graph_node(a-1, b-1)
  graph.append_graph_node(b-1, a-1)
  v_pair << [a-1,b-1]
end

ans = graph.bfs(0)

v_pair.each do |pair|
  puts ans[pair]
end
