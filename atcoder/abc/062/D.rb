lines = <<'EOS'
2
3 1 4 1 5 9
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
vals = array[1].split(" ").map(&:to_i)
keys = [*0...vals.size].map(&:to_i)

hash = Hash[keys.zip vals]
scores = []

keys.combination(N).each do |elems|
  hash_cp = hash.dup
  elems.each do |k,v|
    hash_cp.delete(k)
  end
  #puts hash_cp.values.to_s
  a_dash = hash_cp.values
  score  = a_dash[0, N].inject(:+) - a_dash[-N, N].inject(:+)
  #puts score
  scores << score
end

puts scores.max
