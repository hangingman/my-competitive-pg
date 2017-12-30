lines = <<'EOS'
1 2
7444
EOS

#lines = $stdin.read
array = lines.split("\n")
A,B = array[0].split(" ").map(&:to_i)
S   = array[1]

if S.match(Regexp.new("[0-9]{#{A}}-[0-9]{#{B}}"))
  puts "Yes"
else
  puts "No"
end
