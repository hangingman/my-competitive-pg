lines = <<'EOS'
4 11
EOS

#lines = $stdin.read
array = lines.split("\n")
A,B = array[0].split(" ").map(&:to_i)
if A+B==15
  puts "+"
elsif A*B==15
  puts "*"
else
  puts "x"
end
