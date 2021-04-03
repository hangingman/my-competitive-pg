# coding: utf-8
ans = []

(0..9).to_a.permutation do |arr|
  next unless arr[1, 3].join.to_i % 2 == 0
  next unless arr[2, 3].join.to_i % 3 == 0
  next unless arr[3, 3].join.to_i % 5 == 0
  next unless arr[4, 3].join.to_i % 7 == 0
  next unless arr[5, 3].join.to_i % 11 == 0
  next unless arr[6, 3].join.to_i % 13 == 0
  next unless arr[7, 3].join.to_i % 17 == 0

  puts arr.join.to_i
  ans << arr.join.to_i
end

puts ""
puts ans.inject(&:+)
