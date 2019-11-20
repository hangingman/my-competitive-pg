lines = $stdin.read
array = lines.split("\n")
A,B = array[0].split(" ").map(&:to_i)
ans = false

for c in 1..3
  ans = true if (A*B*c).odd?
end

if ans
  puts 'Yes'
else
  puts 'No'
end
