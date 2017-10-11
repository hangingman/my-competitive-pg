lines = <<'EOS'
5 7 1
1 4 3 4 2 3 1
EOS

#lines = $stdin.read
array = lines.split("\n")

N,M,D = array[0].split(" ").map(&:to_i)
A     = array[1].split(" ").map(&:to_i)

mat = Array.new(M).map{Array.new(N, 0)}

A.each_with_index do |a, idx|
  mat[idx][a-1] = 1
  idx += 1
end

for i in 0...M
  for j in 0...N
    printf "#{mat[i][j]} "
  end
  puts ""
end

def show_bottom_col(mat, col, row = 0)
  while row < M
    #puts "s:row = #{row}, col = #{col}"
    if mat[row][col] == 1
      col += 1
    else
      row += 1
    end
    #puts "e:row = #{row}, col = #{col}"
  end
  col
end

for col in 0...N
  puts show_bottom_col(mat, col, row = 0) + 1
end
