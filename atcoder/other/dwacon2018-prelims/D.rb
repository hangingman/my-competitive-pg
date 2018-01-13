lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
A = [nil].concat( array[2].split(" ").map(&:to_i) )
X = array[1].split(" ").map(&:to_i)

Node  = Struct.new(:u, :parent, :left, :right, :w)
nodes = Array.new(N) { Node.new }

def post_parse(id, nodes, cost, max)
  return if id.nil?
  children = nodes.select{|n| n.parent == id}.sort_by{|n| n.u}
  children.each do |c|
    cost,max = post_parse(c.u, nodes, cost, max)
  end
  child_cost = if children.empty?
                 0
               else
                 children.map do |n|
                   n.w
                 end.inject(&:+)
               end

  cost += nodes[id].w
  max = cost if cost > max
  #puts "id: #{id+1}, cost: #{cost}, max: #{max}"

  if nodes[id].left.nil? and id != 0
    cost = cost - child_cost
  end

  return [cost, max]
end

A.each_with_index do |parent,idx|
  nodes[idx].u      = idx
  nodes[idx].parent = parent-1 if idx != 0
  nodes[idx].w      = X[idx]
end

# set left/right
for pt in 0...nodes.length
  nodes.select{|n| n.parent == pt}.sort_by{|n| n.u}.inject do |l,r|
    nodes[l.u].right = r.u
    nodes[r.u].left  = l.u
  end
end

# nodes.each{|n| p n}

puts post_parse(0, nodes, 0, 0).last
