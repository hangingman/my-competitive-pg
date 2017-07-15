lines = <<'EOS'
6
1 2 3 4 5 6
EOS

#lines = $stdin.read
array = lines.split("\n")
n     = array[0].to_i
arr   = array[1].split(" ").map(&:to_i)
absar = []

if n == 2
  puts (arr[0] - arr[1]).abs
  exit
end

# "i" is sunuke's card
S = arr.inject {|sum, n| sum + n }

x = arr[0]
y = S - x
absar.push((x-y).abs)

arr.inject do |a, b|
  #puts arr.to_s
  #puts "#{a}, #{b}, #{count}"
  x = x + b
  y = y - b
  #puts "x = #{x}, y = #{y}"
  absar.push((x-y).abs)
end

puts absar.min
