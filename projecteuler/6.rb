def sum_of_sequare(n)
  ans = n * (n+1) * (2*n+1) / 6
  ans
end

def sequare_of_sum(n)
  ans = n * (n+1) / 2
  ans = ans**2
  ans
end

puts sequare_of_sum(100) - sum_of_sequare(100)
