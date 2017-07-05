lines = $stdin.read

array = lines.split("\n")
n     = array[0]
lp    = 0
rp    = 0

for i in 1..n.to_i
  lr = array[i].split(" ")
  lr.sort!

  if lr[0] == lr[1]
    rp += 1
    lp += 1
  elsif lr[1] == array[i].split(" ")[1]
    rp += 3
  else
    lp += 3
  end
end

puts "#{lp} #{rp}"
