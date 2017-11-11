lines = <<'EOS'
100 5
EOS

#lines = $stdin.read
array = lines.split("\n")

N,M = array[0].split(" ").map(&:to_i)

# E = 1/p
# p = 1/2^M
_2m = 2**M
time = _2m * 1900*M + _2m * 100 * (N-M)

puts time
