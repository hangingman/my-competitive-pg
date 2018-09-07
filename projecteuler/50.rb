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

PN = erastosthenes(10**6)
PN_MAX = PN.max

#for size in 2...PN.length
(2...PN.length).reverse_each do |size|
  PN.each_cons(size) do |primes|
    sum = primes.inject(:+)
    break if sum > PN_MAX

    ans = PN.detect{|p| p == sum}
    unless ans.nil?
      puts "#{ans} = #{primes}"
      exit 0
    else
      print "."
    end
  end
  #puts "END #{size}"
end
