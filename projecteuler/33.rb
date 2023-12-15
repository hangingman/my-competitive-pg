ans = []

def devide(numerator, denominator)
  numerator.quo(denominator).to_f
rescue ZeroDivisionError
  puts "zero division"
  return -1
end

for x in 10...99
  for y in 10...99
    xd1,xd2 = x.to_s.split("").map(&:to_i)
    yd1,yd2 = y.to_s.split("").map(&:to_i)

    next if x==y
    next if x.quo(y) >= 1

    if yd1 == xd1 and yd1 != 0
      puts "#{x} / #{y}"
      puts "#{xd2.quo(yd2)} == #{x.quo(y)}" rescue "zero division"

      if devide(xd2, yd2) == devide(x, y)
        ans << {x: x, y: y}
      end
    end
    if yd2 == xd1 and yd2 != 0
      puts "#{x} / #{y}"
      puts "#{xd2.quo(yd1)} == #{x.quo(y)}" rescue "zero division"
      if devide(xd2, yd1) == devide(x, y)
        ans << {x: x, y: y}
      end
    end
    if yd1 == xd2 and yd1 != 0
      puts "#{x} / #{y}"
      puts "#{xd1.quo(yd2)} == #{x.quo(y)}" rescue "zero division"
      if devide(xd1, yd2) == devide(x, y)
        ans << {x: x, y: y}
      end
    end
    if yd2 == xd2 and yd2 != 0
      puts "#{x} / #{y}"
      puts "#{xd1.quo(yd1)} == #{x.quo(y)}" rescue "zero division"
      if devide(xd1, yd1) == devide(x, y)
        ans << {x: x, y: y}
      end
    end

    #puts "x: #{xd1},#{xd2}, y: #{yd1},#{yd2}"
  end
end

p ans
ans = ans.map{|m| m[:x].quo(m[:y]) }.inject(&:*)

p ans
