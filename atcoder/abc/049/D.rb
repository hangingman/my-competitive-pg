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
7 4 4
1 2
2 3
2 5
6 7
3 5
4 5
3 4
6 7
EOS
#lines = $stdin.read

array = lines.split("\n")
N,K,L = array[0].split(" ").map(&:to_i)

ufpq = UnionFind.new(N+1)
ufrs = UnionFind.new(N+1)

array[1..K].each do |str|
  pi,qi = str.split(" ").map(&:to_i)
  ufpq.unite(pi,qi)
end

array[K+1..K+L+1].each do |str|
  ri,si = str.split(" ").map(&:to_i)
  ufrs.unite(ri,si)
end

ans = (1..N).map do |n|
  rpq = ufpq.root(n)
  rrs = ufrs.root(n)
  idx_pq = ufpq.id.each_with_index.select{|e, i| e == rpq}.map{|e| e[1]}
  idx_rs = ufrs.id.each_with_index.select{|e, i| e == rrs}.map{|e| e[1]}
  (idx_pq & idx_rs).length
end

puts ans.join(" ")
