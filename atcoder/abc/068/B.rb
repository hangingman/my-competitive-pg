lines = <<'EOS'
38
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

test_array = 1.upto(N).to_a
puts test_array.to_s
