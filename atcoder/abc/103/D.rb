lines = <<'EOS'
5 10
1 2
1 3
1 4
1 5
2 3
2 4
2 5
3 4
3 5
4 5
EOS

#lines = $stdin.read
array = lines.split("\n")
N,M = array[0].split(" ").map(&:to_i)

cumsum = Array.new(M).map{Array.new(N,0)}

array[1..M].each_with_index do |str,idx|
  a,b = str.split(" ").map(&:to_i).map{|i| i-1}
  for jdx in a..b
    cumsum[idx][jdx] = 1
  end
end

cumsum.each{|sum| p sum}
