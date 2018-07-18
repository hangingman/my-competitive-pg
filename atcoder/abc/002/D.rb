# coding: utf-8
lines = <<'EOS'
7 9
1 2
1 3
2 3
4 5
4 6
4 7
5 6
5 7
6 7
EOS

#lines = $stdin.read
array = lines.split("\n")
N,M   = array[0].split(" ").map(&:to_i)

table = Array.new(13).map{Array.new(13,false)}

array[1..M].each do |str|
  x,y = str.split(" ").map(&:to_i)
  table[x][y] = true
  table[y][x] = true
end

ans = (0..N).map{|e| [e]}

#p ans

(1..N).each do |from|
  (1..N).each do |to|
    # p ans[from]
    if table[from][to] and ans[from].all?{|f| table[f][to]}
      ans[from] << to
    end
  end
end

#p ans
puts ans.map{|arr| arr.length}.max
