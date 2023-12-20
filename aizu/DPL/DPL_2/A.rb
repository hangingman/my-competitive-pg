lines = <<'EOS'
3 3
0 1 1
1 2 1
0 2 1
EOS

#lines = $stdin.read
array = lines.split("\n")

class Integer
  def to_b?
    !self.zero?
  end
end

INF = 10**6
V,E = array[0].split(" ").map(&:to_i)
@d = Array.new(V).map{ Array.new(V, INF) }

array[1..E].map do |line|
  s, t, dist = line.split(" ").map(&:to_i)
  @d[s][t] = dist
end

# メモ化テーブル
@dp = Array.new(1 << V).map{ Array.new(V, -1) }

def rec(s, v)
  if @dp[s][v] >= 0
    return @dp[s][v]
  end

  if s == (1 << V) - 1 && v == 0
    return @dp[s][v] = 0
  end

  res = INF
  for u in 0...V
    if not (s >> u & 1).to_b?
      res = [res, rec(s | 1 << u, u) + @d[v][u] ].min
    end

  end
  return @dp[s][v] = res
end

tmp = rec(0, 0)
ans = (tmp == INF) ? -1 : tmp
puts ans
