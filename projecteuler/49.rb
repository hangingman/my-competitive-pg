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

PN = erastosthenes(10**4).reject{|n| n < 1000}
ans = []

for p1 in PN

  for p2 in PN.reject{|p| p < p1}

    for p3 in PN.reject{|p| p < p2}
      d1 = p2-p1
      d2 = p3-p2

      if p1!=p2 and p2!=p3 and d1==d2
        puts "#{p1},#{p2},#{p3}"
        k1 = p1.to_s.split("").sort
        k2 = p2.to_s.split("").sort
        k3 = p3.to_s.split("").sort
        if k1==k2 and k2==k3
          ans << {:p1 => p1, :p2 => p2, :p3 => p3}
        end
      end
    end
  end
end

puts ""
p ans
