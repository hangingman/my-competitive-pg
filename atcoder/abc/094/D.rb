# coding: utf-8


lines = <<'EOS'
2
100 0
EOS

#lines = $stdin.read
array = lines.split("\n")

# https://detail.chiebukuro.yahoo.co.jp/qa/question_detail/q1155016236
# nが偶数のときはr=n/2
# nが奇数のときはr=(n-1)/2,(n+1)/2
# で最大値をとることになります．

N = array[0].to_i
A = array[1].split(" ").map(&:to_i).sort.reverse

n = A.max
A.delete(n)

max_r_idx = A.map.with_index{|e,idx| [(n/2-e).abs,idx]}.min_by{|arr| arr.first}.last
max_r     = A[max_r_idx]

puts "#{n} #{max_r}"
