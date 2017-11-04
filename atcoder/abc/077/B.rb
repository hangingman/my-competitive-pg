require 'bigdecimal'

lines = <<'EOS'
81
EOS

#lines = $stdin.read
array = lines.split("\n")

N = BigDecimal(array[0])

r = Math.sqrt(N).round
puts r*r
