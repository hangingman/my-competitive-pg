lines = <<'EOS'
1
2 100 100
EOS

#lines = $stdin.read
array = lines.split("\n")

N   = array[0].to_i
ans = true

pos  = [0,0]
before_time = 0

array[1..N+1].each_with_index do |str,i|

  next_time, next_x, next_y = str.split(" ").map(&:to_i)
  dist_x = [pos.first, next_x].max - [pos.first, next_x].min
  dist_y = [pos.last , next_y].max - [pos.last,  next_y].min
  dist = dist_x + dist_y
  time = next_time - before_time

  puts "s[#{pos.first},#{pos.last}]=>d[#{next_x},#{next_y}] = dist #{dist} with time = #{time}"

  if time < dist
    puts "No"
    exit 0
  elsif time == dist
    # just in time
    pos,before_time = [next_x, next_y],next_time
    next
  elsif i+1 == N and time >= dist
    next
  else
    # time > dist
    rest = time - dist
    if rest % 2 == 0
      pos = [next_x, next_y]
      next
    else
      puts "No"
      exit 0
    end
  end
end

puts "Yes"
