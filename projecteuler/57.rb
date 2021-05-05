
def rec_div(n)
  if n==1
    return 1.quo(2)
  else
    return 1.quo(2 + rec_div(n-1))
  end
end

count = 0
for n in 1..1000
  ans = 1 + rec_div(n)

  if ans.numerator.to_s.split("").length > ans.denominator.to_s.split("").length
    count += 1
  end
end

puts count
