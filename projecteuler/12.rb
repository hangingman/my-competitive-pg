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

n   = 1
tri = 0

while true
  tri += n
  arr = erastosthenes(tri)
  arr << 1
  arr << tri
  arr.uniq!
  count = arr.length
  puts "tri = #{tri}, #{arr.to_s}"
  #print "."
  break if count > 500
  n += 1
end

puts n*(n+1)/2
