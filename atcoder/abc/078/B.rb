lines = <<'EOS'
64145 123 456
EOS

#lines = $stdin.read
array = lines.split("\n")

X,Y,Z = array[0].split(" ").map(&:to_i)

sum   = 0
times = 1

while true
  sum = (Z + Y) * times
  break if sum > X
  #puts "#{sum} < #{X}"
  times += 1
end

times-=1

if (X - (Z + Y) * times) >= Z
  puts times
else
  puts times-1
end
