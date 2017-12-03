lines = <<'EOS'
1
1 1 0 1 0 0 0 1 0 1
3 4 5 6 7 8 9 -2 -3 4 -2
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
F = array[1..N]   # .map{|s| s.split("")}
P = array[N+1..N+N] # .map{|s| s.split("")}

ammout = F.map.with_index do |p,i|
  f = F[i].split(" ").map(&:to_i)
  p = P[i].split(" ").map(&:to_i)

  puts "f length #{f.length}"
  puts "p length #{p.length}"

  ammout_this = f.each_with_index do |fs,i|
    puts "f => #{f[i]}, p => #{p[i]}"
  end

  ammout_this
end

puts ammout.to_s
