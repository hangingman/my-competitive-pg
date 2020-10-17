def make_divisors(n)
  divisors = []
  for i in 1..((n**0.5)+1).to_i
    if n % i == 0
      divisors << i
      if i != n / i
        divisors << n/i
      end
    end
  end
  divisors.delete(n)
  divisors.uniq.sort
end

@divisors_sums = {}

def make_divisors_sum(n)
  if @divisors_sums.has_key?(n)
    return @divisors_sums[n]
  end
  @divisors_sums[n] = make_divisors(n).inject(&:+)
  return @divisors_sums[n]
end

def find_cycle(n)
  sums = [n]
  loop {
    sums << make_divisors_sum(sums.last)
    return false,sums if sums.last.nil? or sums.last >= 1_000_000 or sums.length>50
    return true, sums if sums.last==n
  }
  return sums
end

ans = []

(1..1_000_000).to_a.each do |n|
  found,sums = find_cycle(n)
  if found
    puts "#{n} => #{sums}"
    ans = sums.dup if ans.length < sums.length
  end
end

p ans
