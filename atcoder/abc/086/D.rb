lines = <<'EOS'
4 3
0 1 W
1 2 W
5 3 B
5 4 B
EOS

#lines = $stdin.read
array = lines.split("\n")
N,K   = array[0].split(" ").map(&:to_i)

coords = array[1..N+1].map do |str|
  x,y,color = str.split(" ")
  x,y = x.to_i,y.to_i
  x,y,color = x,y+K,'B' if color == 'W'
  x,y = x%2*K,y%2*K
  puts "#{x},#{y},#{color}"
  [x,y,color]
end

p coords
