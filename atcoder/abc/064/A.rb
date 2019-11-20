#lines = <<'EOS'
#2 3 4
#EOS

lines = $stdin.read
array = lines.split("\n")
r = array[0].split(" ")[0]
g = array[0].split(" ")[1]
b = array[0].split(" ")[2]

S = r + g + b

#puts S.to_i

if S.to_i % 4 == 0
  puts "YES"
else
  puts "NO"
end
