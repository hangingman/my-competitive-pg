lines = <<'EOS'
41
EOS

#lines = \$stdin.read
array = lines.split("\n")

N = array[0].to_i

sqrt = Math.sqrt(N).round

min_arr = []

if sqrt**2 == N
  puts 0
  exit 0
else
  a,b = sqrt,sqrt

  if sqrt** 2 < N
    while a*b < (sqrt+1)**2
      s = (a-b).abs + N-(a*b)
      break if s < 0
      min_arr << s
      puts "a = #{a}, b = #{b}, S = #{s}"
      b += 1
    end
  else
    while a*b > (sqrt)**2
      s = (a-b).abs + N-(a*b)
      break if s < 0
      min_arr << s
      puts "a = #{a}, b = #{b}, S = #{s}"
      b -= 1
    end
  end
end

puts min_arr.to_s
puts min_arr.min
