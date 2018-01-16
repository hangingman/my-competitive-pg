lines = <<'EOS'
6 6
1 3 4 6 7 5
1 2 4 8 8 7
2 7 9 2 7 2
9 4 2 7 6 5
2 8 4 6 7 6
3 7 9 1 2 7
EOS

lines = $stdin.read
array = lines.split("\n")
H,W   = array[0].split(" ").map(&:to_i)
A     = array[1..H+1].map{|s| s.split(" ").map(&:to_i)}

#require 'matrix'
#dp = Matrix.build(H,W){|row,col| 0}.to_a
dp = Array.new(H).map{Array.new(W){0}}

def rec(dp,i,j,sq,h,w)
  #puts "i=#{i},j=#{j},h=#{h},w=#{w}"
  if dp[i][j] == 0
    ans = 1
    if i > 0 and sq[i][j] < sq[i-1][j]
      ans += rec(dp,i-1,j,sq,h,w) # up
    end
    if i < h-1 and sq[i][j] < sq[i+1][j]
      ans += rec(dp,i+1,j,sq,h,w) # down
    end
    if j > 0 and sq[i][j] < sq[i][j-1]
      ans += rec(dp,i,j-1,sq,h,w) # left
    end
    if j < w-1 and sq[i][j] < sq[i][j+1]
      ans += rec(dp,i,j+1,sq,h,w) # right
    end
    ans
  else
    dp[i][j]
  end
end

for i in 0...H
  for j in 0...W
    dp[i][j] = rec(dp,i,j,A,H,W)
  end
end

puts dp.inject(&:+).inject(&:+)
