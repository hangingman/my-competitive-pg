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

all_x = array[1..N+1].map{|s| s.split.map(&:to_i)[0]}

p all_x
mat = Array.new()
