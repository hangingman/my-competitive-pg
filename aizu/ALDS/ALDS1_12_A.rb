#_____________|
# | 1 2 3 4 5 |
#-------------|
#1|   2 3 1   |
#2| 2     4   |
#3| 3     1 1 |
#4| 1 4 1   3 |
#5|     1 3   |
#-------------|
# 1 > 4 > 3 > 5 > 2 ?

lines = <<'EOS'
5
 -1 2 3 1 -1
 2 -1 -1 4 -1
 3 -1 -1 1 1
 1 4 1 -1 3
 -1 -1 1 3 -1
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

  def dot()
    puts "graph G {"
    edges = []

    @nodes.each_with_index do |node,i|
      mat[i].map.with_index.select do |w,idx|
        w != -1
      end.each do |w,idx|
        edge = [node.u, idx+1].sort
        edges << edge
      end
    end
    edges = edges.uniq
    edges.each do |e|
      puts "  \"#{e.first}\" -- \"#{e.last}\" [label=#{mat[e.first-1][e.last-1]}]"
    end
    puts "}"
  end

  def prim(start = 1)
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
mat = Array.new(N).map{Array.new(N, 0)}

for i in 1..N
  row  = i - 1
  cols = array[i].split(" ").map(&:to_i)
  cols.each_with_index do |col, idx|
    mat[row][idx] = col
  end
end

graph = Graph.new(N, mat)
graph.prim(1)

sum = 0

graph.nodes.each_with_index do |n,i|
    if graph.nodes[i].p != -1
        sum += mat[i].select{|e| e != -1}.min
    end
end

puts graph.dot
puts sum
