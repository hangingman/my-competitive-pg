def prime(n, primes)
  if n == 1
    return false,primes
  elsif primes.include?(n)
    return true,primes
  else
    m = Math.sqrt(n).round
    2.upto(m) do |step|
      if step != 2 and step % 2 == 0
        next
      else
        if n % step == 0
          return false,primes
        else
          next
        end
      end
    end
    primes << n
    return true,primes
  end
end

primes=[]

9.downto(1) do |digit|
  (1..digit).to_a.permutation(digit) do |arr|
    n = arr.join.to_i
    is_prime,primes = prime(n, primes)
    if is_prime
      p n
    end
  end
end

puts primes.max
