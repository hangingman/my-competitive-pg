# coding: utf-8
lines = <<'EOS'
2
3 1 4 1 5 9
EOS

#
# a の前半 k 要素は黒色または赤色のみで
# a の後半 3N − k 要素は黒色または青色のみである．
#
# N ≤ k ≤ 2N
#
# [3, 1, 4, 1, 5, 9]
#
# [3,    4, 1, 5,  ]
#
# <---k--><--3N-k-->
# 前半k要素の総和が大きくなればスコアは最大になる


#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
a = array[1].split(" ").map(&:to_i)

score = []

for k in N..2*N
  fst = a[0,k].sort.reverse
  #puts "#{fst}"

  sec = a[k,3*N-k].sort
  #puts "#{sec}"

  s = fst[0, N].inject(&:+)
  l = sec[0, N].inject(&:+)

  #puts "#{s} - #{l} = #{s-l}"
  #puts ""

  score << s - l
end

puts score.max
