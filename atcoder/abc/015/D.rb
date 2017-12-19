lines = <<'EOS'
22
5 3
5 40
8 50
3 60
4 70
6 80
EOS

#lines = $stdin.read
array = lines.split("\n")
EXCEL_WIDTH = array[0].to_i
N, MAX_PICS = array[1].split(" ").map(&:to_i)
WIDTH  = array[2..2+N].map{|s| s.split(" ").first.to_i}
WEIGHT = array[2..2+N].map{|s| s.split(" ").last.to_i}

def rec(idx, width, pics)
  #puts "idx = #{idx}, width = #{width}, pics = #{pics}"
  if idx == N
    #puts "  => idx(#{idx}) == N(#{N})"
    0
  elsif width > EXCEL_WIDTH or pics > MAX_PICS
    #puts "  => width or pics is max"
    rec(idx + 1, width, pics)
  else
    #puts "  => compare two results..."
    ans1 = rec(idx + 1, width, pics)
    #puts "  => idx = #{idx+1}, width = #{width}, pics = #{pics}             : #{ans1}"
    ans2 = rec(idx + 1, width + WIDTH[idx], pics + 1) + WEIGHT[idx]
    #puts "  => idx = #{idx+1}, width = #{width+WIDTH[idx]}, pics = #{pics+1}: #{ans2}"

    if (width + WIDTH[idx]) > EXCEL_WIDTH or (pics + 1) > MAX_PICS
      ans = ans1
    else
      ans = [ans1, ans2].max
    end
    ans
  end
end

#puts "MAX_WIDTH = #{EXCEL_WIDTH}, MAX_PICS = #{MAX_PICS}"
puts rec(0, 0, 0)
