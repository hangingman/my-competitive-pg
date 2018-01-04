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

def circular_prime?(n, prime_numbers)
  if prime_numbers.include?(n)
    rolling_num(n).all?{|pn| prime_numbers.include?(pn)}
  else
    false
  end
end

def rolling(str)
  arr = str.to_s.split("")
  ans = []
  for i in 0...arr.length
    ans << arr[i...arr.length].concat(arr[0...i]).flatten
  end
  ans
end

def rolling_str(s)
  rolling(s).map{|arr| arr.join.to_s}
end

def rolling_num(n)
  rolling(n).map{|arr| arr.join.to_i}
end

PN = erastosthenes(1000000)
ans = PN.count{|pn| circular_prime?(pn,PN)}
puts "Prime numbers under 1-million: #{PN.length}"
puts "Circular prime numbers under 1-million: #{ans}"
