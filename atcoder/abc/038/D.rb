lines = <<'EOS'
5
8 8
5 3
2 2
4 2
2 1
EOS

#lines = $stdin.read
INF = 100000000

array = lines.split("\n")
N = array[0].to_i
boxes = array[1..N].map do |str|
  arr = str.split(" ").map(&:to_i)
  Hash[*arr]
end.sort_by do |e|
  key,val = e.first
  [key,-val]
end

dp = Array.new(N,INF)
#p boxes

boxes.each_with_index do |m,i|
  k,v = m.first.to_a[0],m.first.to_a[1]
  idx = dp.bsearch_index do |h|
    v < h+1
  end
  if not idx.nil?
    dp[idx] = v
  end
end

#p dp
ans = dp.bsearch_index{|h| h == INF}
ans ||= N
puts ans
