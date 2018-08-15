lines = <<'EOS'
2 4
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

#        a, b
CAKEs = [4, 7]
#        0, 1
ans   = []
sum   = 0

def sum_cake(b=0,a=0)
  a*4 + b*7
end

for b in 0..N/CAKEs[1]
  next if sum_cake(b) > N
  for a in 0..N/CAKEs[0]
    sum = sum_cake(b,a)
    next if sum > N
    if sum == N
      #puts "#{a},#{b}"
      #ans << "a = #{a},b = #{b}"
      puts "Yes"
      exit 0
    end
  end
end

puts "No"
