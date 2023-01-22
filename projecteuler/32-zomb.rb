DIGITS = (1..9).to_a
ans = {}

(1..9999).each do |a|
  a_digits = a.to_s
  for b_digit in (4.5 - a_digits.size).to_i..(5 - a_digits.size)
    tmp_digits = DIGITS - a_digits.split("").map(&:to_i).to_a

    tmp_digits.permutation(b_digit) do |b_arr|
      c_arr = tmp_digits - b_arr

      next if b_arr.size==0

      b = b_arr.join.to_i
      c = a * b
      a_arr = a.to_s.split("").map(&:to_i)
      c_arr = c.to_s.split("").map(&:to_i)

      digits = a_arr + b_arr + c_arr
      if DIGITS.all? {|d| digits.include? d } && [a_arr.size,b_arr.size,c_arr.size].inject(&:+)==9
        puts "#{a} * #{b} = #{c}"

        # product => [small, large]
        ans.merge!({c => [[a,b].min, [a,b].max]})
      end
    end
  end
end

p ans.map{|k,v| k.to_i}.inject(&:+)
