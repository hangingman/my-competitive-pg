def fib(n)
   if n == 1 or n == 2
      1
   else
      n_1 = 1
      n_2 = 1
      tmp = 0
      for x in 3..n
         tmp = n_1 + n_2
         n_2 = n_1
         n_1 = tmp
      end
      tmp
   end
end

n = 1
s = 0
ans = 0

while true
   ans = fib(n)
   break if ans.to_s.length >= 1000
   n += 1
end

puts n
