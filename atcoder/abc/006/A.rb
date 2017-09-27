#lines = <<'EOS'
#2
#EOS

lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

if N.to_s.include?("3") or N % 3 == 0
  puts "YES"
else
  puts "NO"
end
