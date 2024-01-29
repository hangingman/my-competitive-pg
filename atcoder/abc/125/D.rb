
lines = <<'EOS'
11
-1000000000 1000000000 -1000000000 1000000000 -1000000000 0 1000000000 -1000000000 1000000000 -1000000000 1000000000
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
A = array[1].split(" ").map(&:to_i)

minus_elems = A.select{|a| a < 0}
if minus_elems.size.even?
  puts A.map{|a| a.abs}.sum
else
  elems = A.map{|a| a.abs}
  min = elems.min
  puts elems.reject{|e| e==min}.sum - min
end
