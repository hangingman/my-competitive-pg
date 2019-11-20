lines = $stdin.read
array = lines.split("\n")

X = array[0].split(" ")[0].to_i
A = array[0].split(" ")[1].to_i
B = array[0].split(" ")[2].to_i

if (B - A) < 1
  puts "delicious"
elsif (B - A) < X+1
  puts "safe"
else
  puts "dangerous"
end
