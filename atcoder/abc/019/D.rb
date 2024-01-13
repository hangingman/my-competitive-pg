N = gets.to_i

max = 0
max_v = 0

for v in 2..N
  puts "? 1 #{v}"
  STDOUT.flush
  w = gets.to_i
  if w > max
    max = w
    max_v = v
  end
end

ans = 0
for u in 1..N
  next if u==max_v

  puts "? #{max_v} #{u}"
  STDOUT.flush
  w = gets.to_i
  ans = [ans, w].max
end

puts "! #{ans}"
