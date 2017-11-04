lines = <<'EOS'
3
1 1 1
2 2 2
3 3 3
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
A = array[1].split(" ").map(&:to_i).sort
B = array[2].split(" ").map(&:to_i).sort
C = array[3].split(" ").map(&:to_i).sort

arr_b_gt_a = B.map do |b|
  (0...N).bsearch{|a| a < b }
end

arr_c_gt_b = B.map do |b|
  C.count{|c| b < c }
end

puts A.to_s
puts B.to_s
puts "---"
puts arr_b_gt_a.to_s
# puts "---"
# puts B.to_s
# puts C.to_s
# puts "---"
# puts arr_c_gt_b.to_s
# puts "---"

ans = (0...N).map do |idx|
  arr_b_gt_a[idx] * arr_c_gt_b[idx]
end.inject(:+)

puts ans
