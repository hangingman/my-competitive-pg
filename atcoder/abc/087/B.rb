# coding: utf-8
lines = <<'EOS'
5
1
0
150
EOS

#lines = $stdin.read
array = lines.split("\n")
A,B,C,X = array[0..4].map(&:to_i)

def sum_coin(a=0,b=0,c=0)
  #puts "a = #{a}, b = #{b}, c = #{c}"
  a*500 + b*100 + c*50
end

ans = 0

for a in 0..A
  next if sum_coin(a) > X
  for b in 0..B
    next if sum_coin(a,b) > X
    for c in 0..C
      next if sum_coin(a,b,c) > X
      sum = sum_coin(a,b,c)
      next if sum > X
      if sum == X
        #puts "#{a},#{b},#{c}"
        ans += 1
      end
    end
  end
end

puts ans
