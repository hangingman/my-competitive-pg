# a**2 + b**2 = c**2
# a + b + c   = 1000

for a in 1..1000
  for b in 2..1000
    c = 1000 - a - b
    if (a+b+c == 1000) and (a**2 + b**2 == c**2) and (a < b and b < c)
      puts "a = #{a}, b = #{b}, c = #{c}"
      puts "  a*b*c = #{a*b*c}"
    end
  end
end
