lines = <<'EOS'
3
3 2 1
2 2 1
1 1 1
3
1
4
9
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
D = array[1..N].map{|s| s.split(" ").map(&:to_i)}
Q = array[N+1].to_i
P = array[N+2..Q+N+1].map(&:to_i)
