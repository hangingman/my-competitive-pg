lines = <<'EOS'
1
3000 7000000
EOS

#lines = $stdin.read

def erastosthenes(n)
  arr = (2..n).to_a
  threshold = Math.sqrt(n)
  count = 2
  while threshold > count
    arr.reject!{|n| n != count and n % count == 0}
    count += 1
  end
  arr
end

def like_2017?(n)
  is_prime?(n) and is_prime?((n+1)/2)
end

array = lines.split("\n")
Q = array[0].to_i
array[1..Q].each do |str|
  l,r = str.split(" ").map(&:to_i)
  arr = l.step(r, 2).to_a
  pns = erastosthenes(r)
  ans = arr & pns
  puts ans.length
end
