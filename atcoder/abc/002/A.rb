lines = $stdin.read
array = lines.split("\n")

X = array[0].split(" ")[0].to_i
Y = array[0].split(" ")[1].to_i

if X > Y
  puts X
else
  puts Y
end
