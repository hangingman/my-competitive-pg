# n1**2 + n2**3 + n3**4
require 'set'

def erastosthenes(n)
  array = (2..n).to_a
  threshold = Math.sqrt(n)
  count = 2
  while threshold > count
    array.reject!{|n| n != count and n % count == 0}
    count += 1
  end
  array
end

MAX = 50_000_000
PN = erastosthenes(10**5)

N2 = PN.map{|n| n**2}.select{|n| n < MAX}
N3 = PN.map{|n| n**3}.select{|n| n < MAX}
N4 = PN.map{|n| n**4}.select{|n| n < MAX}
p N2.count
p N3.count
p N4.count

ans = Set[]
for n2 in N2
  for n3 in N3
    for n4 in N4
      sum = n2 + n3 + n4
      if sum > MAX
        next
      else
        ans << sum
      end
    end
  end
end

p ans.length
