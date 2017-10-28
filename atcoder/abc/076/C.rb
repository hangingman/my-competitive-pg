lines = <<'EOS'
??p??d?????
abc
EOS

#lines = $stdin.read
array = lines.split("\n")

S = array[0].to_s
T = array[1].to_s

S.split("").each_with_index do |s,i|

  part_str = S[i, T.length]
  all_matched = true

  for j in 0..T.length
    if part_str[j] != "?" and part_str[j] != T[j]
      #puts "part_str[j] = #{part_str[j]}"
      #puts "       T[j] = #{T[j]}"
      #puts "all_matched = false"
      all_matched = false
      break
    end
  end

  if all_matched
    rep_str = S.dup
    rep_str[i..i+T.length-1] = T
    puts rep_str.gsub(/\?/, "a")
    exit 0
  end

  break if i == S.length - T.length
end

puts "UNRESTORABLE"
