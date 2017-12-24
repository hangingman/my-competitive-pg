lines = <<'EOS'
267 294 165
EOS

#lines = $stdin.read
array = lines.split("\n")

def marble(n)
  (n**2 / 4).floor
end

R,G,B = array[0].split(" ").map(&:to_i)
# puts marble(R) + marble(G) + marble(B)

cusum = Array.new(800){0}

# index[-100] = 300
# index[   0] = 400
# index[+100] = 500

puts "R/2 = #{R/2}, [l, r] = [#{300 - (R/2)}, #{300 + (R/2)}]"
puts "G/2 = #{G/2}, [l, r] = [#{400 - (G/2)}, #{400 + (G/2)}]"
puts "B/2 = #{B/2}, [l, r] = [#{500 - (B/2)}, #{500 + (B/2)}]"

# p cusum
