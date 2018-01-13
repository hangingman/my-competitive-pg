lines = <<'EOS'
2525
EOS

#lines = $stdin.read
array = lines.split("\n")
S = array[0].split("")

if S[0] == S[2] and S[1] == S[3]
  puts "Yes"
else
  puts "No"
end
