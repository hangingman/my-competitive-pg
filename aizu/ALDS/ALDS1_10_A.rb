# coding: utf-8
#lines = <<'EOS'
#3
#EOS

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

lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i

puts fib(N+1)
