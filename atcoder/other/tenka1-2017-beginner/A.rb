lines = $stdin.read
array = lines.split("\n")

count = 0

array[0].to_s.split("").map do |s|
  count = count + 1 if s == '1'
end

puts count
