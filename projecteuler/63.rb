def count_digits(n)
  Math.log10(n.abs).to_i + 1
end

def pow(x, n, d)
  #puts "#{x}^#{n}"
  ans = 1
  while n > 0
    #puts "n = #{n}, x = #{x}"
    ans = ans * x if n.odd?
    return nil if count_digits(ans) > d
    x = x * x
    n >>= 1
  end
  ans
end

N = 3

for x in 1..N
  n = 1
  ans = nil
  until not ans.nil?
    n+=1
    ans = pow(x,n,n)
    puts "#{x}^#{n} = #{ans}" #  if x == count_digits(ans)
  end
end
