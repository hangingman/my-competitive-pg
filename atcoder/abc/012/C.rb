lines = <<'EOS'
2024
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

mat  = Array.new(9).map{ Array.new(9, 0) }
summ = 0

for i in 1..9
  for j in 1..9
    mat[i-1][j-1] = i*j
  end
  summ += mat[i-1].inject(:+)
end

ans = summ - N

for i in 1..9
  for j in 1..9
    #mat[i-1][j-1] = i*j
    puts "#{i} x #{j}" if i*j == ans
  end
end
