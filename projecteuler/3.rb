N      = 600851475143
max    = Math.sqrt(N).round
primes = Array.new(max, 0)
test   = 1

for pn in 2..max
  c = 0
  while N % pn**c == 0
    c += 1
  end
  c = c-1
  primes[pn-1] = c
  test = test * (pn**c)
  #puts "test: #{test} = #{pn}^#{c}"
  break if test == N
end

primes.each_with_index do |p,i|
  puts "#{i+1} = (#{p})" if p != 0
end

t = primes.map.each_with_index do |pf,i|
  i+1 if pf != 0
end.compact.max

puts "max prime number is: #{t}"
