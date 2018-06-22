# 7 6
# 6 4
# 4 0
# 0
def lsb(n)
  n&-n
end

# left
def parent_l(n)
  n -= lsb(n)
  n
end

# right
def parent_r(n)
  n += lsb(n)
  n
end

p parent_l(7)
p parent_r(7)
