require 'set'

# a**2+b**2=c**2
# a+b+c=p

max_ans = {:pi => 0, :ans => 0}

for pi in 1..1000
  ans = Set.new
  for ai in 1..pi
    for bi in 1..(pi-ai)
      #puts "a=#{ai},b=#{bi}"
      if pi**2 == (2*pi*(ai+bi)-2*ai*bi)
        # puts "p = #{pi}"
        # puts "pi^2 = #{pi**2}"
        # puts "==> (pi^2)/2 = #{(pi**2)/2}"
        # puts "a=#{ai},b=#{bi},c=#{pi-ai-bi}"
        ans << [ai,bi,pi-ai-bi].sort.join(":")
      end
    end
  end
  puts "ans = #{ans.length}"
  if max_ans[:ans] < ans.length
    max_ans[:pi] = pi
    max_ans[:ans] = ans.length
  end
end

p max_ans
