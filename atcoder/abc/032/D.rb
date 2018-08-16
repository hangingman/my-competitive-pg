lines = <<'EOS'
3 10
15 9
10 6
6 4
EOS

#lines = $stdin.read
array = lines.split("\n")
N,W  = array[0].split(" ").map(&:to_i)
item = array[1..N+1].map do |str|
  str.split(" ").map(&:to_i)
end

# item = {v, w}
#p item

tmp_h = {}
tmp_a = []

s = 0
S1 = item[0...N/2]
s,len = 0,S1.length
while s < (1<<N/2)
  a = s.to_s(2)
        .rjust(len,'0')
        .split("")
        .map(&:to_i)

  tmp_h = {:v => 0, :w => 0}

  S1.zip(a).each do |test|
    i,bit = test.first,test.last
    if bit==1
      #puts "item=#{i},#{bit}"
      tmp_h[:v] += i.first
      tmp_h[:w] += i.last
    end
  end

  tmp_a << tmp_h if tmp_h[:w] <= W
  s += 1
end

tmp_b = []

S2 = item[N/2...N]
s,len = 0,S2.length
while s < (1<<N-(N/2))
  a = s.to_s(2)
        .rjust(len,'0')
        .split("")
        .map(&:to_i)

  tmp_h = {:v => 0, :w => 0}

  S2.zip(a).each do |test|
    i,bit = test.first,test.last
    if bit==1
      #puts "item=#{i},#{bit}"
      tmp_h[:v] += i.first
      tmp_h[:w] += i.last
    end
  end

  tmp_b << tmp_h if tmp_h[:w] <= W
  s += 1
end

ans_v = 0

tmp_a = tmp_a.sort_by{|m| -m[:v]}
tmp_b = tmp_b.sort_by{|m| -m[:v]}

tmp_a.sort_by{|m| -m[:v]}.each do |h|
  test = tmp_b.select do |e|
    h[:w] + e[:w] <= W
  end.max_by do |e|
    e[:v]
  end
  # p h
  # p test
  # p tmp_b
  # puts "---"
  possible = h[:v]+test[:v]
  ans_v = possible if possible>ans_v
end

puts ans_v
