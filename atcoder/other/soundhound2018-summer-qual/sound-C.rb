lines = <<'EOS'
2 3 1
EOS

#lines = $stdin.read
array = lines.split("\n")
N,M,D = array[0].split(" ").map(&:to_i)

ans = if D.zero?
        1.quo(N)
      else
        (2*(N - D)).quo(N**2)
      end

puts "%.10f" % ((M-1)*ans).to_f
