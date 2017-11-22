def choose(n, r)
  1 if r == 0 or r == n

  # store C(n,r) in a matrix
  c = Array.new(n+1).map{Array.new(r+1,0)}
  i,j = 0

  for i in 0..n
    # C(i,0) = 1 for i = 0...n
    c[i][0] = 1
  end
  for j in 0..r
    # if n = 0, C(n,r) = 0 for all 'r'
    c[0][j] = 0
  end

  for i in 1..n
    for j in 1..r
      if i == j
        # C(n,n) = 1
        c[i][j] = 1
      elsif j > i
        # case when r > n in C(n,r)
        c[i][j] = 0
      else
        # apply the standard recursive formula
        c[i][j] = c[i-1][j-1] + c[i-1][j]
      end
    end
  end

  return c[n][r]
end

n = 40
r = 20
comb = choose(n,r)

puts "C (#{n},#{r}) = #{comb}"
