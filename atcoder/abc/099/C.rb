# coding: utf-8
lines = <<'EOS'
44852
EOS

#lines = $stdin.read
array = lines.split("\n")
INF = 1 << 25

def pay(amount,kind,pays)
  dp = Array.new(amount+1, INF)
  dp[0] = 0
  for i in 0...kind
    for j in pays[i]..amount
      dp[j] = [dp[j], dp[j - pays[i]] + 1].min
    end
  end
  dp
end

N = array[0].to_i
sixes, nines = [],[]

six=6
nine=9

for i in 1..10**5
  break if six**i > 10**5
  sixes << six**i
end
for i in 1..10**5
  break if nine**i > 10**5
  nines << nine**i
end

pays = [1].concat(sixes).concat(nines).sort
dp = pay(N,pays.size,pays)
puts dp[N]

#p dp
