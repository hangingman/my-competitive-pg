lines = <<'EOS'
5
 -1 2 3 1 -1
 2 -1 -1 4 -1
 3 -1 -1 1 1
 1 4 1 -1 3
 -1 -1 1 3 -1
EOS

#lines = $stdin.read
array = lines.split("\n")

N   = array[0].to_i
d,p = Array.new(N){0},Array.new(N){-1}
c   = Array.new(N){:white}
m   = Array.new(N).map{Array.new(N, 0)}

for i in 1...N
  row  = i - 1
  cols = array[i].split(" ").map(&:to_i)
  cols.each_with_index do |col, idx|
    m[row][col] = col
  end
end

puts m.to_s

while true
  mincost = nil
  for i in 0...N-1
    if

    end
  end
end
