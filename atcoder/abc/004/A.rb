#lines = <<'EOS'
#20
#EOS

lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
puts 2 * N
