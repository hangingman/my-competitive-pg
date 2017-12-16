lines = <<'EOS'
8
2 7 1 8 2 8 1 8
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i
A = array[1].split(" ").map(&:to_i)
H = array[1].split.inject(Hash.new(0)) { |h,v| h[v.to_i] += 1; h }

# p A.sort
# p H

count = 0

H.each do |k,v|
  if k == v
    next
  elsif k > v
    count += v
  else
    count += (v-k)
  end
end

puts count
