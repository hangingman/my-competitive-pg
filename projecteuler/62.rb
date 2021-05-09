


cubes = (1..10**5).to_a.map do |n|
  n**3
end.group_by do |n|
  n.to_s.split("").sort.join
end.to_a

cubes.select do |elem|
  elem[1].size.to_i == 5
end.take(1).each do |elem|
  p elem
end
