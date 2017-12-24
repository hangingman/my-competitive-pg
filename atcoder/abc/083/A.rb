lines = <<'EOS'
3 8 7 1
EOS

#lines = $stdin.read
array = lines.split("\n")
A,B,C,D = array[0].split(" ").map(&:to_i)
if A+B > C+D
  puts "Left"
elsif A+B == C+D
  puts "Balanced"
else
  puts "Right"
end
