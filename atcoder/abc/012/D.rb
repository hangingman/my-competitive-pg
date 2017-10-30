INF  = 999999999
Node = Struct.new(:u, :d, :c, :p)

class Graph
  attr :nodes, :mat, :u_start
  def initialize(n, matrix, u_start_with = 1)
    @nodes = Array.new(n){ Node.new }
    @nodes.each_with_index{|node,idx| node.u = idx+u_start_with}
    @u_start = u_start_with
    @mat   = matrix.dup
  end

  def edge_exists?(row, col)
    #printf "  edge_exists?(#{row}, #{col}) => "
    row -= @u_start
    col -= @u_start
    result = if @mat[row][col] != -1 # or @mat[col][row] != -1
               true
             else
               false
             end
    #puts "#{result} => cost: #{@mat[row][col]}"
    result
  end

  def gen_uniq_edges()
    edges = []
    @nodes.each_with_index do |node,i|
      mat[i].map.with_index.select do |w,idx|
        w != -1
      end.each do |w,idx|
        edge = [node.u, idx+@u_start]
        edges << edge
      end
    end
    edges.uniq
  end

  def dot_before_dijkstra()
    puts "digraph beforeDijkstra {"
    gen_uniq_edges.each do |e|
      puts "  \"#{e.first}\" -> \"#{e.last}\" [label=#{mat[e.first-@u_start][e.last-@u_start]}]"
    end
    puts "}"
  end

  def dot_after_dijkstra(start = 1)
    # start dijkstra
    dijkstra(start)

    # then, generate dot
    puts "digraph afterDijkstra {"
    gen_uniq_edges.each do |e|
      no = mat[e.first-1.to_i].detect {|m| m != -1 and (m == e.last-1 or m == e.first-1) }
      if no.nil?
        puts "  \"#{e.first}\" -- \"#{e.last}\" [label=\"w=#{mat[e.first-1][e.last-1]}\"]"
      else
        puts "  \"#{e.first}\" -- \"#{e.last}\" [label=\"w=#{mat[e.first-1][e.last-1]} (#{no})\", penwidth=3]"
      end
    end
    puts "}"
  end

  def dijkstra(start = 1)
    @nodes = @nodes.each do |node|
      node.d = INF
      node.p = nil
      node.c = :white
    end

    start = (start-@u_start).to_i
    @nodes[start].d = 0
    @nodes[start].p = -1
    next_u = nil

    while true
      mincost = INF
      @nodes.each do |node|
        if node.c != :black and node.d < mincost
          #puts "node.d = #{node.d}"
          mincost = node.d
          next_u  = node.u
        end
      end
      #puts "mincost = #{mincost}, next_u = #{next_u}"

      break if mincost == INF

      @nodes[next_u].c = :black

      @nodes = @nodes.map.with_index do |node, v|
        if node.c != :black and edge_exists?(next_u, v) and @nodes[next_u].d + mat[next_u][v] < node.d
          node.d = @nodes[next_u].d + mat[next_u][v]
          node.p = next_u
          node.c = :gray
          node
        else
          node
        end
      end
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

N,M = array[0].split(" ").map(&:to_i)
mat = Array.new(N).map{Array.new(N, -1)}

for i in 1..M
  u,v,w = array[i].split(" ").map(&:to_i)
  mat[u-1][v-1] = w
  #mat[v-1][u-1] = w
end

# 0-indexed
graph = Graph.new(N, mat, 0)

# start-with 0
# graph.dot_before_dijkstra()
# graph.nodes.each do |n|
#   graph.dijkstra(n.u)
#   puts "from #{n.u}"
#   graph.nodes.each{|node| puts "  #{node.u} #{node.d}"}
# end

graph.dijkstra(0)
max_d = graph.nodes.max_by {|n| n.d }.d
max_t = graph.nodes.min_by {|n| (n.d - max_d / 2).abs }.d
puts max_t
