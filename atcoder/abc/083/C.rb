lines = <<'EOS'
25 100
EOS

#lines = $stdin.read
array = lines.split("\n")

X,Y = array[0].split(" ").map(&:to_i)

binarr = (1..56).to_a.map{|b| 2**b}

xarr = binarr.map{|a| a*X}

puts 1 + xarr.index{|x| x > Y}
