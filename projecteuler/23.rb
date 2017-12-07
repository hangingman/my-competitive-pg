

def detect_pf(n)
   return 0 if n == 1
   array = n.downto(1).to_a.select{|x| n % x == 0 && n != x}
   sum = array.inject(:+)
   if sum == n
      :pf
   elsif sum > n
      :ab
   else
      :de
   end
end

puts "--- test ---"
puts "28 is perfect number ? #{detect_pf(28)}"

puts "--- RUN ---"

ab_array = []

28123.downto(1) do |n|
   if detect_pf(n) == :ab
      ab_array << n
      puts ". #{n}"
   else
      printf "."
   end
end

ab_array.sort!
array = 1.upto(28123).to_a - ab_array

puts "abundon numbers size => #{ab_array.length}"
puts "1~28123 array except abundon numbers =>"
puts array.to_s
