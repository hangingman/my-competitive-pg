
INF  = Float::INFINITY
Edge = Struct.new(:from, :to, :cost)

class Graph
  attr :edges, :V, :E, :d
  def initialize(v,e)
    @V = v
    @E = e
    @edges = []
    @d = []
  end

  def add_graph_edge(u, v, w)
    @edges << Edge.new(u,v,w)
  end

  def bellman_ford(source=0)
    @d = Array.new(@V,INF)
    @d[source] = 0

    for count in 0...@V
      for i in 0...@edges.length
        v = edges[i].to
        u = edges[i].from
        c = edges[i].cost
        #puts "from[#{u}] to[#{v}] cost=#{c},count=#{count}"
        if @d[u] + c < @d[v]
          @d[v] = @d[u] + c
          #p count
          #p v
          return false if (count == @V-1)
        end
      end
    end
    true
  end
end

lines = <<'EOS'
10 12 8
0 1 7
1 2 -3
2 3 3
3 0 -7
4 2 1
4 5 1
5 6 2
6 7 3
7 4 4
6 8 1
8 9 1
9 8 -7
EOS

#lines = $stdin.read
array = lines.split("\n")

V,E,R = array[0].split(" ").map(&:to_i)
graph = Graph.new(V,E)

array[1..E].each do |s|
  s,t,d = s.split(" ").map(&:to_i)
  graph.add_graph_edge(s,t,d)
end

if graph.bellman_ford(R)
  graph.d.each do |d|
    if d == INF
      puts "INF"
    else
      puts d
    end
  end
else
  puts "NEGATIVE CYCLE"
end
