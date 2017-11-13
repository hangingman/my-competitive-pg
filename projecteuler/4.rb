def palindrome?(number)
  n = number.to_s

  if n.length % 2 == 0
    n[0...n.length/2] == n[n.length/2..n.length].reverse
  else
    n[0...n.length/2-1] == n[n.length+1/2..n.length].reverse
  end
end

digit3_a_array = 999.downto(100).to_a
digit3_b_array = digit3_a_array.dup
palindrome_arr = []

for digit3_a in digit3_a_array
  for digit3_b in digit3_b_array
    digit6 = digit3_a * digit3_b
    palindrome_arr << digit6 if palindrome?(digit6)
  end
end

puts palindrome_arr.max.to_s
