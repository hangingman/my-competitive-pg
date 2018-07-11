# coding: utf-8
class UnionFind
  attr :id, :rank

  def initialize(n)
    @id   = (0..n).to_a
    @rank = Array.new(n,0)
  end

  def root(i)
    if @id[i] == i or i == @id[@id[i]]
      i
    else
      @id[i] = root(@id[i])
      @id[i]
    end
  end

  # find, check if p and q has the same root
  def same?(p, q)
    root(p) == root(q)
  end

  # union, to merge components containing p and q
  # set id of p's root to the id of q's root
  def unite(p, q)

    i = root(p)
    j = root(q)

    return if i == j

    if @rank[i] < @rank[j]
      @id[i] = j
    else
      @id[j] = i;
      @rank[i]+=1  if @rank[i] == @rank[j]
    end
  end
end


lines = <<'EOS'
5 12
0 1 4
0 2 3
1 1 2
1 3 4
1 1 4
1 3 2
0 1 3
1 2 4
1 3 0
0 0 4
1 0 2
1 3 0
EOS

#lines = $stdin.read
array = lines.split("\n")

n = array[0].split(" ")[0].to_i
q = array[0].split(" ")[1].to_i

un = UnionFind.new(n)

for i in 1..q
  com = array[i].split(" ")[0]
  x   = array[i].split(" ")[1].to_i
  y   = array[i].split(" ")[2].to_i

  if com == '0'
    # unite(4,3) id[4] = 3, 4の頭を3にする
    un.unite(x, y)
  else
    # same
    puts un.same?(x, y) ? "1" : "0"
  end
end
