def digit_to_word(d)
  case d
  when 0 then
    "zero"
  when 1 then
    "one"
  when 2 then
    "two"
  when 3 then
    "three"
  when 4 then
    "four"
  when 5 then
    "five"
  when 6 then
    "six"
  when 7 then
    "seven"
  when 8 then
    "eight"
  when 9 then
    "nine"
  end
end

def ten_digit_to_word(d)

  case d.to_s
  when "11"
    "eleven"
  when "12"
    "twelve"
  when "13"
    "thirteen"
  when "14"
    "fourteen"
  when "15"
    "fifteen"
  when "16"
    "sixteen"
  when "17"
    "seventeen"
  when "18"
    "eighteen"
  when "19"
    "nineteen"
  when /2([\d]{1})/
    x = digit_to_word($1.to_i)
    "twenty-#{x}"
  when /3(\d{1})/
    x = digit_to_word($1.to_i)
    "thirty-#{x}"
  when /4(\d{1})/
    x = digit_to_word($1.to_i)
    "forty-#{x}"
  when /5(\d{1})/
    x = digit_to_word($1.to_i)
    "fifty-#{x}"
  when /6(\d{1})/
    x = digit_to_word($1.to_i)
    "sixty-#{x}"
  when /7(\d{1})/
    x = digit_to_word($1.to_i)
    "seventy-#{x}"
  when /8(\d{1})/
    x = digit_to_word($1.to_i)
    "eighty-#{x}"
  when /9(\d{1})/
    x = digit_to_word($1.to_i)
    "ninety-#{x}"
  end
end

def process_digits(n)
  ans = ""

  if n.to_s.length == 1 or n == 10
    ans = digit_to_word(n) if n!=10
    ans = "ten" if n==10
  elsif n.to_s.length == 2 or n == 100
    ans = ten_digit_to_word(n).gsub(/-zero/, "") if n!=100
    ans = "one handred" if n==100
  elsif n.to_s.length == 3
    h_digit = n.to_s[0]
    ans << digit_to_word(h_digit.to_i)
    ans << " handred"

    ans << " and " if n % 100 != 0

    x = n.to_s[1,2].gsub(/^0/,"").to_i
    if x == 10
      ans << "ten"
    elsif x > 10
      ans << ten_digit_to_word(x).gsub(/-zero/, "")
    else
      ans << digit_to_word(x).gsub(/zero/, "")
    end
  else
    ans = "one thousand"
  end
  ans
end

numbers = []

1.upto(1000) do |n|
  numbers << process_digits(n)
end

s = 0

numbers.each_with_index do |number,idx|
  len = number.gsub(/-/,"").delete(' ').length
  s = s + len
  puts "#{idx+1},#{number}:\t #{len} sum => #{s}"
end
