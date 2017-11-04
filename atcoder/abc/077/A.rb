lines = <<'EOS'
tab
bet
EOS

#lines = $stdin.read
array = lines.split("\n")

c1 = array[0]
c2 = array[1]

if c1.reverse == c2
  puts "YES"
else
  puts "NO"
end
