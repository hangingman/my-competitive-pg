lines = <<'EOS'
3 4
1 3 2
3 4 4
1 4 3
EOS

#lines = $stdin.read
array = lines.split("\n")

N,C = array[0].split(" ").map(&:to_i)

sr = array[1..N].map.with_index do |time,i|
  s,t,c = time.split(" ").map(&:to_i)

  blank  = 0.step(s-0.5, 0.5).to_a.map{|n| 0}
  record = s.step(t, 0.5).to_a.map{|n| 1}
  blank.concat(record)
end

max_length = 0

for i in 0...sr.length
  len = sr[i].length
  max_length = len if len >= max_length
end

table = Array.new(max_length, 0)

puts sr[0].to_s
puts sr[1].to_s
puts sr[2].to_s

for sr_idx in 0..max_length
  table[sr_idx] = 0
  for idx in 0...sr.length
    table[sr_idx] += sr[idx]
  end
end

puts table.to_s
