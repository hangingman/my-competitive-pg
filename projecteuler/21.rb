

def d(n)
   return 0 if n == 1
   array = n.downto(1).to_a.select{|x| n % x == 0 && n != x}
   array.inject(:+)
end

puts "--- test ---"
puts "d(220) should be 284 => #{d(220)}"
puts "d(284) should be 220 => #{d(284)}"

# start !
# d(n) == x, d(x) == n

puts "--- RUN ---"

amicable = []

1.upto(10000) do |n|
   dn = d(n)
   if d(dn) == n and n != dn
      puts "n == #{n}, d(#{n}) => #{dn}, and d(#{dn}) => #{d(dn)}"
      amicable << n
      amicable << dn
   end
end

puts "--- END ---"
puts "amicable numbers => #{amicable.uniq.to_s}"
puts "SUM => #{amicable.uniq.inject(&:+)}"
