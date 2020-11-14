





ans = 0
total = 0
day_of_week = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]

(1900..2000).to_a.each do |year|
  is_uruu = (year % 4 == 0) and not (year % 400 != 0 and year % 100 == 0)
  
  (1..12).to_a.each do |month|
    (1..31).to_a.each do |day|
      is_sunday_of_first_day_of_month = ((total % 7 == 6) and day == 1)

      puts "#{is_uruu ? '*' : ' '} #{year} #{month} #{day} #{day_of_week[total % 7]} => #{is_sunday_of_first_day_of_month}"
      total += 1
      ans += 1 if is_sunday_of_first_day_of_month and year > 1900
       
      break if day==28 and month==2 and not is_uruu
      break if day==29 and month==2 and is_uruu
      break if day==30 and (month==4 or month==6 or month==9 or month==11)
    end
  end
end

puts ans
