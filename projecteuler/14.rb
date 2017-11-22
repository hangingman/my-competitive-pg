def series(n, array)
  if n % 2 == 0
    array << n
    series(n/2, array)
  elsif n != 1
    array << n
    series(3*n+1, array)
  else
    array << 1
    array
  end
end

max_n = 0
max_l = 0

for n in 1..1000000
  array = []
  #puts series(n, array).to_s

  len = series(n, array).length
  max_n,max_l = n,len if max_l < len
end

puts "n = #{max_n}, length = #{max_l}"}}
