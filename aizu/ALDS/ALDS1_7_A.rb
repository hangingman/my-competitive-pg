# lines = <<'EOS'
# 4
# 0 0
# 1 3 2 3 0
# 2 0
# 3 0
# EOS

lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
Node = Struct.new(:parent, :left, :right)

nodes = Array.new(N) { Node.new }

def get_depth(id, nodes)
  d = 0
  while ! nodes[id].parent.nil? do
    id = nodes[id].parent
    d += 1
  end
  d
end

def get_children(id, nodes)
  children = []
  c = nodes[id].left
  while not c.nil?
    children << c
    c = nodes[c].right
  end
  children
end

for i in 1...(array.size)

  carray = array[i].split(" ")
  id = carray[0].to_i
  k  = carray[1].to_i
  c  = carray.slice(2, carray.length+1).map(&:to_i)

  # set parents for each children
  c.each do |child|
    nodes[child].parent = id
  end

  # set left node for this node
  nodes[id].left = c.first

  # set left/right nodes
  c.inject do |l, r|
    nodes[l].right = r
  end
end

nodes.each_with_index do |node, index|

  children = get_children(index, nodes)

  type = if node.parent.nil?
           "root"
         elsif children.empty?
           "leaf"
         else
           "internal node"
         end

  puts "node #{index}: parent = #{node.parent.nil? ? -1 : node.parent}, depth = #{get_depth(index, nodes)}, #{type}, #{children.to_s}"
end
