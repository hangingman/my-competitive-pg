# coding: utf-8


def make_divisors(n)
    divisors = []
    for i in 1..((n**0.5)+1).to_i
        if n % i == 0
            divisors << i
            if i != n / i
                divisors << n/i
            end
        end
    end
    divisors.uniq.sort
end

# deficient = 不足数, abundant = 過剰数
abundant, deficient = [], []

(1..28123).to_a.each do |n|
  # puts "#{n} = #{make_divisors(n).inject(&:+) - n}"
  proper_divisor = make_divisors(n).inject(&:+) - n

  if proper_divisor > n
    # puts "n=#{n}, #{make_divisors(n)} => #{proper_divisor} ab"
    abundant << n
  elsif n == proper_divisor
    # NOP
  else
    # puts "n=#{n}, #{make_divisors(n)} => #{proper_divisor} df"
    deficient << n
  end
end

# 2つの過剰数の和で書き表せない正の整数の総和を求めよ, なので
# 2つの過剰数の和で書き表せる正の整数の総和を求めて、全体から引く
ans = []
abundant.repeated_permutation(2) do |arr|
  sum = arr.inject(&:+)
  ans << sum if sum <= 28123
end
ans.uniq!

p abundant.size
p ans.size
p (0..28123).inject(&:+) - ans.inject(&:+)
