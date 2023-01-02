lines = <<'EOS'
10 0
10 -80 21
23 8 38
-94 28 11
-26 -2 18
-69 72 79
-26 -86 -54
-72 -50 59
21 65 -32
40 -94 87
-62 18 82
EOS

#lines = $stdin.read
array = lines.split("\n")


N,M = array[0].split(" ").map(&:to_i)

ans = 0

['+', '-'].each do |x_op|
  ['+', '-'].each do |y_op|
    ['+', '-'].each do |z_op|

      #puts "* #{x_op}, #{y_op}, #{z_op}"
      cakes = array[1..N+1].map do |line|
        x,y,z =line.split(" ").map(&:to_i)

        x = "#{x_op}1".to_i * x
        y = "#{y_op}1".to_i * y
        z = "#{z_op}1".to_i * z
        tmp = x+y+z
        #puts "#{tmp} = #{x} + #{y} + #{z}"
        tmp
      end.sort{|cl,cr| cr <=> cl}

      #puts ""
      #p cakes.take(M)
      ans = [cakes.take(M).map{|c| c}.inject(&:+).to_i, ans].max
    end
  end
end

puts ans
