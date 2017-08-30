lines = <<'EOS'
2 4
EOS

#lines = $stdin.read
array = lines.split("\n")
x,y = array[0].split(" ").map(&:to_i)

group_a = [1, 3, 5, 7, 8, 10, 12]
group_b = [4, 6, 9, 11]
group_c = [2]

def contain?(group, x, y)
  true if group.include?(x) and group.include?(y)
end

ret = if contain?(group_a, x, y) or contain?(group_b, x, y) or contain?(group_c, x, y)
        "Yes"
      else
        "No"
      end

puts ret
