lines = <<'EOS'
12 2
EOS

#lines = $stdin.read
array = lines.split("\n")
A,B = array[0].split(" ").map(&:to_i)
N = "#{A}#{B}".to_i

# p Math.sqrt(N).to_s
# p Math.sqrt(N).to_s.gsub(/.*\./,'')

if Math.sqrt(N).to_s.gsub(/.*\./,'').to_i > 0
  puts "No"
else
  puts "Yes"
end
