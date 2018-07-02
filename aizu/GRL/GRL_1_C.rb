# coding: utf-8

lines = <<'EOS'
12 16
0 1 2
0 3 1
1 2 1
1 4 2
2 5 2
3 4 3
3 6 1
4 5 10
4 7 -3
5 4 -7
5 8 2
6 7 1
7 8 6
9 10 1
10 11 1
11 9 1
EOS

#lines = $stdin.read
array = lines.split("\n")

#
# :u ノードのインデックス
# :k u の出次数
# :v u に隣接する頂点の番号
# :w 隣接する頂点への重み
#
INF  = Float::INFINITY
Node = Struct.new(:u, :k, :v, :w)

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
    for v in 0...V
      ans = true if @dist[v][v] < 0
    end
    ans
  end
end

V,E = array[0].split(" ").map(&:to_i)
graph = Graph.new(V)

array[1..E].each do |s|
  s,t,d = s.split(" ").map(&:to_i)
  graph.add_graph_edge(s,t,d)
end

# execute WarshallFloyd !
graph.warshall_floyd()

if graph.has_negative_cycle?
  puts "NEGATIVE CYCLE"
else
  graph.dist.each do |d|
    puts d.map{|d| if d == INF; "INF" else d end}.join(" ")
  end
end
