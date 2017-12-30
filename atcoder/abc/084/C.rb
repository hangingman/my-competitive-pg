lines = <<'EOS'
3
6 5 1
1 10 1
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
c = []
s = []
f = []

array[1..N-1].each do |str|
  arr = str.split(" ").map(&:to_i)
  c << arr[0]
  s << arr[1]
  f << arr[2]
end

p c
p s
p f
