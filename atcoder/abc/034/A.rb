lines = <<'EOS'
12 34
EOS

#lines = $stdin.read
array = lines.split("\n")
X,Y = array[0].split(" ").map(&:to_i)
if X < Y
  puts "Better"
else
  puts "Worse"
end
