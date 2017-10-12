lines = <<'EOS'
5 7 1
1 4 3 4 2 3 1
EOS

#lines = $stdin.read
array = lines.split("\n")

N,M,D = array[0].split(" ").map(&:to_i)
A     = array[1].split(" ").map(&:to_i)

to    = 1.upto(N).to_a

for a in A.reverse
  to[a], to[a-1] = to[a-1],to[a]
end

to.each{ |t| puts t }
