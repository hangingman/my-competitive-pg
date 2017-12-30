lines = <<'EOS'
12
EOS

#lines = $stdin.read
array = lines.split("\n")
M = array[0].to_i
puts (24-M)+24
