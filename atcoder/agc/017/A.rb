# coding: utf-8
require 'set'

lines = <<'EOS'
45 1
17 55 85 55 74 20 90 67 40 70 39 89 91 50 16 24 14 43 24 66 25 9 89 71 41 16 53 13 61 15 85 72 62 67 42 26 36 66 4 87 59 91 4 25 26
EOS

#lines = $stdin.read

array = lines.split("\n")

N,P = array[0].split(" ").map(&:to_i)
a   = array[1].split(" ").map(&:to_i)


puts a.sort!.to_s

b = a.map{|e| e % 2}
puts b.sort!.to_s

# (偶数) + (偶数) = (偶数)



puts (P==1) ? "奇数" : "偶数"

ans = 0

for i in 1...N
  arr = b.combination(i).map do |e|
    odd = e.count{|item| item % 2 == 0}
    evn = e.size - odd
    if evn == odd or evn > odd
      # (偶数) + (奇数) = (奇数)
      1
    else
      # (奇数) + (奇数) = (偶数)
      0
    end
  end
  ans += arr.count{|item| item == P}
  puts ans
end

puts ans
