lines = <<'EOS'
3
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
puts "L" + "o"*N + "ng"
