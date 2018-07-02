# coding: utf-8
#
# ----------------------
# WarshallFloyd
# ----------------------
# :u ノードのインデックス
# :k u の出次数
# :v u に隣接する頂点の番号
# :w 隣接する頂点への重み
# ----------------------
# Prim
# ----------------------
# :p 前のノード
# :c フラグ
#
INF  = Float::INFINITY
Node = Struct.new(:u, :k, :v, :w, :p, :c)

class Graph
  attr :nodes, :dist
  def initialize(n)
    @nodes = Array.new(n){ Node.new }
    @nodes = @nodes.map.with_index do |node,idx|
      node.u = idx
      node
    end
    @dist = Array.new(n).map{Array.new(n, 0)}
  end

  def add_graph_edge(u, v, w)
    #puts "#{u} -> #{v} (#{w})"
    if @nodes[u].v.nil?
      @nodes[u].v = [v]
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
    # initialize
    for i in 0...@nodes.length
      for j in 0...@nodes.length
        @dist[i][j] = if not @nodes[i].w.nil? and @nodes[i].w.has_key?(j)
                        @nodes[i].w[j]
                      else
                        INF
                      end
      end
      @dist[i][i] = 0
    end

    # calc
    for k in 0...@nodes.length
      for i in 0...@nodes.length
        for j in 0...@nodes.length
          if @dist[i][k] != INF and @dist[k][j] != INF
            @dist[i][j] = [@dist[i][j], @dist[i][k] + @dist[k][j]].min
          end
        end
      end
    end
  end

  def has_negative_cycle?()
    ans = false
    for v in 0...@nodes.length
      ans = true if @dist[v][v] < 0
    end
    ans
  end
end

lines = <<'EOS'
3
0 1 3
1 0 2
3 2 0
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
graph = Graph.new(N)

array[1..N+1].each_with_index do |s,r|
  s.split(" ").map(&:to_i).each_with_index do |v,c|
    graph.add_graph_edge(r,c,v)
  end
end

# execute WarshallFloyd !
graph.warshall_floyd()
