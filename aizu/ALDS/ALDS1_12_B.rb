lines = <<'EOS'
5
0 3 2 3 3 1 1 2
1 2 0 2 3 4
2 3 0 3 3 1 4 1
3 4 2 1 0 1 1 4 4 3
4 2 2 1 3 3
EOS

INF  = 999999999
Node = Struct.new(:u, :d, :c, :p)

class Graph
  attr :nodes, :mat
  def initialize(n, matrix)
    @nodes = Array.new(n){ Node.new }
    @nodes.each_with_index{|node,idx| node.u = idx+1}
    @mat   = matrix.dup
  end

  def edge_exists?(row, col)
    #printf "  edge_exists?(#{row}, #{col}) => "
    row -= 1
    col -= 1
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
        edge = [node.u, idx+1].sort
        edges << edge
      end
    end
    edges.uniq
  end

  def dot_before_dijkstra()
    puts "graph beforeDijkstra {"
    gen_uniq_edges.each do |e|
      puts "  \"#{e.first}\" -- \"#{e.last}\" [label=#{mat[e.first-1][e.last-1]}]"
    end
    puts "}"
  end

  def dot_after_dijkstra(start = 1)
    # start dijkstra
    dijkstra(start)

    # then, generate dot
    puts "graph afterDijkstra {"
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
    start = (start-1).to_i
    @nodes[start].d = 0
    @nodes[start].p = -1
    next_u = nil

    while true
      mincost = INF

      @nodes.each do |node|
        if node.c != :black and node.d < mincost
          mincost = node.d
          next_u  = node.u
        end
      end
      #puts "mincost = #{mincost}, next_u = #{next_u}"

      break if mincost == INF

      @nodes[(next_u-1).to_i].c = :black

      @nodes = @nodes.map.with_index(1) do |node, v|
        if node.c != :black and edge_exists?(next_u, v) and mat[next_u-1][v-1] < node.d
          node.d = mat[next_u-1][v-1]
          node.p = next_u
          node.c = :gray
          #puts "  update: node(#{node.u}), d = #{node.d}, parent = #{next_u}"
          node
        else
          node
        end
      end
    end
  end
end

#lines = $stdin.read
array = lines.split("\n")

N   = array[0].to_i
mat = Array.new(N).map{Array.new(N, -1)}

for i in 1..N
  u    = array[i].split(" ").first.to_i
  cols = array[i].split(" ").drop(2)
  cols = cols.each_slice(2).to_a

  cols.each do |col|
    v,w = col.first.to_i-1,col.last.to_i
    mat[u-1][v] = w
    mat[v][u-1] = w
  end
end

graph = Graph.new(N, mat)
graph.dijkstra(1)

sum = 0

graph.nodes.each_with_index do |n,i|
    if graph.nodes[i].p != -1
      sum += mat[i].detect do |e|
        e != -1 and e == n.d
      end
    end
end

puts sum
