




def l_up(n)
  r_up(n) - 2*(n-1)
end

def r_up(n)
  (2*n - 1)**2
end

def r_down(n)
  l_down(n) - 2*(n-1)
end

def l_down(n)
  l_up(n) - 2*(n-1)
end

# 2(n-1)+1 = 1001
# 2n - 2   = 1000
#       2n = 1002
#        n =  501

ans = 1 + (2..501).map do |n|
  l_up(n) + r_up(n) + r_down(n) + l_down(n)
end.inject(&:+)

puts ans
