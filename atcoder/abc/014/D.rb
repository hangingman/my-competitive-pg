# coding: utf-8
lines = <<'EOS'
5
1 2
1 3
1 4
4 5
3
2 3
2 5
2 4
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
LOGN = Math.log2(N).floor
Q = array[N].to_i

next_hash = {}
array[1..N-1].each do |s|
  k,v = s.split(" ").map(&:to_i)
  k,v = k-1,v-1
  if next_hash[k].nil?
    next_hash[k] = v
  else
    next_hash[k] = -1
  end
  if next_hash[v].nil?
    next_hash[v] = k
  else
    next_hash[v] = -1
  end
end

next_obj = Array.new(LOGN+1).map{Array.new(N, 0)}

for i in 0...N
  next_obj[0][i] = next_hash[i]
end

for k in 0...LOGN
  for i in i...N
    if next_obj[k][i] == -1
      next_obj[k+1][i] = -1
    else
      next_obj[k+1][i] = next_obj[k][next_obj[k][i]]
    end
  end
end

p next_obj

array[N+1..N+Q].each do |s|
  p s
end
