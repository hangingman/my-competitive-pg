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

  def prim(start=0, node_needed=[])
    mincost = INF

    @nodes.each do |node|
      node.w.each do |node_from, node_to|
        if node.c != :black and node_to < mincost
          mincost = node_to
          next_u = node.u
        end
      end
    end

    break if mincost == INF

    @nodes[(next_u).to_i].c = :black

    @nodes = @nodes.map.with_index do |node, v|
      if node.c != :black and @dist[next_u][v] != INF and mat[next_u-1][v-1] < node.d
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

lines = <<'EOS'
4 6 3
2 3 4
1 2 4
2 3 3
4 3 1
1 4 1
4 2 2
3 1 6
EOS

#lines = $stdin.read
array = lines.split("\n")

N,M,R = array[0].split(" ").map(&:to_i)
graph = Graph.new(N)
rarr  = array[1].split(" ").map(&:to_i).map{|idx| idx-1}

array[2..M+1].each do |s|
  s,t,d = s.split(" ").map(&:to_i)
  s,t=s-1,t-1
  graph.add_graph_edge(s,t,d)
  graph.add_graph_edge(t,s,d)
end

# execute WarshallFloyd !
graph.warshall_floyd()

dists = rarr.permutation(R).map do |picked|
  picked.each_cons(2).map do |arr|
    graph.dist[arr.first][arr.last]
  end.inject(&:+)
end

#p dists
p dists.min
