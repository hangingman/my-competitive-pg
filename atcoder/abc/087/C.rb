lines = <<'EOS'
1
2
3
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
U = array[1].split(" ").map(&:to_i)
D = array[2].split(" ").map(&:to_i)
SUM_D = D.inject(&:+)

arr = Array.new(5,0)

for i in 0...N
  if i == 0
    arr[i] = U[i] + SUM_D
  else
    arr[i] = arr[i-1] - D[i-1] + U[i]
  end
end

puts arr.max
