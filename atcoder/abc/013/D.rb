# coding: utf-8
lines = <<'EOS'
5 7 2
1 4 3 4 2 3 1
EOS

#lines = $stdin.read
array = lines.split("\n")

def msb(x)
  x.to_s(2).size - 1
end

def lsb(x)
  msb(x & -x)
end

N,M,Q = array[0].split(" ").map(&:to_i)
A     = if M == 0
          []
        else
          array[1].split(" ").map(&:to_i)
        end
to    = 1.upto(N).to_a

for a in A.reverse
  to[a], to[a-1] = to[a-1],to[a]
end

# doubling
LOGN = msb(Q)+1
next_obj = Array.new(LOGN+1).map{Array.new(N, 0)}

for i in 0...N
  next_obj[0][i] = to[i] - 1
end

for k in 0...LOGN
  for i in 0...N
    if next_obj[k][i] == -1
      next_obj[k+1][i] = -1
    else
      next_obj[k+1][i] = next_obj[k][next_obj[k][i]]
    end
  end
end

QBIT = Q.to_s(2).reverse

for p in 0...N
  pidx = p
  (1..LOGN).to_a.reverse_each do |k|
    if 1 == QBIT[k-1].to_i
      pidx = next_obj[k-1][pidx]
    end
  end
  puts pidx+1
end
