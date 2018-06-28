lines = <<'EOS'
1 1000000000000000000
EOS

#lines = $stdin.read
array = lines.split("\n")
A,B = array[0].split(" ")

def calc_digit_sum(a)
  n = a.length

  dp = Array.new(18+2).map do
    Array.new(2).map do
      Array.new(2,0)
    end
  end # pos, less, has4

  #dp[0][0][0][0] = 1
  dp[0][0][0] = 1

  for i in 0...n
    for j in 0...2
      for k in 0...2
        #for l in 0...2
          lim = j.zero? ? a[i] : 9
          for d in 0...lim+1
            less,has4or9 = 0,0

            less = 1 if not j.zero? or d < lim
            has4or9 = 1 if not k.zero? or (d == 4 or d == 9)
            dp[i+1][less][has4or9] += dp[i][j][k]
          end
        #end
      end
    end
  end

  ans = 0
  for j in 0...2
    ans += dp[n][j][1]
  end
  ans
end

a = (A.to_i-1).to_s.split("").map(&:to_i).to_a
b = B.split("").map(&:to_i).to_a

# puts calc_digit_sum(b)
# puts calc_digit_sum(a)
puts calc_digit_sum(b) - calc_digit_sum(a)
