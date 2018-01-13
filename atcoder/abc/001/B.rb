lines = <<'EOS'
40000
EOS

#lines = $stdin.read
array = lines.split("\n")
M = array[0].to_i

if M < 100
  puts "00"
elsif 100 <= M and M <= 5000
  printf "%02d\n", M/100
elsif 6000 <= M and M <= 30000
  printf "%d\n", M/1000 + 50
elsif 35000 <= M and M <= 70000
  printf "%d\n", (M/1000 - 30)/5 + 80
else
  puts "89"
end
