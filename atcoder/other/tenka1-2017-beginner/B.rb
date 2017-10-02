lines = $stdin.read
array = lines.split("\n")

n = array[0].to_i

score_h = {}
1.upto(n) do |index|
  index,score = array[index].to_s.split(" ").map(&:to_i)
  score_h[index] = score
end

#puts "max value => #{score_h.keys.min} => #{score_h[score_h.keys.min]}"
#puts "min value => #{score_h.keys.max} => #{score_h[score_h.keys.max]}"

top      = score_h.keys.min - 1
interval = score_h.keys.max - score_h.keys.min + 1
bottom   = score_h[score_h.keys.max]

#puts "^ ... = #{score_h.keys.min - 1}"
#puts "| ... = #{interval}"
#puts "_ ... = #{score_h[score_h.keys.max]}"

puts top + interval + bottom
