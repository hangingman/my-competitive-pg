lines = $stdin.read
array = lines.split("\n")

a = array[0].split(" ")[0].to_i
b = array[0].split(" ")[1].to_i

if a+b >= 10
  puts "error"
else
  puts "#{a+b}"
end
