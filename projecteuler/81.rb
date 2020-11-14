# coding: utf-8
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
    row -= @u_start
    col -= @u_start
    result = if @mat[row][col] != -1 # or @mat[col][row] != -1
               true
             else
               false
             end
    result
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
        if node.c != :black and
          edge_exists?(next_u, v) and
          @nodes[next_u].d + mat[next_u][v] < node.d
          
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

  # 以下debug用
  def gen_uniq_edges()
    edges = []
    @nodes.each_with_index do |node,i|
      mat[i].map.with_index.select do |w,idx|
        w != INF
      end.each do |w,idx|
        edge = [node.u, idx+@u_start].sort
        edges << edge
      end
    end
    edges.uniq
  end
 
  def dot_before_dijkstra()
    puts "digraph beforeDijkstra {"

    @nodes.each_with_index do |_,id|
      puts "  #{id} [shape=box,width=1]"
    end
    gen_uniq_edges.each_with_index do |e, node_id|
      weight = mat[e.first-@u_start][e.last-@u_start]
      puts "  \"#{e.first}\" -> \"#{e.last}\" [label=#{weight}]"
    end
    puts "}"
  end

  def dot_after_dijkstra(start = 1)
    puts "digraph afterDijkstra {"

    @nodes.each_with_index do |node,id|
      puts "  #{id} [label=#{node.d},shape=box,width=1]"
    end
    gen_uniq_edges.each_with_index do |e, node_id|
      weight = mat[e.first-@u_start][e.last-@u_start]
      puts "  \"#{e.first}\" -> \"#{e.last}\" [label=#{weight}]"
    end
    puts "}"
  end
end


# lines = <<'EOS'
# 131,673,234,103,18
# 201,96,342,965,150
# 630,803,746,422,111
# 537,699,497,121,956
# 805,732,524,37,331
# EOS

lines = []
File.open("p081_matrix.txt", "r").each_line{|line| lines << line}
array = lines.dup

N = array[0].split(",").length
mat = Array.new(N**2).map{Array.new(N**2, INF)}

u = 0
array.each_with_index do |row, row_idx|
  row.split(",").each_with_index do |w, col_idx|
    # puts "u=#{u} [#{row_idx},#{col_idx}] = #{w}"
    # puts "  [r] #{u}->#{u+1} = #{w}" if col_idx < N-1
    # puts "  [d] #{u}->#{u+N} = #{w}" if row_idx < N-1

    mat[u][u+1] = w.to_i if col_idx < N-1
    mat[u][u+N] = w.to_i if row_idx < N-1
    u += 1 
  end
end

# 0-indexed
graph = Graph.new(N**2, mat, 0)

#graph.dot_before_dijkstra()
graph.dijkstra(0)
#graph.dot_after_dijkstra(0)
p graph.nodes.last
p graph.nodes.last.d + array.last.split(",").last.to_i
