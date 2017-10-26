lines = <<'EOS'
a
EOS

#lines = $stdin.read
array = lines.split("\n")

line = array[0]

if line == line.reverse
  puts 0
else

end
