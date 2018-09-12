def digits_match?(x)
  x1 = (1*x).to_s.split("").sort
  x2 = (2*x).to_s.split("").sort
  x3 = (3*x).to_s.split("").sort
  x4 = (4*x).to_s.split("").sort
  x5 = (5*x).to_s.split("").sort
  x6 = (6*x).to_s.split("").sort

  if x1==x2 and x2==x3 and x3==x4 and x4==x5 and x5==x6
    true
  else
    false
  end
end

for x in 1..10**10
  if digits_match?(x)
    puts x
    break
  end
end
