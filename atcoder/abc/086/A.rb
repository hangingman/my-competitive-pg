lines = <<'EOS'
3 4
EOS

#lines = $stdin.read
array = lines.split("\n")
A,B = array[0].split(" ").map(&:to_i)
if A*B % 2 == 0
  puts "Even"
else
  puts "Odd"
end
