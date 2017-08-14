lines = <<'EOS'
4
1 1/1
2 1/3
3 5/2
4 2178309/1346269
EOS

#lines = $stdin.read
array = lines.split("\n")

N = array[0].to_i

for i in 1...array.size
  p, q = array[i].split(" ")[1].split("/").map(&:to_i)

  #puts "#{p}, #{q}"
  #puts "#{i} #{ans}"
  left, right = p, q
  depth = 1

  while left != 1 and right != 1
    depth = depth + 1

    # check myself is right
    c1_tmp_p_q = left + right
    c1_tmp_q   = right
    c1_tmp_p   = c1_tmp_p_q - c1_tmp_q

    # check myself is left
    c2_tmp_p_q = left + right
    c2_tmp_p   = left
    c2_tmp_q   = c2_tmp_p_q - c2_tmp_p

    puts "#{c1_tmp_p}, #{c2_tmp_q"}..."

    if c1_tmp_p > 0

    else

    end

  end

  puts "input #{i}, depth: #{depth}"
end
