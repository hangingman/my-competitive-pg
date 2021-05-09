


def palindromes?(n_str)
  if n_str.size.odd?
    mid = n_str.size/2
    first_half = n_str[0, mid]
    second_half = n_str[mid+1, mid]
    return first_half == second_half.reverse
  end
  if n_str.size.even?
    mid = n_str.size/2
    first_half = n_str[0, mid]
    second_half = n_str[mid, mid]
    return first_half == second_half.reverse
  end
end

p palindromes?(45854.to_s)
p palindromes?(45854.to_s(2))


ans = 0
(0..1_000_000).each do |n|
  if palindromes?(n.to_s) and palindromes?(n.to_s(2))
    puts n
    ans += n
  end
end

puts ""
puts ans
