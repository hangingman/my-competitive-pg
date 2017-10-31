lines = <<'EOS'
2 4
EOS

#lines = $stdin.read
array = lines.split("\n")
A,B = array[0].split(" ").map(&:to_i)
puts "#{B} #{A}"
