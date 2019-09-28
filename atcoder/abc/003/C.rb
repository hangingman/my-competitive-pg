lines = <<'EOS'
2 1
1000 1500
EOS

#lines = $stdin.read
array = lines.split("\n")
N,K = array[0].split(" ").map(&:to_i)
R = array[1].split(" ").map(&:to_i)

ans = 0
R.sort.reverse.take(K).reverse.each do |r|
  ans = (ans+r)/2.to_f
end
puts ans
