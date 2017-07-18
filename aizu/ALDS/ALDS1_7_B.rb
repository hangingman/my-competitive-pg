#lines = <<'EOS'
# 4
# 1 0 -1
# 0 2 -1
# 2 3 -1
# 3 -1 -1
#EOS

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

def get_height(id, nodes)
  #
  # puts "id = #{id}, left = #{nodes[id].left}, right = #{nodes[id].right}"
  #
  return -1 if nodes[id].nil? or id == -1

  left_id  = nodes[id].left.nil? ? -1 : nodes[id].left
  right_id = nodes[id].right.nil? ? -1 : nodes[id].right

  lefth  = get_height(left_id, nodes)
  righth = get_height(right_id, nodes)

  height = if lefth > righth
             lefth + 1
           else
             righth + 1
           end
  height
end

def get_sibling(id, nodes)
  if nodes[id].parent.nil?
    -1
  else
    pid = nodes[id].parent
    p = nodes[pid]

    #puts "p.right => #{p.right.class}, p.left #{p.left.class}"

    if p.left.nil? and p.right.nil?
      -1
    else
      if p.right == id
        return p.left.nil? ? -1 : p.left
      end
      if p.left  == id
        return p.right.nil? ? -1 : p.right
      end
    end
  end
end

for i in 1...(array.size)
  carray = array[i].split(" ")
  id    = carray[0].to_i
  left  = carray[1].to_i
  right = carray[2].to_i

  # puts "id #{id}, left #{left}, right #{right}"

  # set parents for each children
  nodes[left].parent  = id if left  != -1
  nodes[right].parent = id if right != -1

  # set left/right nodes
  nodes[id].left  = left if left != -1
  nodes[id].right = right if right != -1
end

for index in 0...nodes.size

  node = nodes[index]
  parent  = node.parent.nil? ? -1 : node.parent
  depth   = get_depth(index, nodes)
  sibling = get_sibling(index, nodes)

  degree = 0
  degree += node.right.nil? ? 0 : 1
  degree += node.left.nil?  ? 0 : 1

  height  = get_height(index, nodes)

  type = if node.parent.nil?
           "root"
         elsif degree == 0
           "leaf"
         else
           "internal node"
         end

  puts "node #{index}: parent = #{parent}, sibling = #{sibling}, degree = #{degree}, depth = #{depth}, height = #{height}, #{type}"
end

# node 0: parent = -1, sibling = -1, degree = 2, depth = 0, height = 3, root
# node 1: parent = 0, sibling = 4, degree = 2, depth = 1, height = 1, internal node
# node 2: parent = 1, sibling = 3, degree = 0, depth = 2, height = 0, leaf
# node 3: parent = 1, sibling = 2, degree = 0, depth = 2, height = 0, leaf
# node 4: parent = 0, sibling = 1, degree = 2, depth = 1, height = 2, internal node
# node 5: parent = 4, sibling = 8, degree = 2, depth = 2, height = 1, internal node
# node 6: parent = 5, sibling = 7, degree = 0, depth = 3, height = 0, leaf
# node 7: parent = 5, sibling = 6, degree = 0, depth = 3, height = 0, leaf
# node 8: parent = 4, sibling = 5, degree = 0, depth = 2, height = 0, leaf
