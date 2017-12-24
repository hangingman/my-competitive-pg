lines = <<'EOS'
2 3 4
EOS

#lines = $stdin.read
array = lines.split("\n")

def marble(n)
  (n**2 / 4).floor
end

R,G,B = array[0].split(" ").map(&:to_i)
puts marble(R) + marble(G) + marble(B)
