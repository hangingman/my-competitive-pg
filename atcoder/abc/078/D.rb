def get_lis(arr)
  lis_arr = Array.new(arr.length){1}
  length = 1

  # puts arr.to_s
  # puts lis_arr.to_s
  for i in 1...arr.length
    for j in 0...i
      lis_arr[i] = lis_arr[j] + 1 if arr[j] < arr[i] and lis_arr[i] < (lis_arr[j]+1)
    end
  end

  puts lis_arr.to_s
  lis_arr
end

lines = <<'EOS'
3 100 100
10 1000 100
EOS

#lines = $stdin.read
array = lines.split("\n")

N,Z,W = array[0].split(" ").map(&:to_i)
A     = array[1].split(" ").map(&:to_i)

lis     = get_lis(A)
max     = lis.max
sum_x   = 0
sum_y   = 0

lis.each_with_index do |l, idx|
  sum_x += A[idx] if l == max
end

sum_y     = A.inject(&:+) - sum_x
score     = sum_x - sum_y
score_now =

# puts sum_x
# puts sum_y

if score > Z
  puts score
else
  puts Z
end
