def fact(n)
  if n == 0 or n == 1
    1
  else
    n * fact(n-1)
  end
end

facts = {}

# 3..2540160
ans = (3..2540160).to_a.select do |n|
  answer = []
  answer << "n = #{n}"
  tmp = n.to_s.split("").map do |d|
    debug = fact(d.to_i)
    answer << "  => #{d}! = #{debug}"
    debug
  end.inject(&:+)
  answer << "  SUM = #{tmp}"

  puts answer.join("\n") if n == tmp
  n == tmp
end

p ans

p ans.inject(&:+)
