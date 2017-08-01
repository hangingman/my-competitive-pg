# coding: utf-8
#lines = <<'EOS'
#4
#1 2 2 4
#2 1 4
#3 0
#4 1 3
#EOS

lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i

m = Array.new(N).map{Array.new(N, 0)}

for i in 1...array.length
  elems = array[i].split(" ").map(&:to_i)
  u = elems[0]
  k = elems[1]
  v = elems.drop(2) # Array#tail ほしい

  #puts "#{u}, #{k}, #{v.to_s}"
  for j in 0...v.length
    #puts "m[#{u-1}][#{v[j]-1}] = 1"
    m[u-1][v[j]-1] = 1
  end
end

for i in 0...N
  puts m[i].join(" ")
end
