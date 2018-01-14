lines = <<'EOS'
58 23 42
EOS

#lines = $stdin.read
array = lines.split("\n")
N,A,B = array[0].split(" ").map(&:to_i)

diff = ((A-B).abs-1).to_i

if diff % 2 == 0
  puts "Borys"
else
  puts "Alice"
end
