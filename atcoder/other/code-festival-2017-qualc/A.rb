lines = <<'EOS'
ABCD
EOS

#lines = $stdin.read
array = lines.split("\n")

if array[0].to_s.include?("AC")
  puts "Yes"
else
  puts "No"
end
