lines = <<'EOS'
7477
549
593
EOS

#lines = $stdin.read
array = lines.split("\n")
X,A,B = array[0].to_i,array[1].to_i,array[2].to_i

puts (X-A) - B*((X-A)/B)
