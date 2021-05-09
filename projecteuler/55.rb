


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

def reverse_sum(n)
  n + n.to_s.reverse.to_i
end

def lychrel?(n)
  50.times{
    n = reverse_sum(n)
    if palindromes?(n.to_s)
      return false
    end
  }
  return true
end

ans = 0
(0..10_000).each do |n|
  if lychrel?(n)
    puts n
    ans += 1
  end
end
puts ""
puts ans
