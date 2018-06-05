# coding: utf-8
lines = <<'EOS'
32
29 19 7 10 26 32 27 4 11 20 2 8 16 23 5 14 6 12 17 22 18 30 28 24 15 1 25 3 13 21 19 31 9
EOS

require 'set'
MOD = 1_000_000_007

#lines = $stdin.read
array = lines.split("\n")

N  = array[0].to_i
a  = array[1].split(" ").map(&:to_i)
cols = a.length

dp = Array.new(N+1).map{ Array.new(a.length, 0) }
st = Set.new

# 1行目
a.each_with_index do |elem, col_idx|
  if st.include? elem
    dp[0][col_idx] = 0
  else
    st.add(elem)
    dp[0][col_idx] = 1
  end
end

(1..N).each do |n|
  (0...cols).each do |col|
    # puts "#{n} => #{col}"
    if col < n
      dp[n][col] = 0
    else
      # p dp[n-1].take(col-1).inject(:+).to_i
      dp[n][col] = dp[n-1].take(col).inject(:+).to_i
    end
  end
end

# puts "  #{a}"
# dp.each_with_index do |edit, row_idx|
#   puts "#{row_idx} #{edit}"
# end

dp.each{|elem| puts (elem.inject(:+) % MOD) }
