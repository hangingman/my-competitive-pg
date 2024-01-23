lines = <<'EOS'
1 1
1
1
EOS

#lines = $stdin.read
array = lines.split("\n")
H,W = array[0].split(" ").map(&:to_i)
N = array[1].to_i
A = array[2].split(" ").map(&:to_i)

a = A.map.with_index(1).sort_by do |e, idx|
  -idx
end.map do |e, idx|
  [idx]*e
end.flatten

a.each_slice(W).with_index do |cols,idx|
  line = if idx.even?
           cols.join(" ")
         else
           cols.reverse.join(" ")
         end
  puts line
end
