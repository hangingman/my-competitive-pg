lines = <<'EOS'
5
 -1 2 3 1 -1
 2 -1 -1 4 -1
 3 -1 -1 1 1
 1 4 1 -1 3
 -1 -1 1 3 -1
EOS

Node = Struct.new(:u, :key, :pi)

class Graph
  attr :nodes, :mat
  def initialize(n, matrix)
    @nodes = Array.new(n){ Node.new }
    @mat   = matrix.dup
  end

  def prim(weight, root)
    for node in @nodes
      node.key = Float::INFINITY
      node.pi  = nil
    end
    root.key = 0
  end
end

#lines = $stdin.read
array = lines.split("\n")

N   = array[0].to_i
mat = Array.new(N).map{Array.new(N, 0)}

for i in 1...N
  row  = i - 1
  cols = array[i].split(" ").map(&:to_i)
  cols.each_with_index do |col, idx|
    mat[row][col] = col
  end
end

graph = Graph.new(N, mat)
graph.prim(1, graph.nodes.first)
