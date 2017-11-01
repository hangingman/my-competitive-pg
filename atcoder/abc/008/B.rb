lines = <<'EOS'
9
a
b
c
c
b
c
b
d
e
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i

candidates = array[1..N].map(&:to_s).to_a
hash = {}

candidates.each do |c|
  if hash.has_key?(c)
    hash[c] += 1
  else
    hash[c] = 1
  end
end

puts hash.max_by{|h| h.last}.first
