lines = <<'EOS'
5
1 1 1 1 1
EOS

#lines = $stdin.read
array = lines.split("\n")
N = array[0].to_i
A = array[1].split(" ").map(&:to_i)
@b = Array.new(N, 0)

def ball_count(ai)
  count = 0
  k = 1

  loop {
    aik = ai*k
    break if aik > N

    #puts "#{ai} , aik = #{aik}, N=#{N}"
    count += @b[aik-1]
    k += 1

    count
  }
  return count
end

(N).downto(1) do |ai|
  balls = ball_count(ai)

  #puts "balls=#{balls}, ai = #{A[ai-1]}"
  if (A[ai-1].even? and balls.odd?) or (A[ai-1].odd? and balls.even?)
    @b[ai-1] = 1
  end
end

count = @b.count{|b| b==1}
boxes = @b.map.with_index{|b,idx| [idx+1,b]}.to_h.select{|k,v| v==1}.map{|k,_| k}

if count != boxes.size
  puts "-1"
  exit 0
end
if count == 0
  puts 0
  exit 0
end

puts count
puts boxes.join(" ")
