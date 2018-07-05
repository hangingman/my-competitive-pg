# coding: utf-8

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

def erastosthenes_table1(n)
  # 0,1は素数(false)
  array = (0..n).to_a

  threshold = Math.sqrt(n)
  count = 2
  while threshold > count
    array.map! do |n|
      if n.is_a? Numeric and n!=count and n%count==0
        false
      else
        n
      end
    end
    count += 1
  end
  array.map do |e|
    if e.is_a? Numeric
      true
    else
      e
    end
  end
end

# time ruby erastosthenes.rb
# [false, true, true, true, false, true,
#  false, true, false, false, false, true,
#  false, true, false, false, false, true,
#  false, true, false, false, false, true,
#  false, false, false, false, false, true]
#
# real	0m2.397s
# user	0m0.000s
# sys	0m0.000s
# p erastosthenes_table1(10**5).take(30)

def erastosthenes_table2(n)
  # 0,1は素数(false)
  checked = Array.new(n+1,false)
  is_prime = Array.new(n+1,true)

  is_prime[1] = false
  for i in 2..(Math.sqrt(n).floor)
    next if checked[i]

    is_prime[i] = true
    checked[i] = true

    j = 2
    for j in 2..(n/i)
      checked[i*j] = true
      is_prime[i*j] = false
    end
  end
  is_prime
end

# time ruby erastosthenes.rb
# [true, false, true, true, false, true,
#  false, true, false, false, false, true,
#  false, true, false, false, false, true,
#  false, true, false, false, false, true,
#  false, false, false, false, false, true]
#
# real	0m0.101s
# user	0m0.000s
# sys	0m0.015s
#p erastosthenes_table2(10**5).take(30)
