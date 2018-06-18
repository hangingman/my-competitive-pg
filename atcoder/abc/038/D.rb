lines = <<'EOS'
5
8 8
5 3
2 2
4 2
2 1
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
boxes = array[1..N].map do |str|
  arr = str.split(" ").map(&:to_i)
  Hash[*arr]
end.sort_by {|k, v| k.first }

p boxes
dp = Array.new(N).map{Array.new(N, 0)}
puts ""

# dp[i]:=max(dp[j])+1
# if boxes[i] > boxes[j]
for row in 0...dp.length
  for col in row...dp.length
    if col == row
      dp[row][col] = 1
    else
      bef = boxes[col-1]
      cur = boxes[col]
      puts "bef #{bef}"
      puts "cur #{cur}"
      if bef.keys.first < cur.keys.first and bef.values.first < cur.values.first
        dp[row][col] = [dp[row].max, dp[row].max + 1].max
      end
    end
    p dp[row]
  end
end

for idx in 0...dp.length
  puts "[#{idx}] #{dp[idx]}"
end

p dp.map{|row| row.last}.max
