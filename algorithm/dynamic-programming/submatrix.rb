#
# Ruby code for Maximum size square sub-matrix with all 1s
#
def print_max_sub_square(m)
  row,col = m.size, m.first.size
  s = Array.new(row){Array.new(col,0)}

  # Set first column of S[][]
  for i in 0...row
    s[i][0] = m[i][0]
  end
  # Set first row of S[][]
  for j in 0...col
    s[0][j] = m[0][j]
  end

  # Construct other entries of S[][]
  for i in 1...row
    for j in 1...col
      if m[i][j] == 1
        s[i][j] = [ s[i][j-1], s[i-1][j], s[i-1][j-1] ].min + 1
      else
        s[i][j] = 0
      end
    end
  end
  # Find the maximum entry, and indexes of maximum entry in S[][]
  max_of_s,max_i,max_j = s[0][0],0,0

  for i in 0...row
    for j in 0...col
      if max_of_s < s[i][j]
        max_of_s,max_i,max_j = s[i][j],i,j
      end
    end
  end

  printf "Maximum size sub-matrix is: \n"
  max_i.downto(max_i - max_of_s + 1) do |i|
    max_j.downto(max_j - max_of_s + 1) do |j|
      printf "%d", m[i][j]
    end
    puts ""
  end
end

# Driver function to test above functions
M = [
  [0, 1, 1, 0, 1],
  [1, 1, 0, 1, 0],
  [0, 1, 1, 1, 0],
  [1, 1, 1, 1, 0],
  [1, 1, 1, 1, 1],
  [0, 0, 0, 0, 0]
]

print_max_sub_square(M)
