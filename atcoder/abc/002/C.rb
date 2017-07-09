lines = $stdin.read
array = lines.split("\n")

xa = array[0].split(" ")[0].to_f
ya = array[0].split(" ")[1].to_f
xb = array[0].split(" ")[2].to_f
yb = array[0].split(" ")[3].to_f
xc = array[0].split(" ")[4].to_f
yc = array[0].split(" ")[5].to_f

puts (xa*yb + xb*yc + xc*ya - ya*xb - yb*xc - yc*xa).abs/2
