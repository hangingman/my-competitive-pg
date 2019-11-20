lines = <<'EOS'
A
EOS

#lines = $stdin.read
array = lines.split("\n")
S = array[0]
puts S[0].upcase+S[1..-1].downcase
