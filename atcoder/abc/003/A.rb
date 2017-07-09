lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
s = 0

1.upto(N) do |e|
  s += (10000 * e)
end

puts s / N
