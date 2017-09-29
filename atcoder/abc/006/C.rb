lines = <<'EOS'
3 9
EOS

#lines = $stdin.read
array = lines.split("\n")
n,m = array[0].split(" ").map(&:to_i)

# a = man,b = old man,c = baby
0.upto(n) do |i|
  #puts "---------------------------------"
  #puts "[#{i}] --> #{n}, #{m}"
  a = i
  b = 4*n - m - 2*i
  c = n - a - b
  # puts "a = #{a}, b = #{b}, c = #{c}"
  if a >= 0 and b >= 0 and c >= 0
    puts "#{a} #{b} #{c}"
    exit 0
  end
end

puts "-1 -1 -1"
