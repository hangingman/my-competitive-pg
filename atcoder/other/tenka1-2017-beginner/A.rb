lines = <<'EOS'
ABCD
EOS

#lines = $stdin.read
array = lines.split("\n")

S = array[0].to_s

if S[0] == S[1] and S[1] != S[2] and S[2] == S[3]
  puts "Yes"
else
  puts "No"
end
