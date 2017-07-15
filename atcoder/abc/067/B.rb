#lines = <<'EOS'
#5 3
#1 2 3 4 5
#EOS

lines = $stdin.read
array = lines.split("\n")
n,k = array[0].split(" ").map(&:to_i)
lar = array[1].split(" ").map(&:to_i)

s = 0
lar = lar.sort.reverse

for i in 0..k-1
  s += lar[i]
end

puts s
