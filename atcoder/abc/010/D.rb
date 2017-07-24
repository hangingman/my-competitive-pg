
lines = <<'EOS'
6 2 6
4 5
0 1
0 2
1 3
2 3
3 4
3 5
EOS

#lines = $stdin.read
array = lines.split("\n")

N,G,E = array[0].split(" ").map(&:to_i)

Node = Struct.new(:parent, :left, :right)
nodes = Array.new(N) { Node.new }

for i in 2...(array.size)
  left,right = array[i].split(" ").map(&:to_i)
  nodes[right].parent = left
end


parents_id = nodes.map_with_index do |node, id|
  puts "#{node.}"
end

nodes.each_with_index do |node, index|
  puts "node #{index}: parent = #{node.parent.nil? ? -1 : node.parent}"
end
