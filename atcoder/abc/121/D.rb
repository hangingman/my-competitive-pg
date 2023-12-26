lines = <<'EOS'
123456789012 123456789012
EOS

#lines = $stdin.read
array = lines.split("\n")
A,B = array[0].split(" ").map(&:to_i)

def f(_, n)
  return 0^1 if n==1

  # xorは偶数個演算 = 0
  # xorは奇数個演算 = 1
  if n.even?
    n ^ ((n/2).even? ? 0 : 1)
  else
    ((n+1)/2).even? ? 0 : 1
  end
end


puts f(0, A-1) ^ f(0, B)

# test code
# puts f(0,1)==1
# puts f(0,2)==1^2
# puts f(0,3)==1^1
# puts f(0,4)==1^1^4
# puts f(0,5)==1^1^1
