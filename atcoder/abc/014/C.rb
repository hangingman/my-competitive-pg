#
# Imos method ???
#
# lines = <<'EOS'
# 4
# 1000000 1000000
# 1000000 1000000
# 0 1000000
# 1 1000000
# EOS

lines = $stdin.read
array = lines.split("\n")
n = array[0].to_i

colors = Array.new(1000002){0}

for i in 1...(array.size)
  a,b = array[i].split(" ").map(&:to_i)
  colors[a]   = colors[a]   + 1
  colors[b+1] = colors[b+1] - 1
end

for i in 1...(colors.size)
  colors[i] += colors[i-1]
end

#puts colors.slice(999990, 1000001).to_s
puts colors.max
