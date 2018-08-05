lines = <<'EOS'
1200
EOS

#lines = $stdin.read
array = lines.split("\n")
R = array[0].to_i

if R < 1200
  puts "ABC"
elsif 1200 <= R and R < 2800
  puts "ARC"
else
  puts "AGC"
end
