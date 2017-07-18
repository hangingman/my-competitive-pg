#lines = <<'EOS'
#9
#0 1 4
#1 2 3
#2 -1 -1
#3 -1 -1
#4 5 8
#5 6 7
#6 -1 -1
#7 -1 -1
#8 -1 -1
#EOS

lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
Node = Struct.new(:parent, :left, :right)

nodes = Array.new(N) { Node.new }

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

def pre_parse(id, nodes)
  return if id.nil?
  print " #{id}"
  pre_parse(nodes[id].left, nodes)
  pre_parse(nodes[id].right, nodes)
end

def in_parse(id, nodes)
  return if id.nil?
  in_parse(nodes[id].left, nodes)
  print " #{id}"
  in_parse(nodes[id].right, nodes)
end

def post_parse(id, nodes)
  return if id.nil?
  post_parse(nodes[id].left, nodes)
  post_parse(nodes[id].right, nodes)
  print " #{id}"
end

root = 0
for i in 0...nodes.size
  root = i if nodes[i].parent.nil?
end

puts "Preorder"
pre_parse(root, nodes)
puts ""

puts "Inorder"
in_parse(root, nodes)
puts ""

puts "Postorder"
post_parse(root, nodes)
puts ""
