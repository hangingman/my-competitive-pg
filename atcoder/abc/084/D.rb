# coding: utf-8

def erastosthenes_table(n)
  # 0,1は素数(false)
  checked = Array.new(n+1,false)
  is_prime = Array.new(n+1,true)

  is_prime[0] = false
  is_prime[1] = false

  for i in 2..(Math.sqrt(n).floor)
    next if checked[i]

    is_prime[i] = true
    checked[i] = true

    j = 2
    for j in 2..(n/i)
      checked[i*j] = true
      is_prime[i*j] = false
    end
  end

  is_prime
end

$pn_table = erastosthenes_table(10**5+1)
$table = Array.new(10**5+1,0)

def is_prime?(n)
  $pn_table[n]
end

def like_2017?(n)
  is_prime?(n) and is_prime?((n+1)/2)
end

1.step(10**5,1).each do |e|
  if like_2017?(e) and e.odd?
    $table[e] = $table[e-1] + 1
  else
    $table[e] = $table[e-1]
  end
end

#lines = <<'EOS'
#6
#1 53
#13 91
#37 55
#19 51
#73 91
#13 49
#EOS
lines = $stdin.read
array = lines.split("\n")

Q = array[0].to_i

array[1..Q].each do |str|
  l,r = str.split(" ").map(&:to_i)
  puts $table[r] - $table[l-1]
end
