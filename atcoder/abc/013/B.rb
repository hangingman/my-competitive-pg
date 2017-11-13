lines = <<'EOS'
8
1
EOS

#lines = $stdin.read
array = lines.split("\n")

a = array[0].to_i
b = array[1].to_i

# display = 0.upto(9).to_a
# display[a] = 'a'
# display[b] = 'b'
# puts display.to_s

inner = (a-b).abs
outer = 10 - [a,b].max + [a,b].min

puts [inner,outer].min
