# coding: utf-8



d = ""
(0..10**6).to_a.each do |n|
  d += n.to_s
  break if d.length > 1000000
end

# d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000
puts d[0,100]

puts d[10**0].to_i
puts d[10**1].to_i
puts d[10**2].to_i
puts d[10**3].to_i
puts d[10**4].to_i
puts d[10**5].to_i
puts d[10**6].to_i

puts (0..6).to_a.map{|i| d[10**i].to_i}.inject(&:*)
