lines = <<'EOS'
16 1
1 2
EOS

#lines = $stdin.read
array = lines.split("\n")
N,M = array[0].split(" ").map(&:to_i)

@g = Array.new(N).map{Array.new(N, 0)}
array[1..M].each do |line|
  x,y = line.split(" ").map(&:to_i)
  @g[x-1][y-1] = 1
end


@dp = Array.new(1<<N, 0)
@dp[0] = 1

for a in 0...(1<<N)
  for v in 0...N
    next if !(a>>v & 1).zero?

    f = true
    for k in 0...N
      if (a>>k & 1).zero? && @g[v][k] == 1
        f = false
      end
    end

    if f
      @dp[a | (1<<v)] += @dp[a]
    end
  end
end


puts @dp[(1<<N) - 1]
