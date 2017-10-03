lines = <<'EOS'
9
EOS

#lines = $stdin.read
array = lines.split("\n")
puts array[0].to_i - 1
