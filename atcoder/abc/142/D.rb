require 'prime'

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
  divisors.uniq.sort
end

#lines = <<'EOS'
#17 2 34
#EOS

lines = $stdin.read
array = lines.split("\n")

A,B = array[0].split(" ").map(&:to_i)
a = make_divisors(A)
b = make_divisors(B)
common_divisors = a & b
puts common_divisors.select{|n| Prime.prime?(n) }.size + 1
