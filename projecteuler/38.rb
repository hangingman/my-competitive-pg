ans = 0

for n in 1..10**5
  arr = []
  i = 1

  loop {
    arr << i

    tmp = arr.map {|a| (a*n).to_s }.join
    break if tmp.length > 9

    if (1..9).to_a.all?{|d| tmp.include?(d.to_s) }
      if ans < tmp.to_i
        ans = tmp.to_i
        puts "n=#{n}, arr=#{arr}, ans=#{ans}"
      end
    end
    i += 1
  }
end

puts ans
