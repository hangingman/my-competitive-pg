n   = 1
ans = nil

while true
  if 1.upto(20).all?{|i| n % i == 0}
    ans = n
    break
  end
  n += 1
end

puts ans
