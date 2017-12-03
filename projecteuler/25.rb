def fib(n)
  if n == 1
    1
  elsif n == 2
    2
  else
    fib(n-2) + fib(n-1)
  end
end

n = 1
s = 0
ans = 0

while true
  ans = fib(n)
  break if ans.to_s.length >= 3
  n += 1
end

puts s
