lines = <<'EOS'
1
3
1 2 3
3
2 3 4
EOS

#lines = $stdin.read
array = lines.split("\n")
T = array[0].to_i
N = array[1].to_i
A = array[2].split(" ").map(&:to_i)
M = array[3].to_i
B = array[4].split(" ").map(&:to_i)

takoyaki = Array.new(300){0}

# array[35] = +1
# array[40] = -1

A.each do |m|
  takoyaki[m-1] = takoyaki[m-1]+1
  takoyaki[m-1+T] = takoyaki[m-1+T]-1
end
for i in 1...takoyaki.length
  takoyaki[i] += takoyaki[i-1]
end
p takoyaki.take(50)

B.each do |m|
  takoyaki[m-1] = takoyaki[m-1]-1
end
p takoyaki.take(50)
