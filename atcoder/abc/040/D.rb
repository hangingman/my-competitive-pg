def root(i, id)
  while i != id[i] do
    i = id[i]
  end
  i
end

# find, check if p and q has the same root
def same?(p, q, id)
  root(p, id) == root(q, id)
end

# union, to merge components containing p and q
# set id of p's root to the id of q's root
def unite(p, q, id)
  i = root(p, id)
  j = root(q, id)
  id[i] = j
end

# lines = <<'EOS'
# 4 5
# 1 2 2005
# 3 1 2001
# 3 4 2002
# 1 4 2004
# 4 2 2003
# 5
# 1 2003
# 2 2003
# 1 2001
# 3 2003
# 4 2004
# EOS

lines = $stdin.read
array = lines.split("\n")
N,M   = array[0].split(" ").map(&:to_i)
a = []
b = []
y = []

Q = array[M+1].to_i
v = []
w = []

array[M+2..M+1+Q].each do |s|
  v << s.split(" ")[0].to_i
  w << s.split(" ")[1].to_i
end

verts = array[1..M].map do |s|
  a = s.split(" ")[0].to_i
  b = s.split(" ")[1].to_i
  y = s.split(" ")[2].to_i
  [[a,b].sort, y]
end.to_h

#puts verts.to_s

# prepare array to store
0.upto(Q-1) do |idx|
  #puts "from #{v[idx]}..."
  id = (0...N).to_a
  sn = id.dup

  max_y = w[idx]

  verts.each do |k,year|
    #puts k.to_s if max_y < year
    unite(k.first-1, k.last-1, id) if max_y < year
  end

  puts sn.count{|s| same?(s, v[idx]-1, id)}
end
