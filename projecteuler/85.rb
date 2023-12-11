

def count_rectangles(x, y)
  x * (x+1) / 2 * y * (y+1) / 2
end

#x_max = 1
#loop {
#  break if count_rectangles(x_max, x_max) > 2000_000
#  x_max += 1
#}

#p x_max
#p count_rectangles(x_max, x_max)

ax,ay = [0,0]
ans = 0
for x in 1..100
  for y in 1..100
    recls = count_rectangles(x,y)
    puts "x=#{x}, y=#{y} rectangles=#{recls} diff=#{2000_000-recls}"

    ans = if (2000_000-recls).abs < (2000_000-ans).abs
            ax,ay=x,y
            recls
          else
            ans
          end
  end
end

puts ans
p ax
p ay
p ax*ay
