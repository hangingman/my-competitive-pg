lines = <<'EOS'
5
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i

def ctz(n)
  ans = 0
  n.to_s(2).reverse.split("").each do |d|
    break if d=='1'
    ans += 1
  end
  puts ans
end

ctz(N)
