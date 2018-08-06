# coding: utf-8
lines = <<'EOS'
2 700
3 500
5 800
EOS

#lines = $stdin.read
array = lines.split("\n")
D,G = array[0].split(" ").map(&:to_i)
bonus_points_h = {}

bonus_points_h = array[1...D+1].map.with_index(1) do |str,idx|
  p,b = str.split(" ").map(&:to_i)
  #{b => [idx*100, p]}
  {p => [idx*100, b+(idx*100*p)]}
end

# .sort_by do |h|
#   h.first
# end.reverse

p bonus_points_h

exit 0

ans,cur_sum = 0,0

bonus_points_h.each do |hashmap|
  bonus = hashmap.keys.first
  point = hashmap.values.first[0]
  p_cnt = hashmap.values.first[1]

  puts "bonus=#{bonus}, point=#{point}, p_count=#{p_cnt}"
  if cur_sum + point*p_cnt + bonus >= G
    puts "cur_sum (=#{cur_sum}) + point*p_cnt (=#{point*p_cnt}) + bonus (=#{bonus}) >= G(=#{G})"
    ans += p_cnt
    break
  else

    for cnt in 1..p_cnt
      if cur_sum + point*p_cnt >= G
        puts "cur_sum (=#{cur_sum}) + point*p_cnt (=#{point*p_cnt}) >= G(=#{G})"
        ans += cnt
        break
      end
    end

    # ans += p_cnt
    # cur_sum += bonus
  end
end

p bonus_points_h

puts ans
