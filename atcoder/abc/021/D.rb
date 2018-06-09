lines = <<'EOS'
10
2
EOS

#lines = $stdin.read
array = lines.split("\n")
$n = array[0].to_i
$k = array[1].to_i

MOD = 1_000_000_007

def loop_2d(h,w,header)
  s = Array.new(h).map{Array.new(w,0)}
  s[0] = header
  for row in 1...h
    for col in 0...w
      s[row][col] = s[row-1][0..col].inject(&:+) % MOD
    end
  end
  s
end

#ans = loop_2d(10**5+1, 10**5+1, (1..10**5+1).to_a)
ans = loop_2d($k, $n, (1..$n).to_a)

puts ans[$k-1][$n-1]
