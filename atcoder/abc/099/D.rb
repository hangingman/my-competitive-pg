# coding: utf-8
lines = <<'EOS'
4 3
0 12 71
81 0 53
14 92 0
1 1 2 1
2 1 1 2
2 2 1 3
1 1 2 2
EOS

#lines = $stdin.read
array = lines.split("\n")
N,C=array[0].split(" ").map(&:to_i)

d_vec = array[1...C+1].map do |line|
  line.split(" ").map(&:to_i)
end
c_vec = array[C+1...C+N+1].map do |line|
  line.split(" ").map(&:to_i)
end

# cost[C][3]
# D_{i,j} から赤枠がa or b or cになった場合の違和感の和の配列
cost = Array.new(C).map{Array.new(3, 0)}

for c in (1..C).to_a
  for y in 1..N
    for x in 1..N
      #puts "C=#{c}, (#{x},#{y})"
      #puts "current color = #{c_vec[y][x]}"
      cur_color = c_vec[y-1][x-1]
      #puts "#{cur_color-1} -> #{c-1} cost=#{d_vec[cur_color-1][c-1]}"

      case (x + y) % 3
      when 2 then # a
        cost[c-1][0] += d_vec[cur_color-1][c-1]
        #cost[c-1][0] += d_vec[c-1][cur_color-1]
      when 0 then # b
        cost[c-1][1] += d_vec[cur_color-1][c-1]
        #cost[c-1][1] += d_vec[c-1][cur_color-1]
      when 1 then # c
        cost[c-1][2] += d_vec[cur_color-1][c-1]
        #cost[c-1][2] += d_vec[c-1][cur_color-1]
      else
      end
    end
  end
end

ans = []
for group in (1..C).to_a.permutation(3).to_a
  a,b,c = group
  cost_a = cost[a-1][0]
  cost_b = cost[b-1][1]
  cost_c = cost[c-1][2]
  cost_sum = cost_a + cost_b + cost_c

  ans << cost_sum
end

#p (1..C).to_a
puts ans.min
