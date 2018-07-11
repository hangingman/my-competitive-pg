# coding: utf-8
class QuickUnion
  attr :id

  def initialize(n)
    @id = (0...n).to_a
  end

  def root(i)
    while i != @id[i] do
      i = @id[i]
    end
    i
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
    @id[i] = j
  end
end


lines = <<'EOS'
10 30
1 3 2
1 0 8
0 6 9
1 1 3
1 8 3
0 6 9
0 7 2
0 0 3
1 2 4
1 1 7
0 4 5
0 4 0
0 4 3
1 0 6
0 1 9
1 5 1
0 4 5
1 0 7
0 3 4
0 0 9
0 6 2
0 3 0
1 9 5
1 9 7
1 7 4
0 9 6
0 3 5
1 6 9
0 2 5
1 8 1
EOS

#lines = $stdin.read
array = lines.split("\n")

n = array[0].split(" ")[0].to_i
q = array[0].split(" ")[1].to_i

un = QuickUnion.new(n)

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

# ruby quick-union.rb
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 1
# 1
# 1
# 1
# 0
