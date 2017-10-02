#
# http://www.csegeek.com/csegeek/view/tutorials/algorithms/dynamic_prog/dp_part6.php
#
#
# example1   = [9 5 2 8 7 3 1 6 4 5]
# lis should = 4
#
# example2   = [0 8 4 12 2 10 6 14 1 9 5 13 3 11 7 15]
# lis should = 6
#

lines = <<'EOS'
0 8 4 12 2 10 6 14 1 9 5 13 3 11 7 15
EOS

#lines = $stdin.read
array = lines.split("\n")

def get_lis(arr)
  lis_arr = Array.new(arr.length){1}
  length = 1

  puts arr.to_s
  puts lis_arr.to_s

  for i in 1...arr.length
    for j in 0...i
      lis_arr[i] = lis_arr[j] + 1 if arr[j] < arr[i] and lis_arr[i] < (lis_arr[j]+1)
    end
  end

  puts lis_arr.to_s
  lis_arr.max
end

puts get_lis(array[0].split(" ").map(&:to_i).to_a)
