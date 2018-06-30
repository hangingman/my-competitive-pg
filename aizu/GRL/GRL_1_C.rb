# coding: utf-8

lines = <<'EOS'
4 6
0 1 1
0 2 5
1 2 2
1 3 4
2 3 1
3 2 -7
EOS

#lines = $stdin.read
array = lines.split("\n")

#
# :u ノードのインデックス
# :k u の出次数
# :v u に隣接する頂点の番号
# :w 隣接する頂点への重み
# ---
# :visited 深さ優先探索用
# ---
# 閉路の判定のため深さ優先探索も実装してみる
#   深さ優先探索で親ノードへの戻り辺があれば、それは閉路である。トポロジカルソートでも検出できる。
#   Wikipedia - 閉路 より
#
INF  = 999999999
Node = Struct.new(:u, :k, :v, :w, :visited)

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
    # initialize
    for i in 0...@nodes.length
      for j in 0...@nodes.length
        @dist[i][j] = if not @nodes[i].w.nil? and @nodes[i].w.has_key?(j)
                            @nodes[i].w[j]
                          else
                            INF
                      end
        @dist[i][j] = 0 if i==j
      end
    end

    # calc
    for k in 0...@nodes.length
      for i in 0...@nodes.length
        for j in 0...@nodes.length
          if @dist[i][j] > @dist[i][k] + @dist[k][j]
            @dist[i][j] = @dist[i][k] + @dist[k][j]
          end
        end
      end
    end
  end

  def has_cycle?()
  end

  # def dfs(start = 0, count = 1)
  #
  #   # puts "visit = #{@nodes[start].to_s}, count = #{count}"
  #   @nodes[start].visited = true
  #   @d[start] = count
  #   count = count + 1
  #
  #   for i in @nodes[start].v
  #     count = dfs(i-1, count) unless @nodes[i-1].visited
  #   end
  #   # puts "visited = #{@nodes[start].to_s}, count = #{count}"
  #
  #   @f[start] = count
  #   count = count + 1
  #   count
  # end
end

V,E = array[0].split(" ").map(&:to_i)
graph = Graph.new(V)

array[1..E].each do |s|
  s,t,d = s.split(" ").map(&:to_i)
  graph.add_graph_edge(s,t,d)
end

# execute WarshallFloyd !
graph.warshall_floyd()

if graph.dist.map{|d| d.inject(&:+)}.any?{|sum| sum < 0}
  p graph.dist
  #p graph.dist.map{|d| d.reject()   d.inject(&:+)}
  puts "NEGATIVE CYCLE"
else
  graph.dist.each do |d|
    puts d.map{|d| if d == INF; "INF" else d end}.join(" ")
  end
end
