lines = <<'EOS'
17 2 34
EOS

#lines = $stdin.read
array = lines.split("\n")

R,G,B = array[0].split(" ").map(&:to_i)
INF   = 1 << 25

dp  = Array.new(2001).map{ Array.new(903, 0) }
sum = 0
sum = R+G+B

# for i in 0..2000
#   for j in 0..sum+1
#     dp[i][j] = 0
#   end
# end

for i in 1..2000
  for j in 1..sum+1
    marble = 0

    if j <= R
      marble = (i-900).abs
    elsif j <= R+G
      marble = (i-1000).abs
    else
      marble = (i-1100).abs
    end

    #puts "dp[#{i}][#{j}], marble=#{marble}"

    dp[i][j] = [ dp[i - 1][j - 1] + marble, dp[i - 1][j] ].min
  end
end

puts dp.max
