lines = $stdin.read
 
array = lines.split("\n")
 
n = array[0].split(" ")[0].to_i
q = array[0].split(" ")[1].to_i
 
it = -1
id = Array.new(n){it+=1}
sn = Array.new(id)
 
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
 
for i in 1..q
  com = array[i].split(" ")[0]
  x   = array[i].split(" ")[1].to_i
  y   = array[i].split(" ")[2].to_i
 
  if com == '0'
    # unite(4,3) id[4] = 3, 4?????????3?????????
    unite(x, y, id)
  else
    # same
    puts same?(x, y, id) ? "1" : "0"
  end
end
