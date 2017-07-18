#lines = <<'EOS'
#4 5
#EOS

lines = $stdin.read
array = lines.split("\n")
A,B = array[0].split(" ").map(&:to_i)

if A % 3 == 0 and A > 2
  puts "Possible"
  exit
end
if B % 3 == 0 and B > 2
  puts "Possible"
  exit
end
if A+B % 3 == 0 and A+B > 2
  puts "Possible"
  exit
end

puts "Impossible"
