# coding: utf-8

lines = <<'EOS'
4 6
0 1 1
0 2 5
1 2 2
1 3 4
2 3 1
3 2 7
EOS

array = lines.split("\n")

#
# :u ノードのインデックス
# :k u の出次数
# :v u に隣接する頂点の番号
# :w 隣接する頂点への重み
#
INF  = 999999999
Node = Struct.new(:u, :k, :v, :w)

class Graph
  attr :nodes
  def initialize(n)
    @nodes = Array.new(n){ Node.new }
    @nodes = @nodes.map.with_index do |node,idx|
      node.u = idx
      node
    end
  end

  def add_graph_edge(u, v, w)
    if @nodes[u].v.nil?
      @nodes[u].v = v
      @nodes[u].w = {v=>w}
    elsif @nodes[u].v.is_a?(Array)
      @nodes[u].v << v
      @nodes[u].w = {v=>w}.merge(@nodes[u].w)
    else
      @nodes[u].v = [@nodes[u].v, v]
      @nodes[u].w = {v=>w}.merge(@nodes[u].w)
    end
    @nodes[u].k = if @nodes[u].v.is_a?(Array)
                    @nodes[u].v.length
                  else
                    1
                  end
  end

  def warshall_floyd()

  end
end

V,E = array[0].split(" ").map(&:to_i)
graph = Graph.new(V)

array[1..E].each do |s|
  s,t,d = s.split(" ").map(&:to_i)
  graph.add_graph_edge(s,t,d)
end

p graph.nodes
