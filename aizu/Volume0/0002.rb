lines = $stdin.read

array = lines.split("\n")

array.map do |e|
  a,b = e.split(" ").map(&:to_i)
  c = (a+b).to_s
  puts c.length
end
