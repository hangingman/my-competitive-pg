
def prime?(n, primes)
  if n == 1
    false
  elsif primes.include?(n)
    true
  else
    m = Math.sqrt(n).round
    2.upto(m) do |step|
      if step != 2 and step % 2 == 0
        next
      else
        if n % step == 0
          return false
        else
          next
        end
      end
    end
    true
  end
end

def truncate_prime?(n, primes)
  arr  = n.to_s.split("")
  head = arr.dup
  tail = arr.dup

  while not head.empty?
    unless prime?(head.join.to_i, primes)
      return false
    end
    head.pop
  end
  while not tail.empty?
    unless prime?(tail.join.to_i, primes)
      return false
    end
    tail.shift
  end
  true
end

primes = []
truncate_primes = []

number = 2

while truncate_primes.length != 11
  if prime?(number, primes)
    # add primes into memo
    primes << number
    puts "  Prime found! => #{number}"
    if truncate_prime?(number, primes) and number > 9
      truncate_primes << number
      puts "* Tr prime found! => #{number}"
    end
  end
  number += 1
end

p truncate_primes
p truncate_primes.inject(&:+)
