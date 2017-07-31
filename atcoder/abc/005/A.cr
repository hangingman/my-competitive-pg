#lines = <<-EOS
#4 3
#EOS

array = STDIN.each_line.map(&.to_s).to_a
x,y = array[0].split(" ").map(&.to_i)
puts y/x
