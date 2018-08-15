# coding: utf-8
lines = <<'EOS'
3 2
4 1 5
EOS

#lines = $stdin.read
array = lines.split("\n")

N,M = array[0].split(" ").map(&:to_i)
A = array[1].split(" ").map(&:to_i)
sums = 0
nums = {}

nums[0] = 1
A.each.with_index do |e,i|
  sums += e
  # count mods
  if nums[sums % M].nil?
    nums[sums % M] = 1
  else
    nums[sums % M] += 1
  end
end

#p A
#p nums

ans = 0
nums.each do |k,v|
  ans += v*(v-1)/2
end

puts ans
